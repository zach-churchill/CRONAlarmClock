//
//  AlarmStore.swift
//  CRONAlarmClock
//
//  Created by Zachary Churchill on 9/30/20.
//

import UIKit

class AlarmStore {
    
    var alarms = [Alarm]()
    
    init() {
        let alarm = Alarm()
        alarms.append(alarm)
    }
}
