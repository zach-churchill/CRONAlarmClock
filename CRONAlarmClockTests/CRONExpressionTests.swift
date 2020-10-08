//
//  CRONExpressionTests.swift
//  CRONAlarmClockTests
//
//  Created by Zachary Churchill on 10/8/20.
//

import XCTest
@testable import CRONAlarmClock

class CRONExpressionTests: XCTestCase {

    func testComponentsDefaultToStars() throws {
        let cronExpression = try CRONExpression()
        
        XCTAssert(cronExpression.minute == CRONExpression.star)
        XCTAssert(cronExpression.hour == CRONExpression.star)
        XCTAssert(cronExpression.dayOfMonth == CRONExpression.star)
        XCTAssert(cronExpression.month == CRONExpression.star)
        XCTAssert(cronExpression.dayOfWeek == CRONExpression.star)
    }
    
    func testMinutesMustBeBetween0And59() {
        XCTAssertNoThrow(try CRONExpression(minute: 0))
        XCTAssertNoThrow(try CRONExpression(minute: 30))
        XCTAssertNoThrow(try CRONExpression(minute: 59))
        
        XCTAssertThrowsError(try CRONExpression(minute: -1))
        XCTAssertThrowsError(try CRONExpression(minute: 60))
    }

    func testHourMustBeBetween0And23() {
        XCTAssertNoThrow(try CRONExpression(hour: 0))
        XCTAssertNoThrow(try CRONExpression(hour: 12))
        XCTAssertNoThrow(try CRONExpression(hour: 23))
        
        XCTAssertThrowsError(try CRONExpression(hour: -1))
        XCTAssertThrowsError(try CRONExpression(hour: 24))
    }
    
    func testDayOfMonthMustBeBetween1And31() {
        XCTAssertNoThrow(try CRONExpression(dayOfMonth: 1))
        XCTAssertNoThrow(try CRONExpression(dayOfMonth: 15))
        XCTAssertNoThrow(try CRONExpression(dayOfMonth: 31))
        
        XCTAssertThrowsError(try CRONExpression(dayOfMonth: 0))
        XCTAssertThrowsError(try CRONExpression(dayOfMonth: 32))
    }
    
    func testMonthMustBeBetween1And12() {
        XCTAssertNoThrow(try CRONExpression(month: 1))
        XCTAssertNoThrow(try CRONExpression(month: 6))
        XCTAssertNoThrow(try CRONExpression(month: 12))
        
        XCTAssertThrowsError(try CRONExpression(month: 0))
        XCTAssertThrowsError(try CRONExpression(month: 13))
    }
    
    func testDayOfWeekMustBeBetween1And12() {
        XCTAssertNoThrow(try CRONExpression(dayOfWeek: 0))
        XCTAssertNoThrow(try CRONExpression(dayOfWeek: 3))
        XCTAssertNoThrow(try CRONExpression(dayOfWeek: 6))
        
        XCTAssertThrowsError(try CRONExpression(dayOfWeek: -1))
        XCTAssertThrowsError(try CRONExpression(dayOfWeek: 7))
    }
    
    func testStandardFormatProducesCorrectObject() {
        let foreverAndAlways = try! CRONExpression(fromExpression: "* * * * *")
        XCTAssert(foreverAndAlways.minute == CRONExpression.star)
        XCTAssert(foreverAndAlways.hour == CRONExpression.star)
        XCTAssert(foreverAndAlways.dayOfMonth == CRONExpression.star)
        XCTAssert(foreverAndAlways.month == CRONExpression.star)
        XCTAssert(foreverAndAlways.dayOfWeek == CRONExpression.star)
        
        let sevenFifteenEveryDay = try! CRONExpression(fromExpression: "15 7 * * *")
        XCTAssert(sevenFifteenEveryDay.minute == "15")
        XCTAssert(sevenFifteenEveryDay.hour == "7")
        XCTAssert(sevenFifteenEveryDay.dayOfMonth == CRONExpression.star)
        XCTAssert(sevenFifteenEveryDay.month == CRONExpression.star)
        XCTAssert(sevenFifteenEveryDay.dayOfWeek == CRONExpression.star)
        
        let noonOnFebruaryFifth = try! CRONExpression(fromExpression: "0 12 5 2 *")
        XCTAssert(noonOnFebruaryFifth.minute == "0")
        XCTAssert(noonOnFebruaryFifth.hour == "12")
        XCTAssert(noonOnFebruaryFifth.dayOfMonth == "5")
        XCTAssert(noonOnFebruaryFifth.month == "2")
        XCTAssert(noonOnFebruaryFifth.dayOfWeek == CRONExpression.star)
    }
    
    func testInvalidStandardFormatThrowsError() {
        XCTAssertThrowsError(try CRONExpression(fromExpression: ""))
        XCTAssertThrowsError(try CRONExpression(fromExpression: "12 4"))
        XCTAssertThrowsError(try CRONExpression(fromExpression: "* * * *"))
        XCTAssertThrowsError(try CRONExpression(fromExpression: "-1 12 300 * 1000"))
    }
}
