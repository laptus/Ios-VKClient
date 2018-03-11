import Foundation

extension VKAccessor{
    class Messages {
        static let queue = DispatchQueue(label: "MessagesQueue", qos: .background, attributes:  DispatchQueue.Attributes.concurrent, autoreleaseFrequency: DispatchQueue . AutoreleaseFrequency .inherit, target: DispatchQueue .global(qos: DispatchQoS.QoSClass.background))
        
        static func getDialogs(completion: @escaping ([ChatInfo])-> Void){
            queue.async {
                MessagesService.getDialogs(completion: completion)
            }
        }
        
        static func getHistory(peerdId: String, completion: @escaping ([MessageInfo]) -> Void){
            queue.async {
                MessagesService.getHistory(peerId: peerdId, completion: completion)
            }
        }
        
        static func getChatInfo(chatId: String,completion: @escaping (_ title: String,_ avatar: String) -> Void){
            queue.async {
                MessagesService.getChatInfo(chatId: chatId,completion: completion)
            }
        }
        
        static func postMessage(peerId: String, message: String,
                                completion: @escaping (_ isSuccessful: Bool)-> Void){
            queue.async {
                MessagesService.postMessage(peerId: peerId, message: message, completion: completion).self
            }
        }
        
        static func postImage(peerId: String,ownerId:String, imageId: String,imageUrl: String,
                                completion: @escaping (_ isSuccessful: Bool,_ imageUrl: String)-> Void){
            queue.async {
                MessagesService.postImage(peerId: peerId, ownerId: ownerId, imageId: imageId, imageUrl: imageUrl, completion: completion)
            }
        }
    }
}
