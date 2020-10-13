//
//  EditAlarmViewController.swift
//  CRONAlarmClock
//
//  Created by Zachary Churchill on 10/12/20.
//

import UIKit

class EditAlarmViewController: UIViewController, UITextFieldDelegate {
    
    @IBOutlet var cronInput: UITextField!
    @IBOutlet var descriptionInput: UITextField!
    @IBOutlet var isActiveSwitch: UISwitch!
    @IBAction func backgroundTapped(_ sender: UITapGestureRecognizer) {
        view.endEditing(true)
    }
    @IBAction func needHelp(_ sender: UIButton) {
        let helpMessage = "Minutes should be between 0-59, hours between 0-23, " +
                          "day of month between 1-31, month between 1-12, and " +
                          "day of week between 0-6.\n" +
                          "Use * to target every value in the field."
        let alert = UIAlertController(title: "CRON syntax help",
                                      message: helpMessage,
                                      preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "OK", style: .cancel, handler: nil))
        self.present(alert, animated: true)
    }
    @IBAction func saveAlarm(_ sender: UIButton) {
        if let enteredExpression = cronInput.text {
            if CRONExpression.isValid(for: enteredExpression) {
                let cronExpression = try! CRONExpression.parseExpression(for: enteredExpression)
                alarm.cronExpression = cronExpression
                alarm.description = descriptionInput.text
                alarm.isActive = isActiveSwitch.isOn
                
                let alert = UIAlertController(title: nil, message: nil, preferredStyle: .actionSheet)
                alert.addAction(UIAlertAction(title: "Alarm Updated", style: .cancel, handler: nil))
                self.present(alert, animated: true)

                cronInput.textColor = .light
            } else {
                let alert = UIAlertController(title: "Invalid CRON Expression",
                                              message: nil,
                                              preferredStyle: .alert)
                alert.addAction(UIAlertAction(title: "OK", style: .cancel, handler: nil))
                self.present(alert, animated: true)

                cronInput.textColor = .red
            }
        }
    }
    
    var alarm: Alarm!
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)

        cronInput.text = alarm.cronExpression.expression
        descriptionInput.text = alarm.description
        isActiveSwitch.isOn = alarm.isActive
    }
}
