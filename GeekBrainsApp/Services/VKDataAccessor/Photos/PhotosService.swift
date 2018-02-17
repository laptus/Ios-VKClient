import Foundation
import Alamofire

extension VKAccessor{
    struct PhototService{
        func getAlbums(ownerId: String){
            let token = VKAccessor.UserInfo.instance.token
            let env = VKAccessor.EnvironmentImp.VKEnvironment()
            let request =  PhotosRequests.getAlbums(environment: env, token: token, ownerId: ownerId)
            Alamofire.request(request).responseData(queue: DispatchQueue.global()){response in
//                completion()
            }
        }
        
        func getPhotos(ownerId: String){
            let token = VKAccessor.UserInfo.instance.token
            let env = VKAccessor.EnvironmentImp.VKEnvironment()
            let request =  PhotosRequests.getPhotos(environment: env, token: token, ownerId: ownerId)
            Alamofire.request(request).responseData(queue: DispatchQueue.global()){response in
                //                completion()
            }
        }
        
        func getPhotos(ownerId: String,albumId: String){
            let token = VKAccessor.UserInfo.instance.token
            let env = VKAccessor.EnvironmentImp.VKEnvironment()
            let request =  PhotosRequests.getPhotos(environment: env, token: token, ownerId: ownerId)
            Alamofire.request(request).responseData(queue: DispatchQueue.global()){response in
                //                completion()
            }
        }
        
    }
}

