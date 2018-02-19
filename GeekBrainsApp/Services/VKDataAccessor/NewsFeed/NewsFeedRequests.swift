import Foundation
import Alamofire

extension VKAccessor.News.NewsService{
    struct NewsRequests {
        static func getNews(environment: Environment, token: String)-> URLRequestConvertible{
            let methodPath = "/method/newsfeed.get"
            let additionalParams = ["access_token":token,
                "v": environment.apiVersion]
            return VKAccessor.VKRequest.init(environment: environment, token: token, path: methodPath, additionalParams: additionalParams, httpMethod: HTTPMethod.get)
        }
        
        static func post(environment: Environment, token: String)-> URLRequestConvertible{
            let methodPath = "/method/photos.getAll"
            let additionalParams = ["access_token":token,
                                    "v": environment.apiVersion,
                                    "fields":"description"]
            return VKAccessor.VKRequest.init(environment: environment, token: token, path: methodPath, additionalParams: additionalParams, httpMethod: HTTPMethod.post)
        }
    }
}

