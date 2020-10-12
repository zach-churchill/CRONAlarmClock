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
            return "provided CRON expression is invalid"
        }
    }
}

enum CRONField {
    case Minute
    case Hour
    case DayOfMonth
    case Month
    case DayOfWeek
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
    var expression: String {
        return "\(minute) \(hour) \(dayOfMonth) \(month) \(dayOfWeek)"
    }
    
    static func ==(lhs: CRONExpression, rhs: CRONExpression) -> Bool {
        return lhs.minute == rhs.minute
            && lhs.hour == rhs.hour
            && lhs.dayOfMonth == rhs.dayOfMonth
            && lhs.month == rhs.month
            && lhs.dayOfWeek == rhs.dayOfWeek
    }
    
    private static func createObjectFromExpression(for expression: String) throws -> CRONExpression {
        let fields = expression.split(separator: " ").map { String($0) }
        return try CRONExpression(minute: Int(fields[0]),
                                  hour: Int(fields[1]),
                                  dayOfMonth: Int(fields[2]),
                                  month: Int(fields[3]),
                                  dayOfWeek: Int(fields[4]))
    }
    
    static func isValid(for expression: String) -> Bool {
        let regex = try! NSRegularExpression(pattern: "^(([0-9]{1,}|\\*) ){4}([0-9]{1,}|\\*)")
        let range = NSRange(location: 0, length: expression.utf16.count)
        if let _ = regex.firstMatch(in: expression, options: [], range: range) {
            do {
                let _ = try CRONExpression.createObjectFromExpression(for: expression)
            } catch {
                return false
            }
            return true
        }
        return false
    }
    
    static func parseExpression(for expression: String) throws -> CRONExpression {
        if CRONExpression.isValid(for: expression){
            return try CRONExpression.createObjectFromExpression(for: expression)
        } else {
            throw InvalidCRONExpression.invalidExpression
        }
    }
    
    private func getCRONFieldBounds(for cronField: CRONField) -> CRONFieldBounds {
        switch cronField {
        case .Minute:
            return CRONFieldBounds(lowerBound: 0, upperBound: 59)
        case .Hour:
            return CRONFieldBounds(lowerBound: 0, upperBound: 23)
        case .DayOfMonth:
            return CRONFieldBounds(lowerBound: 1, upperBound: 31)
        case .Month:
            return CRONFieldBounds(lowerBound: 1, upperBound: 12)
        case .DayOfWeek:
            return CRONFieldBounds(lowerBound: 0, upperBound: 6)
        }
    }
    
    private func throwAppropriateExpressionError(for cronField: CRONField) throws {
        switch cronField {
        case .Minute:
            throw InvalidCRONExpression.invalidMinute
        case .Hour:
            throw InvalidCRONExpression.invalidHour
        case .DayOfMonth:
            throw InvalidCRONExpression.invalidDayOfMonth
        case .Month:
            throw InvalidCRONExpression.invalidMonth
        case .DayOfWeek:
            throw InvalidCRONExpression.invalidDayOfWeek
        }
    }
    
    private func checkBounds(for cronField: CRONField,
                             parameter: Int) throws -> String {
        let bounds = getCRONFieldBounds(for: cronField)
        if (parameter < bounds.lowerBound || parameter > bounds.upperBound) {
            try throwAppropriateExpressionError(for: cronField)
        }
        
        return String(parameter)
    }
    
    init(minute: Int? = nil,
         hour: Int? = nil,
         dayOfMonth: Int? = nil,
         month: Int? = nil,
         dayOfWeek: Int? = nil) throws {
        if let minute = minute {
            self.minute = try checkBounds(for: .Minute, parameter: minute)
        }
            
        if let hour = hour {
            self.hour = try checkBounds(for: .Hour, parameter: hour)
        }
        
        if let dayOfMonth = dayOfMonth {
            self.dayOfMonth = try checkBounds(for: .DayOfMonth, parameter: dayOfMonth)
        }
        
        if let month = month {
            self.month = try checkBounds(for: .Month, parameter: month)
        }
        
        if let dayOfWeek = dayOfWeek {
            self.dayOfWeek = try checkBounds(for: .DayOfWeek, parameter: dayOfWeek)
        }
    }
    
    convenience init(fromExpression expression: String) throws {
        let cronExpression = try CRONExpression.parseExpression(for: expression)
        try! self.init(minute: Int(cronExpression.minute),
                       hour: Int(cronExpression.hour),
                       dayOfMonth: Int(cronExpression.dayOfMonth),
                       month: Int(cronExpression.month),
                       dayOfWeek: Int(cronExpression.dayOfWeek))
    }
}
