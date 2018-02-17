//
//  VKAccessor.swift
//  GeekBrainsApp
//
//  Created by Laptev Sasha on 11/02/2018.
//  Copyright © 2018 Laptev Sasha. All rights reserved.
//

import Foundation
import Alamofire


struct VKAccessor {
    
    class   UserInfo {
        var  fio =  ""
        var  id =  ""
        var  token =  ""
        
        static   let  instance =  UserInfo ()
        private   init (){}
    }
    
    struct VKRequest: RequestRouter {
        let environment: Environment
        let token: String
        var path: String
        
        
        init(environment: Environment, token: String, path: String, additionalParams: [String: String], httpMethod: HTTPMethod) {
            self.parameters = [String: Any]()
            self.token = token
            self.environment = environment
            self.path = path
            try? parameters.merge(["v": environment.apiVersion], uniquingKeysWith:uniquing)
            try? parameters.merge(["access_token": token], uniquingKeysWith:uniquing)
            try? parameters.merge(additionalParams,uniquingKeysWith:uniquing)
        }
        
        func uniquing(first: Any,second: Any) throws -> Any{
            return first
        }
        
        
        var baseUrl: URL {
            return environment.baseUrl
        }
        
        let method: HTTPMethod = .get
        
        //        var path = "/method/friends.get"
        
        var parameters: Parameters
        
    }
    
    struct EnvironmentImp {
        private init(){}
        
        struct VKEnvironment: Environment {
            let authBaseUrl = URL(string: "https://oauth.vk.com")!
            let baseUrl = URL(string: "https://api.vk.com")!
            var clientId = "6292833"
            var apiVersion = "5.68"
        }
        
    }
}

protocol Environment{
    var authBaseUrl: URL { get }
    var baseUrl: URL { get }
    var clientId: String { get }
    var apiVersion: String { get }
}
