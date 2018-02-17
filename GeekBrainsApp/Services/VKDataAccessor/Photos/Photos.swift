//
//  Photos.swift
//  GeekBrainsApp
//
//  Created by Laptev Sasha on 14/02/2018.
//  Copyright © 2018 Laptev Sasha. All rights reserved.
//

import Foundation
extension VKAccessor  {
    class Photos{
        static let queue = DispatchQueue(label: "Photots", qos: .background, attributes:  DispatchQueue.Attributes.concurrent, autoreleaseFrequency: DispatchQueue . AutoreleaseFrequency .inherit, target: DispatchQueue .global(qos: DispatchQoS.QoSClass.background))
        
        static func getAlbums(ownerId: String){
            queue.async {
                let service = PhototService()
                service.getAlbums(ownerId: ownerId)
            }
        }
        
        static func getPhotos(ownerId: String, competion:@escaping ()-> Void){
            queue.async {
                let service = PhototService()
                service.getPhotos(ownerId: ownerId)
            }
        }
        
        static func getPhotos(ownerId: String, albumId: String){
            queue.async {
                let service = PhototService()
                service.getPhotos(ownerId: ownerId,albumId: albumId)
            }
        }
    }
}
