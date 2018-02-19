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

class RealmString : Object {
    @objc dynamic var stringValue = ""
}

class NewsInfo: Object{
    @objc dynamic var id = 0
    @objc dynamic var postType = ""
    @objc dynamic var sourceId = 0
    @objc dynamic var text = ""
    @objc dynamic var likes = 0
    @objc dynamic var reposts = 0
    @objc dynamic var views = 0
    var photos = List<RealmString>()
//    var photosList = List<String>()
    
    var photoList: [String] {
        get {
            return photos.map { $0.stringValue }
        }
        set {
            photos.removeAll()
            photos.append(objectsIn: newValue.map({ RealmString(value: [$0]) }))
        }
    }
    
    convenience init(json: JSON){
        self.init()
        id = json["post_id"].intValue
        postType = json["post_type"].stringValue
        sourceId = json["source_id"].intValue
        text = json["text"].stringValue
        likes = json["likes"]["count"].intValue
        reposts = json["reposts"]["count"].intValue
        views = json["views"]["count"].intValue
        photoList = json["photos"]["items"].array?.flatMap{
            $0["photo_130"].stringValue} ?? []
//        photosList.append(objectsIn: json["photos"]["items"].array?.flatMap{
//            $0["photo_130"].stringValue} ?? [])
    }
    
//    var toAnyObject: Any{
//        return [
//            "id": id,
//            "postType": postType,
//            "sourceId": sourceId,
//            "text": text,
//            "likes": likes,
//            "reposts": postType,
//            "postType": views,
//            "photos": ""//photosList.map{$0.stringValue}.array
//        ]
//    }
}
