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
        let alarm = Alarm(cronExpression: try! CRONExpression(), isActive: true)

        XCTAssert(alarm.description == "")
    }
    
    func testDefaultsToActiveAlarm() {
        let alarm = Alarm(cronExpression: try! CRONExpression(),
                          description: "Should be active")

        XCTAssertTrue(alarm.isActive)
    }

    func testConformsToEquatableProtocol() {
        let alarm1 = Alarm(cronExpression: try! CRONExpression())
        let alarm2 = Alarm(cronExpression: try! CRONExpression())

        XCTAssert(alarm1 == alarm2)
    }
    
    func testExpectedTimeReturnedFromAlarm() {
        let foreverAndAlwaysAlarm = Alarm(cronExpression: try! CRONExpression())
        XCTAssert(foreverAndAlwaysAlarm.time == "**:**")

        let sevenFifteenAlarm = Alarm(cronExpression: try! CRONExpression(minute: 15, hour: 7))
        XCTAssert(sevenFifteenAlarm.time == "7:15")
        
        let noonAlarm = Alarm(cronExpression: try! CRONExpression(minute: 0, hour: 12))
        XCTAssert(noonAlarm.time == "12:00")
        
        let afternoonAlarm = Alarm(cronExpression: try! CRONExpression(minute: 30, hour: 15))
        XCTAssert(afternoonAlarm.time == "3:30")
    }
    
    func testExpectedPeriodReturnedFromAlarm() {
        let foreverAndAlwaysAlarm = Alarm(cronExpression: try! CRONExpression())
        XCTAssertNil(foreverAndAlwaysAlarm.period)

        let sevenFifteenAlarm = Alarm(cronExpression: try! CRONExpression(minute: 15, hour: 7))
        XCTAssert(sevenFifteenAlarm.period == .AM)
        
        let noonAlarm = Alarm(cronExpression: try! CRONExpression(minute: 0, hour: 12))
        XCTAssert(noonAlarm.period == .PM)
        
        let afternoonAlarm = Alarm(cronExpression: try! CRONExpression(minute: 30, hour: 15))
        XCTAssert(afternoonAlarm.period == .PM)
    }
}
