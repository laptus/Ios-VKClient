//
//  RequestProtocol.swift
//  GeekBrainsApp
//
//  Created by Laptev Sasha on 11/12/2017.
//  Copyright © 2017 Laptev Sasha. All rights reserved.
//

import Foundation
import Alamofire

public protocol RequestRouter: URLRequestConvertible {
    var baseUrl: URL { get }
    var method: HTTPMethod { get }
    var path: String { get }
    var parameters: Parameters { get }
    var fullUrl: URL { get }
}

public extension RequestRouter {
    var fullUrl: URL {
        return baseUrl.appendingPathComponent(path)
    }
    
    func asURLRequest() throws -> URLRequest {
        var urlRequest = URLRequest(url: fullUrl)
        urlRequest.httpMethod = method.rawValue
        
        return try URLEncoding.default.encode(urlRequest, with: parameters)
    }
}

