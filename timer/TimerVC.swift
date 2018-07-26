//
//  ViewController.swift
//  timer
//
//  Created by Tsang Ka Kui on 25/7/2018.
//  Copyright © 2018年 Tsang Ka Kui. All rights reserved.
//

import UIKit
import RealmSwift

final class TimerVC: UIViewController {
    
    private let countDownTimer = CountDownTimer()
    private let infoButton = UIImageView()
    private let historyButton = UIImageView()
    private let taskNameTextField = UITextField()
    private var timerView: TimerView!
    private let buttonsStackView = UIStackView()
    private let startButton = UIButton()
    private let stopButton = UIButton()
    private let doneButton = UIButton()
    private var taskName = ""

    override func viewDidLoad() {
        super.viewDidLoad()
        createGradientLayer()
        setupViews()
        setupActions()
    }
    
    override func viewDidLayoutSubviews() {
        timerView.createCircleStrokeLayer()
        timerView.createProgressLayer()
    }
    
    private func createGradientLayer() {
        let startColor = UIColor(red: 255/255, green: 194/255, blue: 93/255, alpha: 1)
        let stopColor = UIColor(red: 250/255, green: 93/255, blue: 70/255, alpha: 1)
        let gradientLayer = CAGradientLayer()
        gradientLayer.frame = self.view.bounds
        gradientLayer.colors = [startColor.cgColor, stopColor.cgColor]
        view.layer.addSublayer(gradientLayer)
    }
    
    private func setupViews() {
        let imageViewSize: CGFloat = 32
        let sideMargins: CGFloat = 16
        let buttons = [stopButton, startButton, doneButton]
        
        timerView = TimerView(countDownTimer: countDownTimer)
        
        infoButton.image = UIImage(named: "info")
        historyButton.image = UIImage(named: "history")
        taskNameTextField.delegate = self
        taskNameTextField.textColor = UIColor.white
        taskNameTextField.font = UIFont.systemFont(ofSize: 22.0)
        taskNameTextField.textAlignment = NSTextAlignment.center
        taskNameTextField.attributedPlaceholder = NSAttributedString(string: "Enter task...",
                                                                     attributes: [NSAttributedStringKey.foregroundColor: UIColor.white])
        
        startButton.setImage(UIImage(named: "start"), for: .normal)
        stopButton.setImage(UIImage(named: "stop"), for: .normal)
        doneButton.setImage(UIImage(named: "done"), for: .normal)
        buttonsStackView.axis = .horizontal
        buttonsStackView.alignment = .fill
        buttonsStackView.distribution = .fillEqually
        buttons.forEach(buttonsStackView.addArrangedSubview)
        
        view.addSubview(infoButton)
        infoButton.translatesAutoresizingMaskIntoConstraints = false
        infoButton.widthAnchor.constraint(equalToConstant: imageViewSize).isActive = true
        infoButton.heightAnchor.constraint(equalToConstant: imageViewSize).isActive = true
        infoButton.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: sideMargins).isActive = true
        infoButton.topAnchor.constraint(equalTo: topLayoutGuide.bottomAnchor, constant: sideMargins).isActive = true
        
        view.addSubview(historyButton)
        historyButton.translatesAutoresizingMaskIntoConstraints = false
        historyButton.widthAnchor.constraint(equalToConstant: imageViewSize).isActive = true
        historyButton.heightAnchor.constraint(equalToConstant: imageViewSize).isActive = true
        historyButton.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -sideMargins).isActive = true
        historyButton.topAnchor.constraint(equalTo: topLayoutGuide.bottomAnchor, constant: sideMargins).isActive = true
        
        view.addSubview(timerView)
        timerView.translatesAutoresizingMaskIntoConstraints = false
        timerView.widthAnchor.constraint(equalToConstant: view.bounds.height * 0.4).isActive = true
        timerView.heightAnchor.constraint(equalTo: view.heightAnchor, multiplier: 0.4).isActive = true
        timerView.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        timerView.centerYAnchor.constraint(equalTo: view.centerYAnchor, constant: 10).isActive = true
        
        view.addSubview(taskNameTextField)
        taskNameTextField.translatesAutoresizingMaskIntoConstraints = false
        taskNameTextField.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: sideMargins).isActive = true
        taskNameTextField.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -sideMargins).isActive = true
        taskNameTextField.bottomAnchor.constraint(equalTo: timerView.topAnchor, constant: -50).isActive = true
        
        view.addSubview(buttonsStackView)
        buttonsStackView.translatesAutoresizingMaskIntoConstraints = false
        buttonsStackView.heightAnchor.constraint(equalToConstant: 60).isActive = true
        buttonsStackView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: sideMargins).isActive = true
        buttonsStackView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -sideMargins).isActive = true
        buttonsStackView.topAnchor.constraint(equalTo: timerView.bottomAnchor, constant: 50).isActive = true
    }
    
    private func setupActions() {
        startButton.addTarget(self, action: #selector(startTimer), for: .touchUpInside)
        stopButton.addTarget(self, action: #selector(stopTimer), for: .touchUpInside)
        doneButton.addTarget(self, action: #selector(taskDone), for: .touchUpInside)
        
        let tapGesture1 = UITapGestureRecognizer(target: self, action: #selector(routeToPersonnel))
        infoButton.isUserInteractionEnabled = true
        infoButton.addGestureRecognizer(tapGesture1)
        
        let tapGesture2 = UITapGestureRecognizer(target: self, action: #selector(routeToHistory))
        historyButton.isUserInteractionEnabled = true
        historyButton.addGestureRecognizer(tapGesture2)
    }
    
    @objc private func startTimer() {
        countDownTimer.startTimer()
    }
    
    @objc private func stopTimer() {
        countDownTimer.stopTimer()
    }
    
    @objc private func taskDone() {
        countDownTimer.stopTimer()
        saveTask()
        countDownTimer.resetTimer()
        timerView.updateTimerView()
        taskNameTextField.text = nil
    }
    
    @objc private func routeToPersonnel() {
        let personnelVC = PersonnelVC()
        let vc = UINavigationController(rootViewController: personnelVC)
        present(vc, animated: true, completion: nil)
    }
    
    @objc private func routeToHistory() {
        let historyVC = HistoryVC()
        let vc = UINavigationController(rootViewController: historyVC)
        present(vc, animated: true, completion: nil)
    }
    
    private func saveTask() {
        let task = Task()
        task.name = taskName
        task.timeSpent = countDownTimer.getCountedTimeString()
        let realm = try! Realm()
        try! realm.write {
            realm.add(task)
        }
    }

}

extension TimerVC: UITextFieldDelegate {
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        taskName = textField.text ?? ""
        textField.resignFirstResponder()
        return true
    }
    
}




