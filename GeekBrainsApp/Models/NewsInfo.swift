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
        photoList = json["attachments"].array?.flatMap{
            $0["type"] == "album" ?
                $0["album"]["thumb"]["photo_130"].stringValue:
                $0["photo"]["photo_130"].stringValue}
            ?? []
    }
}
