//
//  ViewController.swift
//  CRONAlarmClock
//
//  Created by Zachary Churchill on 9/30/20.
//

import UIKit

class AlarmsViewController: UITableViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.rowHeight = UITableView.automaticDimension
        tableView.estimatedRowHeight = 75
    }

    override func tableView(_ tableView: UITableView,
                            numberOfRowsInSection section: Int) -> Int {
        return 1
    }
    
    override func tableView(_ tableView: UITableView,
                            cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "AlarmCell",
                                                 for: indexPath) as! AlarmCell
        
        // Create a dummy alarm cell
        cell.alarmLabel.text = "7:15 AM"
        cell.descriptionLabel.text = "Work week"
        cell.activateSwitch.isOn = true
        
        return cell
    }
}

