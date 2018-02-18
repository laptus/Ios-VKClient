//
//  MessagesService.swift
//  GeekBrainsApp
//
//  Created by Laptev Sasha on 17/02/2018.
//  Copyright © 2018 Laptev Sasha. All rights reserved.
//

import Foundation
import Alamofire
import SwiftyJSON

extension VKAccessor.Messages{
    struct MessagesService{
        func getDialogs(){
            let token = VKAccessor.CurrentUser.instance.token
            let env = VKAccessor.EnvironmentImp.VKEnvironment()
            let request = MessagesRequests.getDialogs(environment: env, token: token)
            Alamofire.request(request).responseData(queue: DispatchQueue.global()){response in
                guard let data = response.value else { return }
                let json = try! JSON(data:data)
//                let albumsList = json["response"]["items"].array?.flatMap { AlbumInfo(json: $0) } ?? []
                print(json)
//                completion(albumsList)
            }
        }
        
        func getMessages(){
            
        }
        
        func postMessage(){
            
        }
    }
}
