//
//  QuakeListSettingsFeed.swift
//  QuakeList
//
//  Created by Frosty on 11/26/17.
//  Copyright © 2017 repgarden. All rights reserved.
//

import UIKit

class SettingsFeed: UITableViewController {
    
    let defaults = UserDefaults.standard
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        if isKeyPresentInUserDefaults(key: "feedPref") == false {
            defaults.set("QuakeStringMonthSig", forKey: "feedPref")
            defaults.set(0, forKey: "feedPrefSel")
        }
    }
    
    func defineFeed(userQuakePreference: Int) {
        switch userQuakePreference {
            case 0:
                defaults.set(QuakeStringMonthSig, forKey: "feedPref")
                defaults.set(userQuakePreference, forKey: "feedPrefSel")
            case 1:
                defaults.set(QuakeStringWeek45Plus, forKey: "feedPref")
                defaults.set(userQuakePreference, forKey: "feedPrefSel")
            case 2:
                defaults.set(QuakeStringDayM25Plus, forKey: "feedPref")
                defaults.set(userQuakePreference, forKey: "feedPrefSel")
            case 3:
                defaults.set(QuakeStringHourAll, forKey: "feedPref")
                defaults.set(userQuakePreference, forKey: "feedPrefSel")
            default:
                defaults.set(QuakeStringMonthSig, forKey: "feedPref")
                defaults.set(userQuakePreference, forKey: "feedPrefSel")
            }
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = super.tableView(tableView, cellForRowAt: indexPath)
        
        let section = indexPath.section
        let numberOfRows = tableView.numberOfRows(inSection: section)
        for row in 0..<numberOfRows {
            if defaults.integer(forKey: "feedPrefSel") == indexPath.row {
                cell.accessoryType = row == indexPath.row ? .checkmark : .checkmark
            }
        }
        
        return cell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        defineFeed(userQuakePreference: indexPath.row)
  
        let section = indexPath.section
        let numberOfRows = tableView.numberOfRows(inSection: section)
        for row in 0..<numberOfRows {
            if let cell = tableView.cellForRow(at: IndexPath(row: row, section: section)) {
                cell.accessoryType = row == indexPath.row ? .checkmark : .none
            }
        }
    }
}
