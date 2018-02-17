//
//  GroupsRouter.swift
//  GeekBrainsApp
//
//  Created by Laptev Sasha on 11/12/2017.
//  Copyright © 2017 Laptev Sasha. All rights reserved.
//

import Foundation
import Alamofire

class GroupsRouter{
    private let enviroment: Environment
    private let token: String
    
    init(environment: Environment, token: String){
        self.enviroment = environment
        self.token = token
    }
    
    func getGroupsById() -> URLRequestConvertible {
        return GrouopListRouter(environment: enviroment, token: token)
    }
    
    func searchGroup(request: String) -> URLRequestConvertible {
        return SearchGroup(environment: enviroment, token: token, requestString: request)
    }
}

extension GroupsRouter{
    struct GrouopListRouter: RequestRouter{
        let environment: Environment
        let token: String
        
        init(environment: Environment, token: String) {
            self.environment = environment
            self.token = token
        }
        
        var baseUrl: URL {
            return environment.baseUrl
        }
        
        let method: HTTPMethod = .get
        
        var path = "/method/groups.get"
        
        var parameters: Parameters {
            return [
                "extended": 1,
                "access_token": token,
                "v": environment.apiVersion
            ]
        }
    }
}
extension GroupsRouter{
    
private struct SearchGroup: RequestRouter {
    let environment: Environment
    let token: String
    let requestString: String
    
    init(environment: Environment, token: String, requestString: String) {
        self.environment = environment
        self.token = token
        self.requestString = requestString
    }
    
    var baseUrl: URL {
        return environment.baseUrl
    }
    
    let method: HTTPMethod = .get
    
    var path = "/method/groups.search"
    
    var parameters: Parameters {
        return [
            "q": requestString,
            "type": "group",
            "access_token": token,
            "v": environment.apiVersion
        ]
    }
}
}
