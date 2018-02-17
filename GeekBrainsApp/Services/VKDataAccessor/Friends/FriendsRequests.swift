//
//  FriendsRouter.swift
//  GeekBrainsApp
//
//  Created by Laptev Sasha on 13/02/2018.
//  Copyright © 2018 Laptev Sasha. All rights reserved.
//

import Foundation
import Alamofire

extension VKAccessor{
    
    struct FriendsRequests{
        
        static func getFriendsListRequest(environment: Environment, token: String)-> URLRequestConvertible{
            let methodPath = "/method/friends.get"
            let requestParams = ["fields":"nickname,domain,photo_100"]
            return VKRequest(environment: environment, token: token, path: methodPath, additionalParams: requestParams, httpMethod: HTTPMethod.get)
        }
        
        static func deleteFriendRequest(environment: Environment, token: String, friendsId: String)-> URLRequestConvertible{
            let methodPath = "/method/friends.delete"
            let requestParams = ["user_id":friendsId]
            return VKRequest(environment: environment, token: token, path: methodPath, additionalParams: requestParams, httpMethod: HTTPMethod.post)
        }
    }
}


    
   

