//
//  SettingsTableViewCell.swift
//  SmallBiz
//
//  Created by Matthew Rawlings on 9/29/22.
//

import UIKit

protocol SettingsChangedProtocol: AnyObject {
    func settingToggled(item: SettingsItem)
}

class SettingsTableViewCell: UITableViewCell {
    
    var item: SettingsItem! {
        didSet {
            updateViews()
        }
    }

    //MARK: - Outlets
    @IBOutlet weak var settingTitleLabel: UILabel!
    @IBOutlet weak var settingSwitch: UISwitch!
    
    weak var delegate: SettingsChangedProtocol?
    
    //MARK: - Lifecycles
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    //MARK: - Action
    @IBAction func settingSwitchToggled(_ sender: Any) {
        delegate?.settingToggled(item: item)
    }
    
    //MARK: - Helper Functions
    func updateViews() {
        settingTitleLabel.text = item.settingTitle
        settingSwitch.isOn = item.isActive
    }
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
