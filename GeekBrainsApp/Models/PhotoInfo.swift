//
//  PhotoInfo.swift
//  GeekBrainsApp
//
//  Created by Laptev Sasha on 14/12/2017.
//  Copyright © 2017 Laptev Sasha. All rights reserved.
//

import Foundation
import SwiftyJSON
import RealmSwift

class PhotoInfo: Object {
    @objc dynamic var user : UserInfo?
    @objc dynamic var url = ""
    
    convenience init(json: JSON) {
        self.init()
        url = json["photo_130"].stringValue
    }
    
//    private let cacheLifeTime = 3600
//    
//    private static let pathName: String = {
//        let pathName = "images"
//        
//        guard let cacheDirectory = FileManager.default.urls(for: .cachesDirectory, in: .userDomainMask).first else {return "images"}
//        let path = cacheDirectory.appendingPathComponent(pathName, isDirectory: true)
//        if !FileManager.default.fileExists(atPath: path.path){
//            try? FileManager.default.createDirectory(at: path, withIntermediateDirectories: true, attributes: nil)
//        }
//        return pathName
//    }()
//    
//    private lazy var filePath: String? = {
//        guard let cacheDirectory = FileManager.default.urls(for: .cachesDirectory, in: .userDomainMask).first else {return nil}
//        let hashName = String(url.hashValue)
//        return cacheDirectory.appendingPathComponent(PhotoInfo.pathName+"/" + hashName).path
//    }()
//    
//    func getPhoto()-> UIImage{
//        if !isCached(){
//            download()
//        }
//        return getFromCache()
//    }
//    
//    func isCached()->Bool{
//        guard let cacheFilePath = filePath else {return false}
//        return FileManager.default.fileExists(atPath: cacheFilePath)
//    }
//    
//    func getFromCache()->UIImage{
//        var result = #imageLiteral(resourceName: "no_avatar")
//        if let cacheFilePath = filePath,
//            let tempResult = UIImage(contentsOfFile: cacheFilePath){
//            result = tempResult
//            startTimer()
//        }
//        return result
//    }
//    
//    func download(){
//        startTimer()
//        guard let cacheFilePath = filePath,
//            let imageUrl = URL(string: url),
//            let  data =  try? Data.init(contentsOf: imageUrl)
//            else {return}
//        FileManager.default.createFile(atPath: cacheFilePath, contents: data, attributes: nil)
//    }
//    
//    func startTimer(){
//    }
}
