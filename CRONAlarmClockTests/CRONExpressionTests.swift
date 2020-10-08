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

}
