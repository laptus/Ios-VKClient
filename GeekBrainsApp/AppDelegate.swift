import UIKit
import Firebase
import RealmSwift
import WatchConnectivity

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {
    var bgTask:  UIBackgroundTaskIdentifier!
    var window: UIWindow?
    var watchSession: WCSessionService?


    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplicationLaunchOptionsKey: Any]?) -> Bool {
        FirebaseApp.configure()
        //try? FileManager.default.removeItem(at: Realm.Configuration.defaultConfiguration.fileURL!)
        watchSession = WCSessionService()
        return true
    }
    
    func application(_ application: UIApplication, performFetchWithCompletionHandler completionHandler: @escaping (UIBackgroundFetchResult) -> Void) {
        print("Call bitch")
        let bgService = BGService()
        bgService.updateAppInfo(application, performFetchWithCompletionHandler: completionHandler)
    }
    
    func applicationWillResignActive(_ application: UIApplication) {
    }

    func applicationDidEnterBackground(_ application: UIApplication) {
        
    }

    func applicationWillEnterForeground(_ application: UIApplication) {
    }

    func applicationDidBecomeActive(_ application: UIApplication) {
        do{
            let realm = try Realm()
            let friednsRealm = realm.objects(UserInfo.self)
            var tempData : [String:Any] = [:]
            let maxCount = min(10, friednsRealm.count)
            for i in 0..<maxCount{
                let friend = friednsRealm[i]
                let imageData = try Data(contentsOf: URL(string: friend.photoUrl)!)
                tempData[String(i)] = ["name": friend.name,"id": friend.id, "image": imageData]
            }
            tempData["count"] = maxCount
            let groupDefaults = UserDefaults(suiteName: "group.ALLaptevVK")
            groupDefaults?.set(tempData, forKey: "friends")
        }catch{
            print(error)
        }
    }

    func applicationWillTerminate(_ application: UIApplication) {
    }


}

