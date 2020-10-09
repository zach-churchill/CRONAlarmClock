//
//  ViewController.swift
//  CRONAlarmClock
//
//  Created by Zachary Churchill on 9/30/20.
//

import UIKit

class AlarmsViewController: UITableViewController {
    
    /* Instance variables and functions */
    
    var alarmStore: AlarmStore!
    
    /* Interface Builder methods */

    @IBAction func addNewAlarm(_ sender: UIBarButtonItem) {
        // Just use dummy alarm for time being
        let alarm = Alarm()
        alarmStore.addAlarm(alarm)
        
        if let index = alarmStore.firstIndex(of: alarm) {
            let indexPath = IndexPath(row: index, section: 0)
            tableView.insertRows(at: [indexPath], with: .automatic)
        }
    }
    
    /* Overriden Functions */
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.rowHeight = UITableView.automaticDimension
        tableView.estimatedRowHeight = 100
    }

    override func tableView(_ tableView: UITableView,
                            numberOfRowsInSection section: Int) -> Int {
        return alarmStore.count
    }
    
    override func tableView(_ tableView: UITableView,
                            cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "AlarmCell",
                                                 for: indexPath) as! AlarmCell
        
        // Our table will only ever have one section, so just use row to get alarm
        let alarm = alarmStore.getAlarm(at: indexPath.row)!
        cell.updateDetails(alarm: alarm)
        
        return cell
    }
    
    override func tableView(_ tableView: UITableView,
                            trailingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration? {
        let deleteAction = UIContextualAction(style: .destructive, title: "") {
            (action, view, completionHandler) in
            
            let alarm = self.alarmStore.getAlarm(at: indexPath.row)!
            self.alarmStore.removeAlarm(alarm)
            tableView.deleteRows(at: [indexPath], with: .automatic)
            completionHandler(true)
        }

        deleteAction.image = CustomSymbols.deleteSymbol
        deleteAction.image?.accessibilityIdentifier = "Delete"
        deleteAction.backgroundColor = UIColor.dark
        
        let config = UISwipeActionsConfiguration(actions: [deleteAction])
        config.performsFirstActionWithFullSwipe = false
        
        return config
    }
}

