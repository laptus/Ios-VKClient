//
//  PhotoInfo.swift
//  GeekBrainsApp
//
//  Created by Laptev Sasha on 11/12/2017.
//  Copyright © 2017 Laptev Sasha. All rights reserved.
//

import Foundation
import SwiftyJSON
import RealmSwift


class GroupInfo : Object{
    @objc dynamic var id = 0
    @objc dynamic var name = ""
    @objc dynamic var photoUrl = ""
    @objc dynamic var count = 0

    
    convenience init(json: JSON){
        self.init()
        name = json["name"].stringValue
        photoUrl = json["photo_100"].stringValue
        count = json["members_count"].intValue
        id = json["id"].intValue
    }
    
    override static func primaryKey() -> String? {
        return String("id")
    }
}
