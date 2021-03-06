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
        static func getDialogs(completion: @escaping (_ chats: [ChatInfo])-> Void){
            let token = VKAccessor.CurrentUser.instance.token
            let env = VKAccessor.EnvironmentImp.VKEnvironment()
            let request = MessagesRequests.getDialogs(environment: env, token: token)
            Alamofire.request(request).responseData(queue: DispatchQueue.global()){response in
                guard let data = response.value else { return }
                let json = try! JSON(data:data)
                let dialogs = json["response"]["items"].array?.flatMap { ChatInfo(json: $0) } ?? []
                DispatchQueue.main.async{
                    completion(dialogs)
                }
            }
        }
        
        static func getUnreadDialogsCount(completion: @escaping (_ count: Int)-> Void) -> Request{
            let token = VKAccessor.CurrentUser.instance.token
            let env = VKAccessor.EnvironmentImp.VKEnvironment()
            let request = MessagesRequests.getDialogs(environment: env, token: token)
            return Alamofire.request(request).responseData(queue: DispatchQueue.global()){response in
                guard let data = response.value else { return }
                let json = try! JSON(data:data)
                let unreadDialogsCount = json["response"]["unread_dialogs"].intValue
                DispatchQueue.main.async{
                    completion(unreadDialogsCount)
                }
            }
        }
        
        static func getChatInfo(chatId: String,
                                completion: @escaping (_ title: String,_ avatar: String) -> Void){
            let token = VKAccessor.CurrentUser.instance.token
            let env = VKAccessor.EnvironmentImp.VKEnvironment()
            let request = MessagesRequests.getChatInfo(environment: env, token: token, chatId: chatId)
            Alamofire.request(request).responseData(queue: DispatchQueue.global()){ response in
                guard let data = response.value else { return }
                let json = try! JSON(data:data)
                let title = json["response"]["title"].stringValue
                let photo = json["response"]["photo_50"].stringValue
                DispatchQueue.main.async{
                    completion(title,photo)
                }
            }
        }
        
        static func getHistory(peerId: String, completion: @escaping ([MessageInfo]) -> Void){
            let token = VKAccessor.CurrentUser.instance.token
            let env = VKAccessor.EnvironmentImp.VKEnvironment()
            let request = MessagesRequests.getHistory(environment: env, token: token, peerId: peerId)
            Alamofire.request(request).responseData(queue: DispatchQueue.global()){ response in
                guard let data = response.value else { return }
                let json = try! JSON(data:data)
                let messages = json["response"]["items"].array?.flatMap { MessageInfo(json: $0) } ?? []
                DispatchQueue.main.async{
                    completion(messages)
                }
            }
        }
        
        
        static func postMessage(peerId: String, message: String,
                         completion: @escaping (_ isSuccessful: Bool)-> Void){
            let token = VKAccessor.CurrentUser.instance.token
            let env = VKAccessor.EnvironmentImp.VKEnvironment()
            let request = MessagesRequests.postMessage(environment: env, token: token,peerId: peerId, message: message)
            Alamofire.request(request).responseData(queue: DispatchQueue.global()){response in
                guard let data = response.value else { return }
                let json = try! JSON(data:data)
                let wasNotSuccessful = json["error"].exists()
                DispatchQueue.main.async{
                    completion(!wasNotSuccessful)
                }
            }
        }
        
        static func postImage(peerId: String,ownerId:String, imageId: String, imageUrl: String,
                              completion: @escaping (_ isSuccessful: Bool,_ imageUrl: String)-> Void){
            let token = VKAccessor.CurrentUser.instance.token
            let env = VKAccessor.EnvironmentImp.VKEnvironment()
            let request = MessagesRequests.postImage(environment: env, token: token,peerId: peerId, ownerId: ownerId, imageId:imageId)
            Alamofire.request(request).responseData(queue: DispatchQueue.global()){response in
                guard let data = response.value else { return }
                let json = try! JSON(data:data)
                let wasNotSuccessful = json["error"].exists()
                DispatchQueue.main.async{
                    completion(!wasNotSuccessful, imageUrl)
                }
            }
        }
    }
}
