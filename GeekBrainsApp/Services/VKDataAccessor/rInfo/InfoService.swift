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

extension VKAccessor.Info{
    struct InfoService{
        func getUserInfo(userId: String, competion: @escaping (_ firstName: String, _ lastName: String, _ avatarPath: String)-> Void){
            let token = VKAccessor.CurrentUser.instance.token
            let env = VKAccessor.EnvironmentImp.VKEnvironment()
            let request = InfoRequests.getUserInfoRequest(environment: env, token: token, userId: userId)
            Alamofire.request(request).responseData(queue: DispatchQueue.global()){response in
                guard let data = response.value else { return }
                let json = try! JSON(data:data)
                let res = json["response"][0]
                let fName = res["first_name"].stringValue
                let lName = json["response"][0]["last_name"].stringValue
                let pPath = json["response"][0]["photo_100"].stringValue
                competion(fName,lName,pPath)
            }
        }
        
        func getGroupInfo(groupId: String, competion: @escaping (_ firstName: String, _ lastName: String, _ avatarPath: String)-> Void){
            let token = VKAccessor.CurrentUser.instance.token
            let env = VKAccessor.EnvironmentImp.VKEnvironment()
            let request = InfoRequests.getGroupInfoRequest(environment: env, token: token, groupId: groupId)
            Alamofire.request(request).responseData(queue: DispatchQueue.global()){response in
                guard let data = response.value else { return }
                let json = try! JSON(data:data)
                let fName = json["response"].array?[0]["name"].stringValue ?? ""
                let lName = json["response"].array?[0]["screen_name"].stringValue ?? ""
                let pPath = json["response"].array?[0]["photo_100"].stringValue ?? ""
                competion(fName,lName,pPath)
            }
        }
    }
}
