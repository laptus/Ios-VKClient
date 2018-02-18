//
//  ChatViewCell.swift
//  GeekBrainsApp
//
//  Created by Laptev Sasha on 18/02/2018.
//  Copyright © 2018 Laptev Sasha. All rights reserved.
//

import UIKit

class ChatViewCell: UITableViewCell {

    @IBOutlet weak var userNameLabel: UILabel!
    @IBOutlet weak var lastMessageLabel: UILabel!
    @IBOutlet weak var userAvatarView: UIImageView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
