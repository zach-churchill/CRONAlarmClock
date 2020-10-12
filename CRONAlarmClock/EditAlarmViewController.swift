//
//  EditAlarmViewController.swift
//  CRONAlarmClock
//
//  Created by Zachary Churchill on 10/12/20.
//

import UIKit

class EditAlarmViewController: UIViewController {
    
    @IBOutlet var cronInput: UITextField!

    var alarm: Alarm!
    
    override func viewWillAppear(_ animated: Bool) {
        cronInput.text = alarm.cronExpression.expression
    }
}
