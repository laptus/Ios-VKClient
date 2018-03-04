import Foundation
import SwiftyJSON
import Alamofire
import RealmSwift

extension VKAccessor.News{
    struct NewsService{
        func getNewsAndSaveToRealm(){
            let token = VKAccessor.CurrentUser.instance.token
            let env = VKAccessor.EnvironmentImp.VKEnvironment()
            let request =  NewsRequests.getNews(environment: env, token: token)
            Alamofire.request(request).responseData(queue: DispatchQueue.global(), completionHandler: saveToRealm)
        }
        
        private func saveToRealm(response: DataResponse<Data>){
            guard let data = response.value else { return }
            let json = try! JSON(data:data)
            let newsList = json["response"]["items"].array?.flatMap { NewsInfo(json: $0) } ?? []
            do{
                try Realm.replaceObject(newObjects: newsList)
            }
            catch{
                print(error)
            }
        }
        
        func postNews(){

        }
        
    }
}


