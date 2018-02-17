//
//  PhotosRouter.swift
//  GeekBrainsApp
//
//  Created by Laptev Sasha on 11/12/2017.
//  Copyright © 2017 Laptev Sasha. All rights reserved.
//

import Foundation
import Alamofire

class PhotosRouter{
    private let token: String
    private let enviroment: Environment
    
    init(token: String, enviroment: Environment){
        self.token = token
        self.enviroment = enviroment
    }
    
    func getUserPhotos(ownerId: Int) -> URLRequestConvertible {
        return PhotoListRouter(enviroment: enviroment, token: token, ownerId: ownerId)
    }
}

extension PhotosRouter{
    
    struct PhotoListRouter: RequestRouter{
        let enviroment: Environment
        let ownerId: Int
        let token: String
        init(enviroment: Environment, token: String, ownerId: Int){
            self.token = token
            self.enviroment = enviroment
            self.ownerId = -ownerId
        }
        
        var method: HTTPMethod = .get
        
        var baseUrl: URL {
            return enviroment.baseUrl
        }
        
        var path : String = "/method/photos.getAll"
        
        var parameters: Parameters {return
            ["owner_id": ownerId,
             "access_token":token,
             "v": enviroment.apiVersion,
             "fields":"nickname,domain,photo_50"]
        }
    }
}
