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
        
        static func postMessage(userId: String, peerId: String, chatId: String, message: String,
                                completion: @escaping (_ isSuccessful: Bool)-> Void){
            queue.async {
            }
        }
    }
}
