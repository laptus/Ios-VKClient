import Foundation


extension VKAccessor{
    class Wall {
        static let queue = DispatchQueue(label: "WallQeueu", qos: .background, attributes:  DispatchQueue.Attributes.concurrent, autoreleaseFrequency: DispatchQueue . AutoreleaseFrequency .inherit, target: DispatchQueue .global(qos: DispatchQoS.QoSClass.background))
        
        static func postNews(userId: String, message: String, photosIds: [String]){
            queue.async{
                WallService().postNews(ownerId: userId, message: message, photosIds: photosIds)
            }
        }
    }
}

