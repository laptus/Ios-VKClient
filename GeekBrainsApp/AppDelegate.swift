//
//  AppDelegate.swift
//  GeekBrainsApp
//
//  Created by Laptev Sasha on 26/11/2017.
//  Copyright © 2017 Laptev Sasha. All rights reserved.
//

import UIKit
import Firebase
import RealmSwift

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {
    var bgTask:  UIBackgroundTaskIdentifier!
    var window: UIWindow?


    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplicationLaunchOptionsKey: Any]?) -> Bool {
        FirebaseApp.configure()
        //try? FileManager.default.removeItem(at: Realm.Configuration.defaultConfiguration.fileURL!)

        return true
    }
    
    func application(_ application: UIApplication, performFetchWithCompletionHandler completionHandler: @escaping (UIBackgroundFetchResult) -> Void) {
        let bgService = BGService()
        bgService.updateAppInfo(application, performFetchWithCompletionHandler: completionHandler)
    }
    
    func application(_ app: UIApplication, open url: URL,
                     options: [UIApplicationOpenURLOptionsKey : Any] = [:]) -> Bool{
        let sb = UIStoryboard(name: "Main", bundle: nil)
        let viewController = sb.instantiateViewController(withIdentifier: "UserPage")
        app.keyWindow?.rootViewController?.show(viewController, sender: nil)
        return true
    }
    
    func applicationWillResignActive(_ application: UIApplication) {

    }

    func applicationDidEnterBackground(_ application: UIApplication) {
        
    }

    func applicationWillEnterForeground(_ application: UIApplication) {
        // Called as part of the transition from the background to the active state; here you can undo many of the changes made on entering the background.
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
        // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
    }


}

