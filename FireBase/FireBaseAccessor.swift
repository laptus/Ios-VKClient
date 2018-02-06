//
//  FireBaseAccessor.swift
//  GeekBrainsApp
//
//  Created by Laptev Sasha on 06/02/2018.
//  Copyright © 2018 Laptev Sasha. All rights reserved.
//

import Foundation
import Firebase
import FirebaseDatabase

class FireVaseAcessor{
    
    static func adduser(_ user: String){
        let dbLink = Database.database().reference()
        dbLink.child("UsersData").setValue(["user": user])
        
    }
    
    static func addGroup(user:String, groups: [GroupInfo]){
        let dbLink = Database.database().reference()
        dbLink.child("UsersData").updateChildValues(["user":user,"groups":groups.map{$0.toAnyObject}])
    }
}
