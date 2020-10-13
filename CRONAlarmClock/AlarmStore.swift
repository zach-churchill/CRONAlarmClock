//
//  AlarmStore.swift
//  CRONAlarmClock
//
//  Created by Zachary Churchill on 9/30/20.
//

import UIKit

class AlarmStore {
    
    private var alarms = [Alarm]()
    var count: Int {
        get {
            return alarms.count
        }
    }
    var archiveURL: URL = {
        let documentDirectories = FileManager.default.urls(for: .documentDirectory,
                                                           in: .userDomainMask)
        let documentDirectory = documentDirectories.first!
        return documentDirectory.appendingPathComponent("alarms.plist")
    }()
    
    init() {
        do {
            let data = try Data(contentsOf: archiveURL)
            let unarchiver = PropertyListDecoder()
            let archivedAlarms = try unarchiver.decode([Alarm].self, from: data)
            alarms = archivedAlarms
        } catch {
            print("error reading in saved alarms: \(error)")
        }

        let notificationCenter = NotificationCenter.default
        notificationCenter.addObserver(self,
                                       selector: #selector(saveAlarms),
                                       name: UIScene.willDeactivateNotification,
                                       object: nil)
    }
    
    func addAlarm(_ alarm: Alarm) {
        alarms.append(alarm)
    }
    
    func removeAlarm(_ alarm: Alarm) {
        if let index = alarms.firstIndex(of: alarm) {
            alarms.remove(at: index)
        }
    }
    
    func getAlarm(at index: Int) -> Alarm? {
        if index < alarms.count {
            return alarms[index]
        }
        return nil
    }
    
    func firstIndex(of alarm: Alarm) -> Int? {
        return alarms.firstIndex(of: alarm)
    }
    
    @objc func saveAlarms() -> Bool {
        print("Saving alarms to: \(archiveURL)")
        do {
            let encoder = PropertyListEncoder()
            let data = try encoder.encode(alarms)
            try data.write(to: archiveURL, options: [.atomic])
            return true
        } catch let encodingError {
            print("error encoding alarms: \(encodingError)")
            return false
        }
    }
}
