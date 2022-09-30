//
//  DefaultItemsCollectionViewCell.swift
//  SmallBiz
//
//  Created by Matthew Rawlings on 9/30/22.
//

import UIKit

class DefaultItemsCollectionViewCell: UICollectionViewCell {
    
    @IBOutlet weak var defaultItemLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        self.layer.cornerRadius = 8
    }
}
