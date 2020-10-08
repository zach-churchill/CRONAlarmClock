//
//  CRONExpression.swift
//  CRONAlarmClock
//
//  Created by Zachary Churchill on 10/8/20.
//

import UIKit

enum InvalidCRONExpression: LocalizedError {
    case invalidMinute
    case invalidHour
    case invalidDayOfMonth
    
    var errorDescription: String? {
        switch self {
        case .invalidMinute:
            return "minute must be '*' or between 0 and 59, inclusive"
        case .invalidHour:
            return "hour must be '*' or between 0 and 23, inclusive"
        case .invalidDayOfMonth:
            return "dayOfMonth must be '*' or between 1 and 31, inclusive"
        }
    }
}

class CRONExpression {
    
    static let star: String = "*"

    var minute: String = star
    var hour: String = star
    var dayOfMonth: String = star
    var month: String = star
    var dayOfWeek: String = star
    
    private func checkBounds(parameter: Int,
                             lowerBound: Int,
                             upperBound: Int,
                             error: Error) throws -> String {
        if (parameter < lowerBound || parameter > upperBound) {
            throw error
        }
        
        return String(parameter)
    }
    
    init(minute: Int? = nil,
         hour: Int? = nil,
         dayOfMonth: Int? = nil) throws {
        if let minute = minute {
            self.minute = try checkBounds(parameter: minute,
                                          lowerBound: 0,
                                          upperBound: 59,
                                          error: InvalidCRONExpression.invalidMinute)
        }
            
        if let hour = hour {
            self.hour = try checkBounds(parameter: hour,
                                        lowerBound: 0,
                                        upperBound: 23,
                                        error: InvalidCRONExpression.invalidHour)

        }
        
        if let dayOfMonth = dayOfMonth {
            self.dayOfMonth = try checkBounds(parameter: dayOfMonth,
                                              lowerBound: 1,
                                              upperBound: 31,
                                              error: InvalidCRONExpression.invalidDayOfMonth)

        }
    }
}
