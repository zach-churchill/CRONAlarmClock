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
    
    var errorDescription: String? {
        switch self {
        case .invalidMinute:
            return "minute must be '*' or between 0 and 59, inclusive"
        case .invalidHour:
            return "hour must be '*' or between 0 and 23, inclusive"
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
    
    init(minute: Int? = nil,
         hour: Int? = nil) throws {
        if let minute = minute {
            if (minute < 0 || minute > 59) {
                throw InvalidCRONExpression.invalidMinute
            } else {
                self.minute = String(minute)
            }
        } else {
            self.minute = CRONExpression.star
        }
            
        if let hour = hour {
            if (hour < 0 || hour > 23) {
                throw InvalidCRONExpression.invalidHour
            } else {
                self.hour = String(hour)
            }
        } else {
            self.hour = CRONExpression.star
        }
    }
}
