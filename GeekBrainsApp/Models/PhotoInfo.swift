import Foundation
import SwiftyJSON
import RealmSwift

class PhotoInfo: Object {
    @objc dynamic var url = ""
    
    convenience init(json: JSON) {
        self.init()
        url = json["photo_130"].stringValue
    }
}
