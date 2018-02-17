//
//  GroupService.swift
//  GeekBrainsApp
//
//  Created by Laptev Sasha on 13/12/2017.
//  Copyright © 2017 Laptev Sasha. All rights reserved.
//

import Foundation

import Foundation
import Alamofire
import SwiftyJSON
import RealmSwift

struct GroupService{
    private let router: GroupsRouter
    
    init(environment: Environment, token: String) {
        router = GroupsRouter(environment: environment, token: token)
    }
    
    func getGroupById( ){
        
        Alamofire.request(router.getGroupsById()).responseData(queue: .global(qos: .userInitiated)) { response in
            
            guard let data = response.value else { return }
            print(data)
            let json = try! JSON(data:data)
            let groupsList = json["response"]["items"].array?.flatMap { GroupInfo(json: $0) } ?? []
            do{
                try Realm.replaceObject(newObjects: groupsList)
            }catch{
                print(error)
            }
        }
    }
    
    func searchGroups(request: String, completion: @escaping ([GroupInfo]) -> () ) {
        Alamofire.request(router.searchGroup(request: request)).responseData(queue: .global(qos: .userInitiated)) { response in
            guard let data = response.value else { return }
            let json = try! JSON(data: data)
            let groups = json["response"]["items"].array?.flatMap { GroupInfo(json: $0) } ?? []
            completion(groups)
        }
    }
}
