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
    case invalidMonth
    case invalidDayOfWeek
    
    case invalidExpression
    
    var errorDescription: String? {
        switch self {
        case .invalidMinute:
            return "minute must be '*' or between 0 and 59, inclusive"
        case .invalidHour:
            return "hour must be '*' or between 0 and 23, inclusive"
        case .invalidDayOfMonth:
            return "dayOfMonth must be '*' or between 1 and 31, inclusive"
        case .invalidMonth:
            return "month must be '*' or between 1 and 12, inclusive"
        case .invalidDayOfWeek:
            return "dayOfWeek must be '*' or between 0 and 6, inclusive"
        case .invalidExpression:
            return "provide CRON expression is invalid"
        }
    }
}

struct CRONFieldBounds {
    let lowerBound: Int
    let upperBound: Int
}

class CRONExpression: Equatable {
    
    static let star: String = "*"

    var minute: String = star
    var hour: String = star
    var dayOfMonth: String = star
    var month: String = star
    var dayOfWeek: String = star
    
    static func ==(lhs: CRONExpression, rhs: CRONExpression) -> Bool {
        return lhs.minute == rhs.minute
            && lhs.hour == rhs.hour
            && lhs.dayOfMonth == rhs.dayOfMonth
            && lhs.month == rhs.month
            && lhs.dayOfWeek == rhs.dayOfWeek
    }
    
    static func parseExpression(for expression: String) throws -> CRONExpression {
        let regex = try! NSRegularExpression(pattern: "((([0-9]+,)+[0-9]+|([0-9]+(\\/|-)[0-9]+)|[0-9]+|\\*) ?){5}")
        let range = NSRange(location: 0, length: expression.utf16.count)
        if let _ = regex.firstMatch(in: expression, options: [], range: range) {
            let fields = expression.split(separator: " ").map { String($0) }
            return try CRONExpression(minute: Int(fields[0]),
                                      hour: Int(fields[1]),
                                      dayOfMonth: Int(fields[2]),
                                      month: Int(fields[3]),
                                      dayOfWeek: Int(fields[4]))
        } else {
            throw InvalidCRONExpression.invalidExpression
        }
    }
    
    private let expressionRegex = try! NSRegularExpression(pattern: "((([0-9]+,)+[0-9]+|([0-9]+(\\/|-)[0-9]+)|[0-9]+|\\*) ?){5}")
    
    private let parameterBounds: [String: CRONFieldBounds] = [
        "minute": CRONFieldBounds(lowerBound: 0, upperBound: 59),
        "hour": CRONFieldBounds(lowerBound: 0, upperBound: 23),
        "dayOfMonth": CRONFieldBounds(lowerBound: 1, upperBound: 31),
        "month": CRONFieldBounds(lowerBound: 1, upperBound: 12),
        "dayOfWeek": CRONFieldBounds(lowerBound: 0, upperBound: 6),
    ]
    
    private func throwAppropriateExpressionError(for parameterType: String) throws {
        switch parameterType {
        case "minute":
            throw InvalidCRONExpression.invalidMinute
        case "hour":
            throw InvalidCRONExpression.invalidHour
        case "dayOfMonth":
            throw InvalidCRONExpression.invalidDayOfMonth
        case "month":
            throw InvalidCRONExpression.invalidMonth
        case "dayOfWeek":
            throw InvalidCRONExpression.invalidDayOfWeek
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
         dayOfMonth: Int? = nil,
         month: Int? = nil,
         dayOfWeek: Int? = nil) throws {
        if let minute = minute {
            self.minute = try checkBounds(for: "minute", parameter: minute)
        }
            
        if let hour = hour {
            self.hour = try checkBounds(for: "hour", parameter: hour)

        }
        
        if let dayOfMonth = dayOfMonth {
            self.dayOfMonth = try checkBounds(for: "dayOfMonth", parameter: dayOfMonth)

        }
        
        if let month = month {
            self.month = try checkBounds(for: "month", parameter: month)
        }
        
        if let dayOfWeek = dayOfWeek {
            self.dayOfWeek = try checkBounds(for: "dayOfWeek", parameter: dayOfWeek)
        }
    }
    
    convenience init(fromExpression expression: String) throws {
        try self.init()
        
        let range = NSRange(location: 0, length: expression.utf16.count)
        if let _ = expressionRegex.firstMatch(in: expression, options: [], range: range) {
            let fields = expression.split(separator: " ").map { String($0) }
            try self.init(minute: Int(fields[0]),
                          hour: Int(fields[1]),
                          dayOfMonth: Int(fields[2]),
                          month: Int(fields[3]),
                          dayOfWeek: Int(fields[4]))
        } else {
            throw InvalidCRONExpression.invalidExpression
        }
    }
    
    convenience init(fromCRONExpression cronExpression: CRONExpression) {
        try! self.init(minute: Int(cronExpression.minute),
                       hour: Int(cronExpression.hour),
                       dayOfMonth: Int(cronExpression.dayOfMonth),
                       month: Int(cronExpression.month),
                       dayOfWeek: Int(cronExpression.dayOfWeek))
    }
}
