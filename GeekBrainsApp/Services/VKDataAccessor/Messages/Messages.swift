//
//  Messages.swift
//  GeekBrainsApp
//
//  Created by Laptev Sasha on 17/02/2018.
//  Copyright © 2018 Laptev Sasha. All rights reserved.
//

import Foundation

extension VKAccessor{
    class Messages {
        static let queue = DispatchQueue(label: "MessagesQueue", qos: .background, attributes:  DispatchQueue.Attributes.concurrent, autoreleaseFrequency: DispatchQueue . AutoreleaseFrequency .inherit, target: DispatchQueue .global(qos: DispatchQoS.QoSClass.background))
    }
    
    static func getChats(){
        
    }
    
    static func getNewMessages(competion: @escaping ()-> Void) -> URLRequest?{
        return nil
    }
    
    static func getMessages(){
        
    }
    
    static func postMessage(){
        
    }
}
