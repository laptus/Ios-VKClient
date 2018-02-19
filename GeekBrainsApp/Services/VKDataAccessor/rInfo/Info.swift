//
//  User.swift
//  GeekBrainsApp
//
//  Created by Laptev Sasha on 14/02/2018.
//  Copyright © 2018 Laptev Sasha. All rights reserved.
//

import Foundation
import SwiftyJSON

extension VKAccessor{
    class Info {
        static let queue = DispatchQueue(label: "InfoQeueu", qos: .background, attributes:  DispatchQueue.Attributes.concurrent, autoreleaseFrequency: DispatchQueue . AutoreleaseFrequency .inherit, target: DispatchQueue .global(qos: DispatchQoS.QoSClass.background))
        
        static func getInfo(userId: String, competion: @escaping (_ firstName: String, _ lastName: String, _ avatarPath: String)-> Void){
            queue.async{
                InfoService().getUserInfo(userId: userId, competion: competion)
            }
        }
        
        static func getInfo(groupId: String,completion: @escaping (_ firstName: String, _ lastName: String, _ avatarPath: String)-> Void){
            queue.async{
                InfoService().getGroupInfo(groupId: groupId, competion: completion)
            }
        }
    }
}
