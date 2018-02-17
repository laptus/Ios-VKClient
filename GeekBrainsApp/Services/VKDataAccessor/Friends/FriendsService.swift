//
//  FriendsService.swift
//  GeekBrainsApp
//
//  Created by Laptev Sasha on 13/02/2018.
//  Copyright © 2018 Laptev Sasha. All rights reserved.
//

import Foundation
import Alamofire
import SwiftyJSON
import Realm
import RealmSwift

extension VKAccessor{
    struct FriendsService{
        
        func getFriendsList(){
            let token = VKAccessor.UserInfo.instance.token
            let env = VKAccessor.EnvironmentImp.VKEnvironment()
            let request =  FriendsRequests.getFriendsListRequest(environment: env, token: token)
            Alamofire.request(request).responseData(queue: DispatchQueue.global(), completionHandler: saveToRealm)
        }
        
        private func saveToRealm(response :DataResponse<Data>){
            guard let data = response.value else { return }
            let json = try! JSON(data:data)
            print(json)
            //            let friendsList = json["response"]["items"].array?.flatMap { UserInfo(json: $0) } ?? []
            //            do{
            //                try Realm.replaceObject(newObjects: friendsList)
            //                //                DispatchQueue.main.async {
            //                //                    completion()
            //                //                }
            //            }
            //            catch{
            //                print(error)
            //            }
        }
        
        func deleteFriend(friendsId: String){
            let token = VKAccessor.UserInfo.instance.token
            let env = VKAccessor.EnvironmentImp.VKEnvironment()
            let request = FriendsRequests.deleteFriendRequest(environment: env, token: token, friendsId: friendsId)
            Alamofire.request(request).responseData(queue: DispatchQueue.global()){response in
                guard let data = response.value else { return }
                let json = try! JSON(data:data)
                print(json)
                //            let friendsList = json["response"]["items"].array?.flatMap { UserInfo(json: $0) } ?? []
                //            do{
                //                try Realm.replaceObject(newObjects: friendsList)
                //                //                DispatchQueue.main.async {
                //                //                    completion()
                //                //                }
                //            }
                //            catch{
                //                print(error)
                //            }
            }
        }
        
    }
}

