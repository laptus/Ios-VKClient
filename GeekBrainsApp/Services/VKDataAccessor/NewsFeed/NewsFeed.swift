//
//  Photos.swift
//  GeekBrainsApp
//
//  Created by Laptev Sasha on 14/02/2018.
//  Copyright © 2018 Laptev Sasha. All rights reserved.
//

import Foundation
extension VKAccessor  {
    class News{
        static let queue = DispatchQueue(label: "News", qos: .background, attributes:  DispatchQueue.Attributes.concurrent, autoreleaseFrequency: DispatchQueue . AutoreleaseFrequency .inherit, target: DispatchQueue .global(qos: DispatchQoS.QoSClass.background))
        
        static func saveNewsToRealm(){
            queue.async {
                let service = NewsService()
                service.getNewsAndSaveToRealm()
            }
        }
        
        static func postNews(){
            queue.async {
            }
        }
        
        static func uploadPhotoToWall(image: Data, completion: @escaping (_ isSuccessful: Bool)-> Void){
            queue.async {
                VKAccessor.Photos.uploadPhotoToWall(image: image, completion: completion)
            }
        }
    }
}

