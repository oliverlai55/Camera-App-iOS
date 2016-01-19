//
//  FilterTableViewCell.swift
//  Camera App
//
//  Created by Wei lun Lai on 1/18/16.
//  Copyright © 2016 DigitalCrafts. All rights reserved.
//

import UIKit


class FilterTableViewCell: UITableViewCell {

    @IBOutlet var filterImageView: UIImageView!
    @IBOutlet var filterNameLabel: UILabel!
    

    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

    
}

