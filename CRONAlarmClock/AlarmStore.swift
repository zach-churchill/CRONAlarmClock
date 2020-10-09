//
//  AlarmStore.swift
//  CRONAlarmClock
//
//  Created by Zachary Churchill on 9/30/20.
//

import UIKit

class AlarmStore {
    
    private var alarms = [Alarm]()
    var count: Int {
        get {
            return alarms.count
        }
    }
    
    func addAlarm(_ alarm: Alarm) {
        alarms.append(alarm)
    }
    
    func removeAlarm(_ alarm: Alarm) {
        if let index = alarms.firstIndex(of: alarm) {
            alarms.remove(at: index)
        }
    }
    
    func getAlarm(at index: Int) -> Alarm? {
        if index < alarms.count {
            return alarms[index]
        }
        return nil
    }
    
    func firstIndex(of alarm: Alarm) -> Int? {
        return alarms.firstIndex(of: alarm)
    }
}
