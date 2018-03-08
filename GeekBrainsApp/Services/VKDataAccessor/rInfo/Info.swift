import Foundation

extension VKAccessor{
    class Info {
        static let queue = DispatchQueue(label: "InfoQeueu", qos: .background, attributes:  DispatchQueue.Attributes.concurrent, autoreleaseFrequency: DispatchQueue . AutoreleaseFrequency .inherit, target: DispatchQueue .global(qos: DispatchQoS.QoSClass.background))
        
//        static func getInfo(id: Int, competion: @escaping (_ firstName: String, _ lastName: String, _ avatarPath: String)-> Void){
//            if (id < 0){
//                getInfo(groupId: String(abs(id)), completion: competion)
//            }else{
//                getInfo(userId: String(id), competion: competion)
//            }
//        }
//
        static func getInfo(id: Int, competion: @escaping (_ id:String,_ firstName: String, _ lastName: String, _ avatarPath: String)-> Void){
            if (id < 0){
                getInfo(groupId: String(abs(id)), completion: competion)
            }else{
                getInfo(userId: String(id), competion: competion)
            }
        }
        
//        static func getInfo(userId: String, competion: @escaping (_ firstName: String, _ lastName: String, _ avatarPath: String)-> Void){
//            queue.async{
//                InfoService().getUserInfo(userId: userId, competion: competion)
//            }
//        }
//        
//        static func getInfo(groupId: String,completion: @escaping (_ firstName: String, _ lastName: String, _ avatarPath: String)-> Void){
//            queue.async{
//                InfoService().getGroupInfo(groupId: groupId, competion: completion)
//            }
//        }
        
        static func getInfo(userId: String, competion: @escaping (_ id:String,_ firstName: String, _ lastName: String, _ avatarPath: String)-> Void){
            queue.async{
                InfoService().getUserInfo(userId: userId, competion: competion)
            }
        }
        
        static func getInfo(groupId: String,completion: @escaping (_ id:String,_ firstName: String, _ lastName: String, _ avatarPath: String)-> Void){
            queue.async{
                InfoService().getGroupInfo(groupId: groupId, competion: completion)
            }
        }
    }
}
