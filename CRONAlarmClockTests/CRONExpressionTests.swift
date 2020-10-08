//
//  CRONExpressionTests.swift
//  CRONAlarmClockTests
//
//  Created by Zachary Churchill on 10/8/20.
//

import XCTest
@testable import CRONAlarmClock

class CRONExpressionTests: XCTestCase {

    func testComponentsDefaultToStars() {
        let cronExpression = CRONExpression()
        
        XCTAssert(cronExpression.minute == "*")
        XCTAssert(cronExpression.hour == "*")
        XCTAssert(cronExpression.dayOfMonth == "*")
        XCTAssert(cronExpression.month == "*")
        XCTAssert(cronExpression.dayOfWeek == "*")
    }

}
