//
//  DisclosureTableViewCell.swift
//  SmallBiz
//
//  Created by Matthew Rawlings on 9/29/22.
//

import UIKit

class DisclosureTableViewCell: UITableViewCell {

    @IBOutlet weak var disclosureLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
