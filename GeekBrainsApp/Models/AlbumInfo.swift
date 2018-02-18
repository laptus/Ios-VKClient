import Foundation
import SwiftyJSON
import RealmSwift

class AlbumInfo: Object {
    @objc dynamic var id = 0
    @objc dynamic var thumb_src = ""
    @objc dynamic var title = ""
    
    convenience init(json: JSON) {
        self.init()
        id = json["id"].intValue
        title = json["title"].stringValue
        thumb_src = json["thumb_src"].stringValue
    }
}

