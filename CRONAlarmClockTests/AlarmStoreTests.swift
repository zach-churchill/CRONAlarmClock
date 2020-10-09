//
//  AlarmStoreTests.swift
//  CRONAlarmClockTests
//
//  Created by Zachary Churchill on 10/8/20.
//

import XCTest
@testable import CRONAlarmClock

class AlarmStoreTests: XCTestCase {
    
    func testNoAlarmsUponInitialization() {
        let alarmStore = AlarmStore()
        XCTAssert(alarmStore.count == 0)
    }
    
    func testProvidesAbilityToAddAlarms() {
        let alarmStore = AlarmStore()
        let newAlarm = Alarm()
        
        XCTAssertNoThrow(alarmStore.addAlarm(newAlarm))
        XCTAssert(alarmStore.count == 1)
    }
    
    func testProvidesAbilityToRemoveAlarms() {
        let alarmStore = AlarmStore()
        let newAlarm = Alarm()
        
        alarmStore.addAlarm(newAlarm)
        
        XCTAssertNoThrow(alarmStore.removeAlarm(newAlarm))
        XCTAssertNil(alarmStore.firstIndex(of: newAlarm))
    }

    func testDoesNotThrowErrorWhenRemovingNonexistentAlarm() {
        let alarmStore = AlarmStore()
        let newAlarm = Alarm()
        
        XCTAssertNoThrow(alarmStore.removeAlarm(newAlarm))
    }
    
    func testGetAlarmProvidesCorrectResults() {
        let alarmStore = AlarmStore()
        let newAlarm = Alarm()
        
        XCTAssertNil(alarmStore.getAlarm(at: 0))
        
        alarmStore.addAlarm(newAlarm)
        XCTAssert(alarmStore.getAlarm(at: 0) == newAlarm)
    }

    func testFirstIndexProvidesCorrectResults() {
        let alarmStore = AlarmStore()
        let newAlarm = Alarm()
        
        XCTAssertNoThrow(alarmStore.firstIndex(of: newAlarm))
        XCTAssertNil(alarmStore.firstIndex(of: newAlarm))
        
        alarmStore.addAlarm(newAlarm)
        XCTAssert(alarmStore.firstIndex(of: newAlarm) == 0)
    }
}
