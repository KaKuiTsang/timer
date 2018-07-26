//
//  ViewController.swift
//  timer
//
//  Created by Tsang Ka Kui on 25/7/2018.
//  Copyright © 2018年 Tsang Ka Kui. All rights reserved.
//

import UIKit

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

    override func viewDidLoad() {
        super.viewDidLoad()
        createGradientLayer()
        setupViews()
        setupActions()
    }
    
    override func viewDidLayoutSubviews() {
        timerView.createCircleStrokeLayer()
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
    }
    
    @objc private func startTimer() {
        print("start timer")
        countDownTimer.startTimer()
    }
    
    @objc private func stopTimer() {
        countDownTimer.stopTimer()
    }
}

extension TimerVC: UITextFieldDelegate {
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
    
}

final class TimerView: UIView {
    
    private var countDownTimer: CountDownTimer!
    
    private let isTimeLabelEditable = true
    
    private let timeLabel = UILabel()
    
    private let increaseButton = UIButton()
    
    private let decreaseButton = UIButton()
    
    init(countDownTimer: CountDownTimer) {
        super.init(frame: CGRect.zero)
        self.countDownTimer = countDownTimer
        setupViews()
        setupActions()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupViews() {
        timeLabel.textColor = UIColor.white
        timeLabel.font = UIFont.systemFont(ofSize: 36)
        timeLabel.textAlignment = NSTextAlignment.center
        timeLabel.text = countDownTimer.getTargetTimeString()
        timeLabel.translatesAutoresizingMaskIntoConstraints = false

        increaseButton.setImage(UIImage(named: "up"), for: .normal)
        increaseButton.translatesAutoresizingMaskIntoConstraints = false
        //increaseButton.backgroundColor = UIColor.black
        
        decreaseButton.setImage(UIImage(named: "down"), for: .normal)
        decreaseButton.translatesAutoresizingMaskIntoConstraints = false
        //decreateButton.backgroundColor = UIColor.black
        
        self.addSubview(timeLabel)
        timeLabel.centerYAnchor.constraint(equalTo: self.centerYAnchor).isActive = true
        timeLabel.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 24).isActive = true
        timeLabel.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -24).isActive = true
        
        self.addSubview(increaseButton)
        increaseButton.centerXAnchor.constraint(equalTo: self.centerXAnchor).isActive = true
        increaseButton.widthAnchor.constraint(equalTo: self.widthAnchor, multiplier: 0.15).isActive = true
        increaseButton.heightAnchor.constraint(equalTo: self.widthAnchor, multiplier: 0.15).isActive = true
        increaseButton.bottomAnchor.constraint(equalTo: timeLabel.topAnchor, constant: -28).isActive = true
        
        self.addSubview(decreaseButton)
        decreaseButton.centerXAnchor.constraint(equalTo: self.centerXAnchor).isActive = true
        decreaseButton.widthAnchor.constraint(equalTo: self.widthAnchor, multiplier: 0.15).isActive = true
        decreaseButton.heightAnchor.constraint(equalTo: self.widthAnchor, multiplier: 0.15).isActive = true
        decreaseButton.topAnchor.constraint(equalTo: timeLabel.bottomAnchor, constant: 28).isActive = true
    }
    
    private func setupActions() {
        increaseButton.addTarget(self, action: #selector(increaseTime), for: .touchUpInside)
        decreaseButton.addTarget(self, action: #selector(decreaseTime), for: .touchUpInside)
    }
    
    func createCircleStrokeLayer() {
        let circleLayer = CAShapeLayer()
        circleLayer.path = UIBezierPath(ovalIn: CGRect(x: 0, y: 0, width: self.frame.width, height: self.frame.height)).cgPath
        circleLayer.strokeColor = UIColor.white.cgColor
        circleLayer.fillColor = UIColor.clear.cgColor
        circleLayer.lineWidth = 2.0
        self.layer.addSublayer(circleLayer)
    }
    
    @objc private func increaseTime() {
        countDownTimer.increaseTime()
        timeLabel.text = countDownTimer.getTargetTimeString()
    }
    
    @objc private func decreaseTime() {
        countDownTimer.decreaseTime()
        timeLabel.text = countDownTimer.getTargetTimeString()
    }
}


final class CountDownTimer {
    
    private let maxTime = 3600
    
    private let minTime = 60
    
    private var targetTime = 60
    
    private var countedTime = 0
    
    private var timer: Timer!
    
    func increaseTime() {
        if targetTime < maxTime {
            targetTime += 60
        }
    }
    
    func decreaseTime() {
        if targetTime > minTime {
            targetTime -= 60
        }
    }
    
    func getTargetTimeString() -> String {
        let minutes = targetTime / 60
        return String(format: "%02i:%02i:%02i", minutes, 0, 0)
    }
    
    func startTimer() {
        print("create a timer")
        timer = Timer.scheduledTimer(timeInterval: 0.1, target: self, selector: #selector(countDown), userInfo: nil, repeats: true)
    }
    
    func stopTimer() {
        timer.invalidate()
    }
    
    @objc private func countDown() {
        print("counting")
    }

}





