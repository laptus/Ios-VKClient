//
//  UserService.swift
//  GeekBrainsApp
//
//  Created by Laptev Sasha on 14/02/2018.
//  Copyright © 2018 Laptev Sasha. All rights reserved.
//

import Foundation
import Alamofire
import SwiftyJSON
import UIKit

extension VKAccessor.Wall{
    struct WallService{
        func postNews(ownerId: String, message: String, photosIds: [String]){
            let token = VKAccessor.CurrentUser.instance.token
            let env = VKAccessor.EnvironmentImp.VKEnvironment()
            let request = WallRequests.getPostNewsRequest(environment: env, token: token, ownerId: ownerId, message: message, attachment: "")
            Alamofire.request(request).responseData(queue: DispatchQueue.global()){response in
                guard let data = response.value else { return }
                let json = try! JSON(data:data)
            }
        }
        
        func getNews(ownerId: String, completion: @escaping ([NewsInfo])->Void){
            let token = VKAccessor.CurrentUser.instance.token
            let env = VKAccessor.EnvironmentImp.VKEnvironment()
            let request = WallRequests.getWallPostRequest(environment: env, token: token, ownerId: ownerId)
            Alamofire.request(request).responseData(queue: DispatchQueue.global()){response in
                guard let data = response.value else { return }
                let json = try! JSON(data:data)
                let news = json["response"]["items"].array?.flatMap { NewsInfo(json: $0) } ?? []
                completion(news)
            }
        }
    }
}

