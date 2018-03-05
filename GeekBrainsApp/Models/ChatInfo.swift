import Foundation
import SwiftyJSON
import RealmSwift

class ChatInfo {
    var userId: Int?
    var lastMessage: String
    var groupChatId: Int?
    
    init(json: JSON) {
        self.groupChatId = json["message"]["chat_id"].exists() ? json["message"]["chat_id"].intValue : nil
        self.lastMessage = json["message"]["body"].stringValue
        self.userId = json["message"]["chat_id"].exists() ? nil : json["message"]["user_id"].intValue
    }
}

