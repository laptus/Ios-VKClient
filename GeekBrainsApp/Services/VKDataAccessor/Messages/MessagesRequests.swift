import Foundation
import Alamofire

extension VKAccessor.Messages.MessagesService{
    struct MessagesRequests{
        static func getDialogs(environment: Environment, token: String) -> URLRequestConvertible{
            let methodPath = "/method/messages.getDialogs"
            let additionalParams = ["access_token":token,
                                    "v": environment.apiVersion]
            return VKAccessor.VKRequest.init(environment: environment, token: token, path: methodPath, additionalParams: additionalParams, httpMethod: HTTPMethod.get)
        }
        
        func getMessages(){
            
        }
        
        func postMessage(){
            
        }
    }
}

