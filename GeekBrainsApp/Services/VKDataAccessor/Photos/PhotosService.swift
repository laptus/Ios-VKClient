import Foundation
import SwiftyJSON
import Alamofire

extension VKAccessor{
    struct PhototService{
        func getAlbums(ownerId: Int, completion: @escaping ([AlbumInfo])-> Void){
            let token = VKAccessor.CurrentUser.instance.token
            let env = VKAccessor.EnvironmentImp.VKEnvironment()
            //let minusOwnerId = -ownerId
            let ownerIdString = String(ownerId)
            let request =  PhotosRequests.getAlbums(environment: env, token: token,
                                                    ownerId: ownerIdString)
            Alamofire.request(request).responseData(queue: DispatchQueue.global()){response in
                guard let data = response.value else { return }
                let json = try! JSON(data:data)
                let albumsList = json["response"]["items"].array?.flatMap { AlbumInfo(json: $0) } ?? []
                print(json)
                completion(albumsList)
            }
        }
        
        func getPhotos(ownerId: Int){
            let token = VKAccessor.CurrentUser.instance.token
            let env = VKAccessor.EnvironmentImp.VKEnvironment()
            let request =  PhotosRequests.getPhotos(environment: env, token: token, ownerId: String(ownerId))
            Alamofire.request(request).responseData(queue: DispatchQueue.global()){response in
                //                completion()
            }
        }
        
        func getPhotos(ownerId: Int,albumId: Int,completion: @escaping ([PhotoInfo])-> Void){
            let token = VKAccessor.CurrentUser.instance.token
            let env = VKAccessor.EnvironmentImp.VKEnvironment()
            let request =  PhotosRequests.getPhotos(environment: env, token: token, ownerId: String(ownerId),albumId: String(albumId))
            Alamofire.request(request).responseData(queue: DispatchQueue.global()){response in
                guard let data = response.value else { return }
                let json = try! JSON(data:data)
                print(json)
                let albumsList = json["response"]["items"].array?.flatMap { PhotoInfo(json: $0) } ?? []
                completion(albumsList)
            }
        }
        
    }
}

