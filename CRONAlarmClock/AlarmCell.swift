//
//  AlarmCell.swift
//  CRONAlarmClock
//
//  Created by Zachary Churchill on 9/30/20.
//

import UIKit

class AlarmCell: UITableViewCell {
    
    @IBOutlet private var alarmLabel: UILabel!
    @IBOutlet private var periodLabel: UILabel!
    @IBOutlet private var descriptionLabel: UILabel!
    @IBOutlet private var activateSwitch: UISwitch!
    
    func updateDetails(alarm: Alarm) {
        alarmLabel.text = alarm.time
        periodLabel.text = alarm.period?.rawValue
        descriptionLabel.text = alarm.description
        activateSwitch.isOn = alarm.isActive
    }
}
