import Foundation
import Alamofire


extension VKAccessor.Wall.WallService{
    struct WallRequests{
        static func getPostNewsRequest(environment: Environment, token: String, ownerId: String, message: String, attachment: String)-> URLRequestConvertible{
            let methodPath = "/method/wall.post"
            let requestParams = ["owner_id": ownerId,
                                 "message": message]
//                "attachments":attachment]
            return VKAccessor.VKRequest(environment: environment, token: token, path: methodPath, additionalParams: requestParams, httpMethod: HTTPMethod.get)
        }
        
        static func getPostNewsPhotoRequest(environment: Environment, token: String, ownerId: String, photoId: String)-> URLRequestConvertible{
            let methodPath = "/method/wall.post"
            let requestParams = ["owner_id": ownerId,
                            "attachments": "photo"+ownerId+"_"+photoId]
            return VKAccessor.VKRequest(environment: environment, token: token, path: methodPath, additionalParams: requestParams, httpMethod: HTTPMethod.get)
        }
        
        static func getWallPostRequest(environment: Environment, token: String, ownerId: String)-> URLRequestConvertible{
            let methodPath = "/method/wall.get"
            let requestParams = ["owner_id": ownerId]
            //                "attachments":attachment]
            return VKAccessor.VKRequest(environment: environment, token: token, path: methodPath, additionalParams: requestParams, httpMethod: HTTPMethod.get)
        }
    }
}


