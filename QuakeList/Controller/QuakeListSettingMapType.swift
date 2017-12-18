//
//  QuakeListSettingMapType.swift
//  QuakeList
//
//  Created by Frosty on 11/26/17.
//  Copyright © 2017 repgarden. All rights reserved.
//

import UIKit

class SettingsMapType: UITableViewController {
    
    let defaults = UserDefaults.standard
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    func defineMapType(userMapPreference: Int) {
        defaults.set(userMapPreference, forKey: "feedMapPref")
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = super.tableView(tableView, cellForRowAt: indexPath)
        
        let section = indexPath.section
        let numberOfRows = tableView.numberOfRows(inSection: section)
        for row in 0..<numberOfRows {
            if defaults.integer(forKey: "feedMapPref") == indexPath.row {
                cell.accessoryType = row == indexPath.row ? .checkmark : .checkmark
            }
        }
        
        return cell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        defineMapType(userMapPreference: indexPath.row)
        
        let section = indexPath.section
        let numberOfRows = tableView.numberOfRows(inSection: section)
        for row in 0..<numberOfRows {
            if let cell = tableView.cellForRow(at: IndexPath(row: row, section: section)) {
                cell.accessoryType = row == indexPath.row ? .checkmark : .none
            }
        }
    }
}
