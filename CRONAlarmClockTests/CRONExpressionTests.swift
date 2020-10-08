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
        
        XCTAssert(cronExpression.minute == CRONExpression.star)
        XCTAssert(cronExpression.hour == CRONExpression.star)
        XCTAssert(cronExpression.dayOfMonth == CRONExpression.star)
        XCTAssert(cronExpression.month == CRONExpression.star)
        XCTAssert(cronExpression.dayOfWeek == CRONExpression.star)
    }

}
