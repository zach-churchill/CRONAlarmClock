//
//  EditAlarmViewController.swift
//  CRONAlarmClock
//
//  Created by Zachary Churchill on 10/12/20.
//

import UIKit

class EditAlarmViewController: UIViewController {
    
    var alarm: Alarm!
    
    override func viewWillAppear(_ animated: Bool) {
        print(alarm)
    }
}
