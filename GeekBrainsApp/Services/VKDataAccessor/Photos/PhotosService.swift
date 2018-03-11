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
                DispatchQueue.main.async{
                    completion(albumsList)
                }
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
                let albumsList = json["response"]["items"].array?.flatMap { PhotoInfo(json: $0) } ?? []
                DispatchQueue.main.async{
                    completion(albumsList)
                }
            }
        }
        
        func uploadPhotoToWall(image: Data, completion: @escaping (_ isSuccessful: Bool)-> Void){
            let token = VKAccessor.CurrentUser.instance.token
            let env = VKAccessor.EnvironmentImp.VKEnvironment()
            let userId = VKAccessor.CurrentUser.instance.id
            let request =  PhotosRequests.getWallUploadServer(environment: env, token: token)
            Alamofire.request(request).responseData(queue: DispatchQueue.global()){uploadResponse in
                guard let uploadResponseData = uploadResponse.value else { return }
                let uploadResponseJson = try! JSON(data: uploadResponseData)
                let uploadUrl = uploadResponseJson["response"]["upload_url"].stringValue
                if uploadUrl == ""{
                    DispatchQueue.main.async {
                        completion(false)
                    }
                }
                let urlRequest = try! URLRequest(url: uploadUrl, method: HTTPMethod.post)
                let name = "photo"
                let fileName = "photo.jpeg"
                let mimeType = "image/jpeg"
                Alamofire.upload(multipartFormData: {(multipartFormData) in
                    multipartFormData.append(image, withName: name, fileName: fileName, mimeType: mimeType)
                }, with: urlRequest, encodingCompletion: { (encodingResult) in
                    switch encodingResult {
                    case .success(let upload, _, _):
                        upload.responseData {loadResponse in
                            guard let loadResponseData = loadResponse.value else { return }
                            let loadResponseJson = try! JSON(data: loadResponseData)
                            if loadResponseJson["hash"].stringValue != "",
                                loadResponseJson["server"].stringValue != "",
                                loadResponseJson["photo"].stringValue != ""{
                                let imageHash = loadResponseJson["hash"].stringValue
                                let imageServer = loadResponseJson["server"].stringValue
                                let imagePhoto = loadResponseJson["photo"].stringValue
                                VKAccessor.PhototService().saveWallPhoto(userId: userId, server: imageServer, photo: imagePhoto, hash: imageHash, completion: completion)
                            }
                        }
                        return
                    case .failure( _):
                        completion(false)
                    }
                })
            }
        }
        
        func saveWallPhoto(userId: String, server: String, photo: String,hash: String, completion: @escaping (_ isSuccessful: Bool)-> Void){
            let token = VKAccessor.CurrentUser.instance.token
            let env = VKAccessor.EnvironmentImp.VKEnvironment()
            let request =  PhotosRequests.saveWallPhoto(environment: env,
                                                        token: token,
                                                        server: server,
                                                        photo: photo,
                                                        hash: hash)
            Alamofire.request(request).responseData(queue: DispatchQueue.global()){saveResponse in
                guard let saveResponseData = saveResponse.value else { return }
                let saveResponseJson = try! JSON(data: saveResponseData)
                let photoId = saveResponseJson["response"][0]["id"].stringValue
                VKAccessor.Wall.postNewsPhoto(userId: userId, photosId: photoId, completion: completion)
            }
        }
        
        func uploadPhotoToMesssage(image: Data,peerId: String, completion: @escaping (_ isSuccessful: Bool)-> Void){
            let token = VKAccessor.CurrentUser.instance.token
            let env = VKAccessor.EnvironmentImp.VKEnvironment()
            let request =  PhotosRequests.getMessagesUploadServer(environment: env, token: token)
            Alamofire.request(request).responseData(queue: DispatchQueue.global()){uploadResponse in
                guard let uploadResponseData = uploadResponse.value else { return }
                let uploadResponseJson = try! JSON(data: uploadResponseData)
                let uploadUrl = uploadResponseJson["response"]["upload_url"].stringValue
                if uploadUrl == ""{
                    DispatchQueue.main.async {
                        completion(false)
                    }
                }
                let urlRequest = try! URLRequest(url: uploadUrl, method: HTTPMethod.post)
                let name = "photo"
                let fileName = "photo.jpeg"
                let mimeType = "image/jpeg"
                
                Alamofire.upload(multipartFormData: {(multipartFormData) in
                    multipartFormData.append(image, withName: name, fileName: fileName, mimeType: mimeType)
                }, with: urlRequest, encodingCompletion: { (encodingResult) in
                    switch encodingResult {
                    case .success(let upload, _, _):
                        upload.responseData {loadResponse in
                            guard let loadResponseData = loadResponse.value else { return }
                            let loadResponseJson = try! JSON(data: loadResponseData)
                            if loadResponseJson["hash"].stringValue != "",
                                loadResponseJson["server"].stringValue != "",
                                loadResponseJson["photo"].stringValue != ""{
                                let imageHash = loadResponseJson["hash"].stringValue
                                let imageServer = loadResponseJson["server"].stringValue
                                let imagePhoto = loadResponseJson["photo"].stringValue
                                VKAccessor.PhototService().saveMessagePhoto(peerId: peerId,
                                                                            ownerId: VKAccessor.CurrentUser.instance.id,
                                                                         server: imageServer,
                                                                         photo: imagePhoto,
                                                                         hash: imageHash,
                                                                         completion: completion)
                            }
                        }
                        return
                    case .failure( _):
                        completion(false)
                    }
                })
            }
        }
        
        func saveMessagePhoto(peerId: String,ownerId: String, server: String, photo: String,hash: String, completion: @escaping (_ isSuccessful: Bool)-> Void){
            let token = VKAccessor.CurrentUser.instance.token
            let env = VKAccessor.EnvironmentImp.VKEnvironment()
            let request =  PhotosRequests.saveMessagePhoto(environment: env,
                                                        token: token,
                                                        server: server,
                                                        photo: photo,
                                                        hash: hash)
            Alamofire.request(request).responseData(queue: DispatchQueue.global()){saveResponse in
                guard let saveResponseData = saveResponse.value else { return }
                let saveResponseJson = try! JSON(data: saveResponseData)
                let photoId = saveResponseJson["response"][0]["id"].stringValue
                VKAccessor.Messages.postImage(peerId: peerId, ownerId: ownerId, imageId: photoId, completion: completion)
            }
        }
    }
}

