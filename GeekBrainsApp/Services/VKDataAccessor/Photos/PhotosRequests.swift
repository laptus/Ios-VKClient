//
//  PhotosRequests.swift
//  GeekBrainsApp
//
//  Created by Laptev Sasha on 14/02/2018.
//  Copyright © 2018 Laptev Sasha. All rights reserved.
//

import Foundation
import Alamofire

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
    }
}
