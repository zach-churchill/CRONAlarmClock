//
//  AlarmTests.swift
//  CRONAlarmClockTests
//
//  Created by Zachary Churchill on 10/8/20.
//

import XCTest
@testable import CRONAlarmClock

class AlarmTests: XCTestCase {

    func testDefaultsToBlankDescription() {
        let alarm = Alarm(time: "7:15", period: .AM, isActive: true)
        
        XCTAssert(alarm.description == "")
    }
    
    func testDefaultsToActiveAlarm() {
        let alarm = Alarm(time: "7:15",
                          period: .AM,
                          description: "Should be active")
        
        XCTAssertTrue(alarm.isActive)
    }

    func testConformsToEquatableProtocol() {
        let alarm1 = Alarm(time: "7:15", period: .AM)
        let alarm2 = Alarm(time: "7:15", period: .AM)
        
        XCTAssert(alarm1 == alarm2)
    }
}
