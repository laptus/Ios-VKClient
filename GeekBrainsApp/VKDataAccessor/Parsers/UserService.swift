////
////  UserService.swift
////  GBVK
////
////  Created by Евгений Елчев on 03.10.2017.
////  Copyright © 2017 JonFir. All rights reserved.
////
//
import Foundation
import Alamofire
import SwiftyJSON
import RealmSwift

class UserService{
    private let userRouter: UserRouter
    
    init(environment: Environment, token: String) {
        userRouter = UserRouter(environment: environment, token: token)
    }
    
    func downloadFriendsList(){
        Alamofire.request(userRouter.userList()).responseData{
            response in
            guard let data = response.value else { return }
//            print(data)
            let json = try! JSON(data:data)
            print(json)
            let friendsList = json["response"]["items"].array?.flatMap { UserInfo(json: $0) } ?? []
            do{
                try Realm.replaceObject(newObjects: friendsList)
//                DispatchQueue.main.async {
//                    completion()
//                }
            }
            catch{
                print(error)
            }
        }
    }
    
    func downloadPhoto(forUser user: Int) {
        Alamofire.request(userRouter.userPhotoList(ownerId: user)).responseData(queue: .global(qos: .userInitiated)) { response in
            
            guard let data = response.value else { return }
            let json = try! JSON(data: data)
            let photosList = json["response"]["items"].array?.flatMap { PhotoInfo(json: $0) } ?? []
            do{
                try Realm.replaceObject(newObjects: photosList)
            }
            catch{
                print(error)
            }
        }
    }
}

//
//struct UserService {
//    
//    private let router: UserRouter
//    
//    init(environment: Environment, token: String) {
//        router = UserRouter(environment: environment, token: token)
//    }
//    
//    func dowloadFriends() {
//        Alamofire.request(router.userList()).responseData(queue: .global(qos: .userInitiated)) { response in
//            
//            guard let data = response.value else { return }
//            let json = JSON(data: data)
//            let users = json["response"]["items"].array?.flatMap { User(json: $0) } ?? []
//            
//        }
//    }
//    
//    func downloadPhoto(forUser user: Int, completion: @escaping ([Photo]) -> Void) {
//        Alamofire.request(router.userPhotoList(ownerId: user)).responseData(queue: .global(qos: .userInitiated)) { response in
//            
//            guard let data = response.value else { return }
//            let json = JSON(data: data)
//            let photos = json["response"]["items"].array?.flatMap { Photo(json: $0) } ?? []
//            DispatchQueue.main.async {
//                completion(photos)
//            }
//        }
//    }
//    
//    func loadFriends() -> [User] {
//        do {
//            let realm = try Realm()
//            return Array(realm.objects(User.self))
//        } catch {
//            print(error)
//            return []
//        }
//    }
//    
//    
//}
//
