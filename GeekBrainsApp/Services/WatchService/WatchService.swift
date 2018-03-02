//
//  WatchService.swift
//  GeekBrainsApp
//
//  Created by Laptev Sasha on 28/02/2018.
//  Copyright © 2018 Laptev Sasha. All rights reserved.
//

import Foundation
import WatchConnectivity
import RealmSwift

class WCSessionService: NSObject,WCSessionDelegate{
    var session: WCSession?
    
    public override init(){
        super.init()
        if WCSession.isSupported(){
            session = WCSession.default
            session?.delegate = self
            session?.activate()
        }
    }
    
    public func session(_ session: WCSession, activationDidCompleteWith activationState: WCSessionActivationState, error: Error?){
        
    }
    
    func session(_ session: WCSession, didReceiveMessageData messageData: Data, replyHandler: @escaping (Data) -> Void) {
        
    }
    
    func session(_ session: WCSession, didReceiveMessage message: [String : Any], replyHandler: @escaping ([String : Any]) -> Void) {
        if message["request"] as? String == "getFriendsList"{
            do{
                let answerData = try getFriends()
                replyHandler(answerData)
            } catch{
                print(error)
            }
        }
        if message["request"] as? String == "getFriendsMessages"{
            
            
        }
    }
    
    func getFriends() throws -> [String : Any]{
        let realm = try Realm()
        let friednsRealm = realm.objects(UserInfo.self)
        var tempData : [String:Any] = [:]
        let maxCount = min(10, friednsRealm.count)
        for i in 0..<maxCount{
            let friend = friednsRealm[i]
            let imageData = try Data(contentsOf: URL(string: friend.photoUrl)!)
            tempData[String(i)] = ["name": friend.name,"id": friend.id, "image": imageData]
        }
        tempData["count"] = maxCount
        return tempData
    }
    
    public func sessionDidBecomeInactive(_ session: WCSession){
        
    }
    
    public func sessionDidDeactivate(_ session: WCSession){
        
    }
}
