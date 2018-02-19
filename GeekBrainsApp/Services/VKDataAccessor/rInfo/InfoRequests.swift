import Foundation
import Alamofire


extension VKAccessor.Info.InfoService{
    struct InfoRequests{
        static func getUserInfoRequest(environment: Environment, token: String, userId: String)-> URLRequestConvertible{
            let methodPath = "/method/users.get"
            let requestParams = ["user_ids": userId
                ,"fields":"first_name,last_name,photo_100"]
            return VKAccessor.VKRequest(environment: environment, token: token, path: methodPath, additionalParams: requestParams, httpMethod: HTTPMethod.get)
        }
        
        static func getGroupInfoRequest(environment: Environment, token: String, groupId: String)-> URLRequestConvertible{
            let methodPath = "/method/groups.getById"
            let requestParams = ["group_id":groupId,
                                 "fields":"description"]
            return VKAccessor.VKRequest(environment: environment, token: token, path: methodPath, additionalParams: requestParams, httpMethod: HTTPMethod.get)
        }
    }
}

