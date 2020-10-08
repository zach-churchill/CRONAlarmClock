//
//  CustomSymbolsTests.swift
//  CRONAlarmClockTests
//
//  Created by Zachary Churchill on 10/8/20.
//

import XCTest
@testable import CRONAlarmClock

class CustomSymbolsTests: XCTestCase {

    func testCustomDeleteSymbolIsNotNil() {
        XCTAssertNotNil(CustomSymbols.deleteSymbol)
    }

}
