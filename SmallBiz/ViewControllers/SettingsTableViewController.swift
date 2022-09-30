//
//  SettingsTableViewController.swift
//  SmallBiz
//
//  Created by Matthew Rawlings on 9/29/22.
//

import UIKit

class SettingsTableViewController: UITableViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

    }
    
    lazy var datasource: [SettingsItem] = {
        return [SettingsItem(settingTitle: "New Employee default items", isActive: false, type: .toggleSwitch),
                SettingsItem(settingTitle: "Default Items", type: .disclosure)]
    }()
    

    // MARK: - Table view data source

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return datasource.count
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let item = datasource[indexPath.row]
        
        switch item.type {
        case .toggleSwitch:
            guard let cell = tableView.dequeueReusableCell(withIdentifier: "settingsCell", for: indexPath) as? SettingsTableViewCell else { return UITableViewCell()}
//            let setting = datasource[indexPath.row]
            cell.item = item
            cell.delegate = self
            return cell
        case .disclosure:
            guard let cell = tableView.dequeueReusableCell(withIdentifier: "disclosureCell", for: indexPath) as? DisclosureTableViewCell else { return UITableViewCell()}
            cell.disclosureLabel.text = item.settingTitle
            return cell
        }
        
    }
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        80
    }

    /*
    // Override to support conditional editing of the table view.
    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the specified item to be editable.
        return true
    }
    */

    /*
    // Override to support editing the table view.
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            // Delete the row from the data source
            tableView.deleteRows(at: [indexPath], with: .fade)
        } else if editingStyle == .insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
        }    
    }
    */

    /*
    // Override to support rearranging the table view.
    override func tableView(_ tableView: UITableView, moveRowAt fromIndexPath: IndexPath, to: IndexPath) {

    }
    */

    /*
    // Override to support conditional rearranging of the table view.
    override func tableView(_ tableView: UITableView, canMoveRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the item to be re-orderable.
        return true
    }
    */

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}

struct SettingsItem {
    var settingTitle: String
    var isActive: Bool = false
    var type: SettingCellType
    
    mutating func readDefaults() {
        let defaults = UserDefaults.standard
        self.isActive = defaults.bool(forKey: self.settingTitle)
    }
}

enum SettingCellType {
    case toggleSwitch, disclosure
}

extension SettingsTableViewController: SettingsChangedProtocol {
    func settingToggled(item: SettingsItem) {
        let defaults = UserDefaults.standard
        defaults.set(!item.isActive, forKey: item.settingTitle)
    }
}
