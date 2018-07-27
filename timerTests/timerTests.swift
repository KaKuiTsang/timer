//
//  timerTests.swift
//  timerTests
//
//  Created by Tsang Ka Kui on 25/7/2018.
//  Copyright © 2018年 Tsang Ka Kui. All rights reserved.
//

import XCTest
@testable import timer

class timerTests: XCTestCase {
    
    private var timer: CountDownTimer?
    
    override func setUp() {
        super.setUp()
        timer = CountDownTimer()
    }
    
    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        super.tearDown()
        timer = nil
    }
    
    func testTimerIncrease() {
        timer?.increaseTime()
        let timerString1 = timer?.getTargetTimeString()
        XCTAssertEqual(timerString1, "02 : 00", "timer increase fuction test fail - incorrect target time")
        
        for _ in 1...70 {
            timer?.increaseTime()
        }
        let timerString2 = timer?.getTargetTimeString()
        XCTAssertEqual(timerString2, "60 : 00", "timer increase fuction test fail - exceed the max value")
    }
    
    func testTimerDecrease() {
        timer?.decreaseTime()
        let timerString1 = timer?.getTargetTimeString()
        XCTAssertEqual(timerString1, "01 : 00", "timer decrease fuction test fail - exceed the min value")
        
        timer?.increaseTime()
        timer?.decreaseTime()
        let timerString2 = timer?.getTargetTimeString()
        XCTAssertEqual(timerString2, "01 : 00", "timer increase fuction test fail - incorrect target time")
    }
    
    func testTimerReset() {
        timer?.resetTimer()
        XCTAssertEqual(timer?.isTimerStarted, false, "timer reset fuction test fail - isTimerStarted not reset to default")
        XCTAssertEqual(timer?.targetTime, 60.0, "timer reset fuction test fail - targetTime not reset to default")
        XCTAssertEqual(timer?.countedTime, 0.0, "timer reset fuction test fail - countedTime not reset to default")
    }
}
