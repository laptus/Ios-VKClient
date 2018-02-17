import Foundation
import Alamofire

struct AuthRouter {
    
    private let environment: Environment
    
    func login() -> URLRequestConvertible {
        return Login(environment: environment)
    }
    
    init(environment: Environment){
        self.environment = environment
    }
    
//    private(set) lazy var notSingleton: NotSingleton = NotSingletonImp()
}

//protocol NotSingleton {
//    func someAction()
//}

//extension AuthRouter {
//    
//    private class NotSingletonImp: NotSingleton {
//        func someAction() {
//            
//        }
//    }
//    
//}

extension AuthRouter {
    
    private struct Login: RequestRouter {
        
        let environment: Environment
        
        init(environment: Environment) {
            self.environment = environment
        }
        
        var baseUrl: URL {
            return environment.authBaseUrl
        }
        
        let method: HTTPMethod = .get
        
        let path: String = "/authorize"
        
        var parameters: Parameters {
            return [
                "client_id": environment.clientId,
                "display": "mobile",
                "redirect_uri": "https://oauth.vk.com/blank.html",
                "scope": "270342",
                "response_type": "token",
                "v": environment.apiVersion
            ]
        }
    }
}

