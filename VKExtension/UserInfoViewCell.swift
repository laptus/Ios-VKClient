//
//  UserInfoViewCell.swift
//  VKExtension
//
//  Created by Laptev Sasha on 25/02/2018.
//  Copyright © 2018 Laptev Sasha. All rights reserved.
//

import UIKit

class UserInfoViewCell: UITableViewCell {
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var avatarImage: UIImageView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
