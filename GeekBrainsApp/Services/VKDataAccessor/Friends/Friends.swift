//
//  Friends.swift
//  GeekBrainsApp
//
//  Created by Laptev Sasha on 11/02/2018.
//  Copyright © 2018 Laptev Sasha. All rights reserved.
//

import Foundation
import Alamofire
import SwiftyJSON
import RealmSwift

extension VKAccessor  {
    class Friends{
        static let queue = DispatchQueue(label: "FriendsQueue", qos: .background, attributes:  DispatchQueue.Attributes.concurrent, autoreleaseFrequency: DispatchQueue . AutoreleaseFrequency .inherit, target: DispatchQueue .global(qos: DispatchQoS.QoSClass.background))
        
        static func delete(friendsId: String){
            queue.async {
                let service = FriendsService()
                service.deleteFriend(friendsId: friendsId)
                service.getFriendsList()
            }
        }
        
        static func get(){
            queue.async {
                let service = FriendsService()
                service.getFriendsList()
            }
        }
        
        func saveToRealm(){
            
        }
    }
}
