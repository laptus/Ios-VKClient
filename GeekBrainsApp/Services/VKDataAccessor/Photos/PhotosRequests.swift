import Foundation
import Alamofire
import SwiftyJSON

extension VKAccessor  {
    struct PhotosRequests {
        static func getAlbums(environment: Environment, token: String, ownerId: String)-> URLRequestConvertible{
            let methodPath = "/method/photos.getAlbums"
            let additionalParams = ["owner_id": ownerId,
//                                    "access_token":token,
                                    "v": environment.apiVersion,
                                    "need_covers":"1",
                                    "need_system":"1"]
            return VKRequest.init(environment: environment, token: token, path: methodPath, additionalParams: additionalParams, httpMethod: HTTPMethod.get)
        }
        
        static func getPhotos(environment: Environment, token: String, ownerId: String)-> URLRequestConvertible{
            let methodPath = "/method/photos.getAll"
            let additionalParams = ["owner_id": ownerId,
                                    "access_token":token,
                                    "v": environment.apiVersion,
                                    "fields":"nickname,domain,photo_50"]
            return VKRequest.init(environment: environment, token: token, path: methodPath, additionalParams: additionalParams, httpMethod: HTTPMethod.get)
        }
        
        static func getPhotos(environment: Environment, token: String, ownerId: String,albumId: String)-> URLRequestConvertible{
            let methodPath = "/method/photos.get"
            let additionalParams = ["owner_id": ownerId,
                                    "album_id": albumId,
                                    "access_token":token,
                                    "v": environment.apiVersion]
            return VKRequest.init(environment: environment, token: token, path: methodPath, additionalParams: additionalParams, httpMethod: HTTPMethod.get)
        }
        
        static func getWallUploadServer(environment: Environment, token: String) -> URLRequestConvertible{
            let methodPath = "/method/photos.getWallUploadServer"
            let additionalParams = ["access_token":token,
                                    "v": environment.apiVersion]
            return VKRequest.init(environment: environment, token: token, path: methodPath, additionalParams: additionalParams, httpMethod: HTTPMethod.get)
        }
        
        static func saveWallPhoto(environment: Environment, token: String, userId: String, server: String, photo: String,hash: String) -> URLRequestConvertible{
            let methodPath = "/method/photos.saveWallPhoto"
            let additionalParams = ["access_token":token,
                                    "server": server,
                                    "photo": photo,
                                    "hash": hash,
                                    "v": environment.apiVersion] as [String : Any]
            return VKRequest.init(environment: environment, token: token, path: methodPath, additionalParams: additionalParams as! [String : String], httpMethod: HTTPMethod.get)
        }
        
        static func getMessagesUploadServer(environment: Environment, token: String) -> URLRequestConvertible{
            let methodPath = "/method/photos.getMessagesUploadServer"
            let additionalParams = ["access_token":token,
                                    "v": environment.apiVersion]
            return VKRequest.init(environment: environment, token: token, path: methodPath, additionalParams: additionalParams, httpMethod: HTTPMethod.get)
        }
    }
}
