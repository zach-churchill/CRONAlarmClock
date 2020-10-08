//
//  UIColor+CRONAlarmClockTests.swift
//  CRONAlarmClockTests
//
//  Created by Zachary Churchill on 10/8/20.
//

import XCTest
@testable import CRONAlarmClock

class UIColor_CRONAlarmClockTests: XCTestCase {

    func testColorPaletteReturnsNonNil() {
        XCTAssertNotNil(UIColor.accent)
        XCTAssertNotNil(UIColor.light)
        XCTAssertNotNil(UIColor.mediumLight)
        XCTAssertNotNil(UIColor.medium)
        XCTAssertNotNil(UIColor.dark)
    }

}
