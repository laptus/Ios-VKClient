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
        
        static func getHistory(environment: Environment, token: String, peerId: String) -> URLRequestConvertible{
            let methodPath = "/method/messages.getHistory"
            let additionalParams = ["access_token":token,
                                    "v": environment.apiVersion,
                                    "peer_id": peerId]
            return VKAccessor.VKRequest.init(environment: environment, token: token, path: methodPath, additionalParams: additionalParams, httpMethod: HTTPMethod.get)
        }
        
        static func getChatInfo(environment: Environment, token: String, chatId: String) -> URLRequestConvertible{
            let methodPath = "/method/messages.getChat"
            let additionalParams = ["access_token":token,
                                    "v": environment.apiVersion,
                                    "chat_id": chatId]
            return VKAccessor.VKRequest.init(environment: environment, token: token, path: methodPath, additionalParams: additionalParams, httpMethod: HTTPMethod.get)
        }
        
        static func postMessage(environment: Environment, token: String,peerId: String, message: String)-> URLRequestConvertible{
            let methodPath = "/method/messages.send"
            let additionalParams = ["access_token":token,
                                    "v": environment.apiVersion,
                                    "peer_id": peerId,
                                    "message": message]
            return VKAccessor.VKRequest.init(environment: environment, token: token, path: methodPath, additionalParams: additionalParams, httpMethod: HTTPMethod.post)
        }
        
        static func postImage(environment: Environment, token: String,peerId: String, ownerId:String, imageId: String) -> URLRequestConvertible{
            let methodPath = "/method/messages.send"
            let additionalParams = ["access_token":token,
                                    "v": environment.apiVersion,
                                    "peer_id": peerId,
                                    "attachment": "photo"+ownerId+"_"+imageId]
            return VKAccessor.VKRequest.init(environment: environment, token: token, path: methodPath, additionalParams: additionalParams, httpMethod: HTTPMethod.post)
        }
    }
}

