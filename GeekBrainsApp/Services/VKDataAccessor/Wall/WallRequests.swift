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
    }
}


