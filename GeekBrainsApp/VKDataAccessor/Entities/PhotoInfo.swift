//
//  PhotoInfo.swift
//  GeekBrainsApp
//
//  Created by Laptev Sasha on 14/12/2017.
//  Copyright © 2017 Laptev Sasha. All rights reserved.
//

import Foundation
import SwiftyJSON
import RealmSwift

class PhotoInfo: Object {
    @objc dynamic var user : UserInfo?
    @objc dynamic var url = ""
    
    convenience init(json: JSON) {
        self.init()
        url = json["photo_130"].stringValue
    }
}
