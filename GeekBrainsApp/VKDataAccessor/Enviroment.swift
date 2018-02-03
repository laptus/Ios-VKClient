//
//  VKDataAccessor.swift
//  GeekBrainsApp
//
//  Created by Laptev Sasha on 10/12/2017.
//  Copyright © 2017 Laptev Sasha. All rights reserved.
//
import Foundation
import Alamofire

struct EnvironmentImp {
    private init(){}
}

extension EnvironmentImp {
    
    struct VKEnvironment: Environment {
        let authBaseUrl = URL(string: "https://oauth.vk.com")!
        let baseUrl = URL(string: "https://api.vk.com")!
        var clientId = "6292833"
        var apiVersion = "5.68"
    }
    
}

protocol Environment{
    var authBaseUrl: URL { get }
    var baseUrl: URL { get }
    var clientId: String { get }
    var apiVersion: String { get }  
}
