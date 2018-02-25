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
        print("Call bitch")
        let bgService = BGService()
        bgService.updateAppInfo(application, performFetchWithCompletionHandler: completionHandler)
    }
    
    func applicationWillResignActive(_ application: UIApplication) {
//        do{
//            let realm = try Realm()
//            var friends: [UserInfo] = []
//            let friednsRealm = realm.objects(UserInfo.self)
//            let maxFriendsCountForExtension = 5
//            for i in 0..<maxFriendsCountForExtension{
//                let friend = friednsRealm[i]
//                friends.append(friend)
//            }
//            let groupDefaults = UserDefaults(suiteName: "group.ALLaptevVK")
//            groupDefaults?.set(friends, forKey: "friends")
//        } catch{
//            print(error)
//        }
        // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
        // Use this method to pause ongoing tasks, disable timers, and invalidate graphics rendering callbacks. Games should use this method to pause the game.
    }

    func applicationDidEnterBackground(_ application: UIApplication) {
        
    }

    func applicationWillEnterForeground(_ application: UIApplication) {
        // Called as part of the transition from the background to the active state; here you can undo many of the changes made on entering the background.
    }

    func applicationDidBecomeActive(_ application: UIApplication) {
        do{
//            let realm = try Realm()
//            var friends: [UserInfo] = []
//            let friednsRealm = realm.objects(UserInfo.self)
//            let maxFriendsCountForExtension = 5
//            for i in 0..<maxFriendsCountForExtension{
//                let friend = friednsRealm[i]
//                friends.append(friend)
//            }
//            let groupDefaults = UserDefaults(suiteName: "group.ALLaptevVK")
//            let friendsArray = friends.flatMap{$0.toAnyObject}
//            groupDefaults?.set(friendsArray, forKey: "friends")
        } catch{
            print(error)
        }
    }

    func applicationWillTerminate(_ application: UIApplication) {
        // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
    }


}

