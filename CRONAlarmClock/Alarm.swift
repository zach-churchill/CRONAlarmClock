//
//  Alarm.swift
//  CRONAlarmClock
//
//  Created by Zachary Churchill on 9/30/20.
//

import UIKit

enum Period: String {
    case PM = "PM"
    case AM = "AM"
}

class Alarm: Equatable {
    var cronExpression: CRONExpression
    var description: String?
    var isActive: Bool
    var time: String {
        var alarmHours = "**"
        var alarmMinutes = "**"
        
        if let hours = Int(cronExpression.hour) {
            alarmHours = String(hours > 12 ? hours % 12 : hours)
        }
        
        if let minutes = Int(cronExpression.minute) {
            alarmMinutes = String(minutes)
        }
        
        return "\(alarmHours):\(alarmMinutes.padding(toLength: 2, withPad: "0", startingAt: 0))"
    }
    var period: Period? {
        var period: Period? = nil
        
        if let hours = Int(cronExpression.hour) {
            period = hours >= 12 ? .PM : .AM
        }
        
        return period
    }
    
    init(cronExpression: CRONExpression,
         description: String? = "",
         isActive: Bool = true) {
        self.cronExpression = cronExpression
        self.description = description
        self.isActive = isActive
    }
    
    convenience init() {
        let sevenFifteen = try! CRONExpression(fromExpression: "15 7 * * *")
        self.init(cronExpression: sevenFifteen, description: "work week", isActive: true)
    }
    
    static func ==(lhs: Alarm, rhs: Alarm) -> Bool {
        return lhs.cronExpression == rhs.cronExpression
            && lhs.description == rhs.description
            && lhs.isActive == rhs.isActive
    }
}
