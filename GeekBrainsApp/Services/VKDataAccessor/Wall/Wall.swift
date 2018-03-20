import Foundation


extension VKAccessor{
    class Wall {
        static let queue = DispatchQueue(label: "WallQeueu", qos: .background, attributes:  DispatchQueue.Attributes.concurrent, autoreleaseFrequency: DispatchQueue . AutoreleaseFrequency .inherit, target: DispatchQueue .global(qos: DispatchQoS.QoSClass.background))
        
        static func postNews(userId: String, message: String, photosIds: [String]){
            queue.async{
                WallService().postNews(ownerId: userId, message: message, photosIds: photosIds)
            }
        }
        
        static func getPosts(userId: String, completion: @escaping ([NewsInfo])->Void){
            queue.async{
                WallService().getNews(ownerId: userId, completion: completion)
            }
        }
        
        static func postNewsPhoto(userId: String, photosId: String, completion: @escaping (_ isSuccessful: Bool)-> Void){
            queue.async{
                WallService().postNewsPhoto(ownerId: userId, photoId: photosId,completion: completion)
            }
        }
    }
}

