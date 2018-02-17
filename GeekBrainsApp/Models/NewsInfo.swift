//
//  NewsInfo.swift
//  GeekBrainsApp
//
//  Created by Laptev Sasha on 17/02/2018.
//  Copyright © 2018 Laptev Sasha. All rights reserved.
//

import Foundation
import SwiftyJSON
import RealmSwift

class NewsInfo: Object{
    @objc dynamic var id = 0
    @objc dynamic var type = 0
    @objc dynamic var sourceId = 0
    @objc dynamic var date = ""
    @objc dynamic var text = ""
    @objc dynamic var likes = 0
    @objc dynamic var reposts = 0
    @objc dynamic var geo = ""
    let photos = List<String>()
    @objc dynamic var userId = ""
    @objc dynamic var groupId = ""
    @objc dynamic var avatar = ""
    
    
    convenience init(json: JSON){
        self.init()
//        type = json["type"].stringValue
//        sourceId = json["sourceId"].stringValue
//        date = json["date"].intValue
//        id = json["id"].intValue
    }
    
    override static func primaryKey() -> String? {
        return String("id")
    }
    
    var toAnyObject: Any{
        return [
//            "id": name,
//            "name": name
        ]
    }
}
