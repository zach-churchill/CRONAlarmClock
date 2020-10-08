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
        let expectedForeverAndAlways = try! CRONExpression()
        XCTAssert(foreverAndAlways == expectedForeverAndAlways)
        
        let sevenFifteenEveryDay = try! CRONExpression(fromExpression: "15 7 * * *")
        let expectedSevenFifteenEveryDay = try! CRONExpression(minute: 15, hour: 7)
        XCTAssert(sevenFifteenEveryDay == expectedSevenFifteenEveryDay)
        
        let noonOnFebruaryFifth = try! CRONExpression(fromExpression: "0 12 5 2 *")
        let expectedNoonOnFebruaryFifth = try! CRONExpression(minute: 0,
                                                              hour: 12,
                                                              dayOfMonth: 5,
                                                              month: 2)
        XCTAssert(noonOnFebruaryFifth == expectedNoonOnFebruaryFifth)
    }
    
    func testInvalidStandardFormatThrowsError() {
        XCTAssertThrowsError(try CRONExpression(fromExpression: ""))
        XCTAssertThrowsError(try CRONExpression(fromExpression: "12 4"))
        XCTAssertThrowsError(try CRONExpression(fromExpression: "* * * *"))
        XCTAssertThrowsError(try CRONExpression(fromExpression: "-1 12 300 * 1000"))
    }
    
    func testConformsToEquatableProtocol() {
        let cron1 = try! CRONExpression(fromExpression: "15 7 * * *")
        let cron2 = try! CRONExpression(fromExpression: "15 7 * * *")
        
        XCTAssert(cron1 == cron2)
    }
    
    func testExpressionParsingStaticFunctionReturnsCorrectObject() {
        let sevenFifteen = try! CRONExpression.parseExpression(for: "15 7 * * *")
        let expectedSevenFifteen = try! CRONExpression(minute: 15, hour: 7)
        XCTAssert(sevenFifteen == expectedSevenFifteen)
        
        let noonOnFebruaryFifth = try! CRONExpression.parseExpression(for: "0 12 5 2 *")
        let expectednoonOnFebruaryFifth = try! CRONExpression(minute: 0,
                                                              hour: 12,
                                                              dayOfMonth: 5,
                                                              month: 2)
        XCTAssert(noonOnFebruaryFifth == expectednoonOnFebruaryFifth)
        
        let foreverAndAlways = try! CRONExpression.parseExpression(for: "* * * * *")
        let expectedforeverAndAlways = try! CRONExpression()
        XCTAssert(foreverAndAlways == expectedforeverAndAlways)
    }
    
    func testReadOnlyExpressionProperty() {
        let foreverAndAlways = try! CRONExpression()
        XCTAssert(foreverAndAlways.expression == "* * * * *")

        let sevenFifteen = try! CRONExpression.parseExpression(for: "15 7 * * *")
        XCTAssert(sevenFifteen.expression == "15 7 * * *")
    }
}
