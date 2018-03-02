//
//  MessageInfo.swift
//  GeekBrainsApp
//
//  Created by Laptev Sasha on 23/02/2018.
//  Copyright © 2018 Laptev Sasha. All rights reserved.
//

import Foundation
import SwiftyJSON

struct MessageInfo{
    var userId: Int
    var text: String
    var photos: [String]
    
    init(json: JSON){
        userId = json["from_id"].intValue
        text = json["body"].stringValue
        photos = []
    }
}
