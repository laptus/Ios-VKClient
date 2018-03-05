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
    
    init(id: Int, message: String, photosPaths: [String]){
        userId = id
        text = message
        photos = photosPaths
    }
}
