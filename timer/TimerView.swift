//
//  TimerView.swift
//  timer
//
//  Created by Tsang Ka Kui on 26/7/2018.
//  Copyright © 2018年 Tsang Ka Kui. All rights reserved.
//

import UIKit

protocol TimerDelegate: class {
    func updateTimerView()
    func updateProgress(progress: CGFloat)
}

final class TimerView: UIView, TimerDelegate {
    
    private var countDownTimer: CountDownTimer!
    
    private let isTimeLabelEditable = true
    
    private let timeLabel = UILabel()
    
    private let increaseButton = UIButton()
    
    private let decreaseButton = UIButton()
    
    private var progressLayer: CAShapeLayer!
    
    init(countDownTimer: CountDownTimer) {
        super.init(frame: CGRect.zero)
        self.countDownTimer = countDownTimer
        self.countDownTimer.delegate = self
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
        
        decreaseButton.setImage(UIImage(named: "down"), for: .normal)
        decreaseButton.translatesAutoresizingMaskIntoConstraints = false
        
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
    
    func createProgressLayer() {
        progressLayer = CAShapeLayer()
        let circlePath = UIBezierPath(arcCenter: CGPoint (x: self.frame.size.width / 2, y: self.frame.size.height / 2),
                                  radius: self.frame.size.width / 2,
                                  startAngle: CGFloat(-0.5 * Double.pi),
                                  endAngle: CGFloat(2.0 * Double.pi),
                                  clockwise: true)
        circlePath.lineCapStyle = .round
        progressLayer.path = circlePath.cgPath
        progressLayer.strokeColor = UIColor.white.cgColor
        progressLayer.fillColor = UIColor.clear.cgColor
        progressLayer.lineWidth = 6.0
        progressLayer.shadowColor = UIColor.white.cgColor
        progressLayer.shadowOpacity = 0.7
        progressLayer.shadowOffset = CGSize(width: 2, height: 2)
        progressLayer.shadowRadius = 10.0
        progressLayer.strokeStart = 0.0
        progressLayer.strokeEnd = 0.0
        self.layer.addSublayer(progressLayer)
    }
    
    @objc private func increaseTime() {
        countDownTimer.increaseTime()
        updateTimerView()
    }
    
    @objc private func decreaseTime() {
        countDownTimer.decreaseTime()
        updateTimerView()
    }
    
    func updateTimerView() {
        timeLabel.text = countDownTimer.getTargetTimeString()
    }
    
    func updateProgress(progress: CGFloat) {
        progressLayer.strokeEnd = progress
    }
}
