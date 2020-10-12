//
//  EditAlarmViewController.swift
//  CRONAlarmClock
//
//  Created by Zachary Churchill on 10/12/20.
//

import UIKit

class EditAlarmViewController: UIViewController, UITextFieldDelegate {
    
    @IBOutlet var cronInput: UITextField!
    @IBAction func backgroundTapped(_ sender: UITapGestureRecognizer) {
        view.endEditing(true)
    }
    @IBAction func saveExpression(_ sender: UIButton) {
        if let enteredExpression = cronInput.text {
            if CRONExpression.isValid(for: enteredExpression) {
                let cronExpression = try! CRONExpression.parseExpression(for: enteredExpression)
                alarm.cronExpression = cronExpression
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
    }
}
