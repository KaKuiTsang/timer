//
//  CountDownTImer.swift
//  timer
//
//  Created by Tsang Ka Kui on 26/7/2018.
//  Copyright © 2018年 Tsang Ka Kui. All rights reserved.
//

import Foundation

final class CountDownTimer {
    
    var delegate: TimerDelegate?
    
    private let maxTime = 3600.0
    
    private let minTime = 60.0
    
    private var targetTime = 60.0
    
    private var countedTime = 0.0
    
    private(set) var isTimerStarted = false
    
    private var timer: Timer?
    
    func increaseTime() {
        guard !isTimerStarted else { return }
        if targetTime < maxTime {
            targetTime += 60
        }
    }
    
    func decreaseTime() {
        guard !isTimerStarted else { return }
        if targetTime > minTime {
            targetTime -= 60
        }
    }
    
    private func getTimeString(time: Double) -> String {
        let minutes = Int(time) / 60
        let seconds = Int(time) % 60
        return String(format: "%02i : %02i", minutes, seconds)
    }
    
    func getTargetTimeString() -> String {
        return getTimeString(time: targetTime)
    }
    
    func getCountedTimeString() -> String {
        return getTimeString(time: countedTime)
    }
    
    func startTimer() {
        guard !isTimerStarted else { return }
        isTimerStarted = true
        timer = Timer.scheduledTimer(timeInterval: 0.01, target: self, selector: #selector(countDown), userInfo: nil, repeats: true)
    }
    
    func stopTimer() {
        guard isTimerStarted else { return }
        isTimerStarted = false
        timer?.invalidate()
    }
    
    func resetTimer() {
        isTimerStarted = false
        timer?.invalidate()
        targetTime = 60.0
        countedTime = 0.0
    }
    
    @objc private func countDown() {
        guard targetTime > 0 else {
            timer?.invalidate()
            return
        }
        
        targetTime -= 0.01
        countedTime += 0.01
        delegate?.updateTimerView()
    }
}
