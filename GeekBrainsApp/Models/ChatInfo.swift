import Foundation
import SwiftyJSON
import RealmSwift

class ChatInfo: Object {
//    @objc dynamic var id = 0
//    @objc dynamic var thumb_src = ""
//    @objc dynamic var title = ""
//    @objc dynamic var isReaded = ""
    
    convenience init(json: JSON) {
        self.init()
//        id = json["message"]["chat_id"].intValue
//        title = json["message"]["title"].stringValue
//        thumb_src = json["thumb_src"].stringValue
    }
}

