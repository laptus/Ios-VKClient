//
//  ImageService.swift
//  GeekBrainsApp
//
//  Created by Laptev Sasha on 14/02/2018.
//  Copyright © 2018 Laptev Sasha. All rights reserved.
//

import Foundation
import Alamofire
import AlamofireImage

class ImageService{
    static let queue = DispatchQueue(label: "AlamofireImage", qos: .background, attributes:  DispatchQueue.Attributes.concurrent, autoreleaseFrequency: DispatchQueue . AutoreleaseFrequency .inherit, target: DispatchQueue .global(qos: DispatchQoS.QoSClass.background))
    
    static let imageCache = AutoPurgingImageCache(
        memoryCapacity: 100_000_000,
        preferredMemoryUsageAfterPurge: 60_000_000
    )
    
    static func getImage(urlPath: String, completion: @escaping(_ image: Image)-> Void){
        guard let url = try? urlPath.asURL() else {return}
        if (exists(name: urlPath)){
            downLoad(url: url)
        } else{
            return get(url: url, completion: completion)
        }
    }
    
    static func exists(name: String) -> Bool{
        let nameHash = String(name.hashValue)
        guard let _ = ImageService.imageCache.image(withIdentifier: nameHash)
            else {return false}
        return true
    }
    
    static func downLoad(url: URL){
        ImageService.queue.async {
            Alamofire.request(url).responseData(queue: DispatchQueue.global()){ response in
                guard let resultData = response.result.value else {return}
                guard let image = Image(data: resultData) else {return}
                ImageService.imageCache.add(image, withIdentifier: String(url.path.hashValue))
            }
        }
    }
    
    static func get(url: URL, completion: @escaping(_ image: Image)-> Void){
        ImageService.queue.async(flags: .barrier){
            let nameHash = String(url.path.hashValue)
            guard let result = ImageService.imageCache.image(withIdentifier: nameHash)
                else {return}
            DispatchQueue.main.async {
                completion(result)
            }
        }
        
    }
}
