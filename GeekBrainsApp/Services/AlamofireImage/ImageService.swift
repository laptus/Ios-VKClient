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
    static let queue = DispatchQueue(label: "AlamofireImage", qos: .background)
    
    static let imageCache = AutoPurgingImageCache(
        memoryCapacity: 100_000_000,
        preferredMemoryUsageAfterPurge: 60_000_000
    )
    
//    static func getImage(urlPath: String, completion: @escaping(_ image: Image)-> Void){
//        ImageService.queue.async{
//            guard let url = try? urlPath.asURL() else {return}
//            if !exists(name: urlPath){
//                downLoad(url: url,completion: completion)
//            }else{
//                get(url: url, completion: completion)
//            }
//        }
//    }
    
    static func getImage(urlPath: String, completion: @escaping(_ urlPath: String,_ image: Image)-> Void){
        if urlPath == ""{
            completion(urlPath, #imageLiteral(resourceName: "no_avatar"))
        }
        ImageService.queue.async{
            guard let url = try? urlPath.asURL() else {return}
            if !exists(name: urlPath){
                downLoad(url: url,completion: completion)
            }else{
                get(url: url, completion: completion)
            }
        }
    }
    
    static private func exists(name: String) -> Bool{
        let nameHash = String(name.hashValue)
        if ImageService.imageCache.image(withIdentifier: nameHash) != nil{
            return true
        }
        return false
    }
    
//    static private func downLoad(url: URL, completion: @escaping(_ image: Image)-> Void){
//        Alamofire.request(url).responseData(queue: DispatchQueue.global(qos: .background)){ response in
//            guard let resultData = response.result.value else {return}
//            guard let image = Image(data: resultData) else {return}
//            ImageService.imageCache.add(image, withIdentifier: String(url.path.hashValue))
//            DispatchQueue.main.async{
//                completion(image)
//            }
//        }
//    }
//
//    static private func get(url: URL, completion: @escaping(_ image: Image)-> Void){
//        let nameHash = String(url.path.hashValue)
//        guard let result = ImageService.imageCache.image(withIdentifier: nameHash)
//            else {return}
//        DispatchQueue.main.async {
//            completion(result)
//        }
//    }
    
    static private func downLoad(url: URL, completion: @escaping(_ urlPath: String,_ image: Image)-> Void){
        Alamofire.request(url).responseData(queue: DispatchQueue.global(qos: .background)){ response in
            guard let resultData = response.result.value else {return}
            guard let image = Image(data: resultData) else {return}
            ImageService.imageCache.add(image, withIdentifier: String(url.path.hashValue))
            DispatchQueue.main.async{
                completion(url.absoluteString,image)
            }
        }
    }
    
    static private func get(url: URL, completion: @escaping(_ urlPath: String,_ image: Image)-> Void){
        let nameHash = String(url.path.hashValue)
        guard let result = ImageService.imageCache.image(withIdentifier: nameHash)
            else {return}
        DispatchQueue.main.async {
            completion(url.absoluteString,result)
        }
    }
}

