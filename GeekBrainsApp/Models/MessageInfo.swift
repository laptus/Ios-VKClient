import Foundation
import SwiftyJSON

struct MessageInfo{
    var userId: Int
    var text: String
    var photos: [String]
    
    init(json: JSON){
        userId = json["from_id"].intValue
        text = json["body"].stringValue
        photos = json["attachments"].array?.flatMap{$0["photo"]["photo_130"].stringValue} ?? []
    }
    
    init(id: Int, message: String, photosPaths: [String]){
        userId = id
        text = message
        photos = photosPaths
    }
}
