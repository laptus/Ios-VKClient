//
//  UserInfo.swift
//  GeekBrainsApp
//
//  Created by Laptev Sasha on 11/12/2017.
//  Copyright © 2017 Laptev Sasha. All rights reserved.
//

import Foundation
import SwiftyJSON
import RealmSwift

class UserInfo :Object{
    @objc dynamic var id = 0
    @objc dynamic var name = ""
    @objc dynamic var photoUrl = ""

    convenience init(json: JSON){
        self.init()
        self.id = json["id"].intValue
        self.name = json["first_name"].stringValue+" "+json["last_name"].stringValue
        self.photoUrl = json["photo_100"].stringValue
    }
    
    override static func primaryKey() -> String? {
        return String("id")
    }
}

class UserRealm: Object  {
    @objc dynamic var id = 0
    @objc dynamic var name = ""
    @objc dynamic var photoUrl = ""
        
    convenience init(json: JSON) {
        self.init()
        id = json["id"].intValue
        name = json["first_name"].stringValue+" "+json["last_name"].stringValue
        photoUrl = json["photo_50"].stringValue
    }
}

