//
//  ViewController.swift
//  CRONAlarmClock
//
//  Created by Zachary Churchill on 9/30/20.
//

import UIKit

class AlarmsViewController: UITableViewController {
    
    var alarmStore: AlarmStore!

    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.rowHeight = UITableView.automaticDimension
        tableView.estimatedRowHeight = 100
    }

    override func tableView(_ tableView: UITableView,
                            numberOfRowsInSection section: Int) -> Int {
        return alarmStore.alarms.count
    }
    
    override func tableView(_ tableView: UITableView,
                            cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "AlarmCell",
                                                 for: indexPath) as! AlarmCell
        
        // Our table will only ever have one section, so just use row to get alarm
        let alarm = alarmStore.alarms[indexPath.row]
        cell.updateDetails(alarm: alarm)
        
        return cell
    }
}

