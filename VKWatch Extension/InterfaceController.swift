//
//  InterfaceController.swift
//  VKWatch Extension
//
//  Created by Laptev Sasha on 28/02/2018.
//  Copyright © 2018 Laptev Sasha. All rights reserved.
//

import WatchKit
import Foundation
import WatchConnectivity


class InterfaceController: WKInterfaceController, WCSessionDelegate {
    var session: WCSession?
    var friendsCount: Int = 0
    var friendsList: [String:Any] = [:]
    @IBOutlet weak var friednsTable: WKInterfaceTable!
    
    override func awake(withContext context: Any?) {
        super.awake(withContext: context)
        // Configure interface objects here.
    }
    
    override func willActivate() {
        super.willActivate()
        if WCSession.isSupported(){
            session = WCSession.default
            session?.delegate = self
            session?.activate()
        }
    }
    
    func updateTable(){
        guard let maxCount = friendsList["count"] as? Int  else {
            return
        }
        friednsTable.setNumberOfRows(maxCount, withRowType: "FriendRowController")
        for i in 0..<maxCount{
            let row = friednsTable.rowController(at: i) as! FriendRowController
            if  let friendInfo = friendsList[String(i)] as? [String: Any],
                let name = friendInfo["name"] as? String,
                let data = friendInfo["image"] as? Data{
                    row.avatarImage.setImage(UIImage(data: data))
                row.nameLabel.setText(name)
            }
        }
//        self.updateTable()
    }
    
    override func didDeactivate() {
        // This method is called when watch view controller is no longer visible
        super.didDeactivate()
    }
    
    func session(_ session: WCSession, activationDidCompleteWith activationState: WCSessionActivationState, error: Error?) {
        if activationState == .activated{
            session.sendMessage(["request": "getFriendsList"], replyHandler: {reply in
                self.friendsList = reply
                //var friendsAnyArray = reply["friends"] as [Any]
//                for friendAny in friendsAnyArray{
//                    friendsList.append(UserInfo(friendAny))
//                }
//                self.update()
                self.updateTable()
            }, errorHandler: { error in
                
            })
        }
    }
}
