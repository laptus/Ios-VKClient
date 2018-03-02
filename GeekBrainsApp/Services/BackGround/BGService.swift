//
//  BGService.swift
//  GeekBrainsApp
//
//  Created by Laptev Sasha on 17/02/2018.
//  Copyright © 2018 Laptev Sasha. All rights reserved.
//

import Foundation
import UIKit

class BGService{
    var lastUpdate: Date?{
        get{
            return UserDefaults.standard.object(forKey: "LastUpdate") as? Date
        }
        set{
            UserDefaults.standard.set(Date(), forKey: "LastUpdate")
        }
    }
    
    func updateAppInfo(_ application: UIApplication, performFetchWithCompletionHandler completionHandler: @escaping (UIBackgroundFetchResult) -> Void){
        print("Call")
        if lastUpdate != nil, abs(lastUpdate!.timeIntervalSinceNow ) < 30{
            completionHandler(.noData)
        }
        let request = VKAccessor.Messages.MessagesService.getUnreadDialogsCount { result in
            DispatchQueue.main.async {
                UIApplication.shared.applicationIconBadgeNumber = result
                self.lastUpdate = Date()
                completionHandler(.newData)
            }
            
        }
        
        let timer  =  DispatchSource.makeTimerSource(queue: DispatchQueue.main)
        timer.schedule(deadline: .now() + 29, leeway:  .seconds(1) )
        timer.setEventHandler {
            print ( " Говорим системе, что не смогли загрузить данные")
            request.suspend()
            completionHandler(.failed)
            return }
        timer.resume()
        
    }
}
