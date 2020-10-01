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
    
    func updateLabels(time: String, period: Period, description: String?) {
        alarmLabel.text = time
        periodLabel.text = period.rawValue.uppercased()
        descriptionLabel.text = description
    }
    
    func flipSwitch(isActive: Bool) {
        activateSwitch.isOn = isActive
    }
}
