import Foundation

extension VKAccessor{
    class Messages {
        static let queue = DispatchQueue(label: "MessagesQueue", qos: .background, attributes:  DispatchQueue.Attributes.concurrent, autoreleaseFrequency: DispatchQueue . AutoreleaseFrequency .inherit, target: DispatchQueue .global(qos: DispatchQoS.QoSClass.background))
        
        static func getDialogs(){
            queue.async {
                MessagesService().getDialogs()
            }
        }
        
        static func getNewMessages(competion: @escaping ()-> Void) -> URLRequest?{
            return nil
        }
        
        static func getMessages(){
            
        }
        
        static func postMessage(){
            
        }
    }
}
