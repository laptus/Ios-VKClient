//
//  JoinedGroupViewCell.swift
//  GeekBrainsApp
//
//  Created by Laptev Sasha on 04/12/2017.
//  Copyright © 2017 Laptev Sasha. All rights reserved.
//

import UIKit

class GroupCell: UITableViewCell {
    @IBOutlet weak var name: UILabel!
    @IBOutlet weak var avatar: UIImageView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
