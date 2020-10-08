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

struct CRONFieldBounds {
    let lowerBound: Int
    let upperBound: Int
}

class CRONExpression {
    
    static let star: String = "*"

    var minute: String = star
    var hour: String = star
    var dayOfMonth: String = star
    var month: String = star
    var dayOfWeek: String = star
    
    private let parameterBounds: [String: CRONFieldBounds] = [
        "minute": CRONFieldBounds(lowerBound: 0, upperBound: 59),
        "hour": CRONFieldBounds(lowerBound: 0, upperBound: 23),
        "dayOfMonth": CRONFieldBounds(lowerBound: 1, upperBound: 31),
    ]
    
    private func throwAppropriateExpressionError(for parameterType: String) throws {
        switch parameterType {
        case "minute":
            throw InvalidCRONExpression.invalidMinute
        case "hour":
            throw InvalidCRONExpression.invalidHour
        case "dayOfMonth":
            throw InvalidCRONExpression.invalidDayOfMonth
        default:
            preconditionFailure("unexcepted parameter type: \(parameterType)")
        }
    }
    
    private func checkBounds(for parameterType: String,
                             parameter: Int) throws -> String {
        if let bounds = parameterBounds[parameterType] {
            if (parameter < bounds.lowerBound || parameter > bounds.upperBound) {
                try throwAppropriateExpressionError(for: parameterType)
            }
        } else {
            preconditionFailure("unexpected parameter type: \(parameterType)")
        }
        
        return String(parameter)
    }
    
    init(minute: Int? = nil,
         hour: Int? = nil,
         dayOfMonth: Int? = nil) throws {
        if let minute = minute {
            self.minute = try checkBounds(for: "minute", parameter: minute)
        }
            
        if let hour = hour {
            self.hour = try checkBounds(for: "hour", parameter: hour)

        }
        
        if let dayOfMonth = dayOfMonth {
            self.dayOfMonth = try checkBounds(for: "dayOfMonth", parameter: dayOfMonth)

        }
    }
}
