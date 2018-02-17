//
//  User.swift
//  GeekBrainsApp
//
//  Created by Laptev Sasha on 14/02/2018.
//  Copyright © 2018 Laptev Sasha. All rights reserved.
//

import Foundation

extension VKAccessor{
    class User {
        static let queue = DispatchQueue(label: "UserinfoQeueu", qos: .background, attributes:  DispatchQueue.Attributes.concurrent, autoreleaseFrequency: DispatchQueue . AutoreleaseFrequency .inherit, target: DispatchQueue .global(qos: DispatchQoS.QoSClass.background))
        
        static func getInfo(id: String){
            queue.async{
                
            }
        }
    }
}
