//
//  RealmExtension.swift
//  GeekBrainsApp
//
//  Created by Laptev Sasha on 17/12/2017.
//  Copyright © 2017 Laptev Sasha. All rights reserved.
//

import Foundation
import RealmSwift


extension Realm{
    static func replaceObject<T: Object>(newObjects: [T]) throws{
        
        let realm = try Realm()
        let oldObjects = realm.objects(T.self)
        realm.beginWrite()
        realm.delete(oldObjects)
        realm.add(newObjects)
        try realm.commitWrite()
    }
    
    static func updateObject<T: Object>(newObjects: [T]) throws{
        
        let realm = try Realm()
        realm.beginWrite()
        realm.add(newObjects, update: true)
        try realm.commitWrite()
    }    
}
