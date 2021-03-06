//
//  MessagesViewController.swift
//  VKMessage
//
//  Created by Laptev Sasha on 01/03/2018.
//  Copyright © 2018 Laptev Sasha. All rights reserved.
//

import UIKit
import Messages
import WebKit
import SafariServices

class MessagesViewController: MSMessagesAppViewController {
    var friendsList: [String: Any] = [:]
    
    @IBOutlet weak var friendsTable: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        friendsTable.delegate = self
        friendsTable.dataSource = self
        loadFriends()
    }
    
    func loadFriends(){
        let groupDefaults = UserDefaults(suiteName: "group.ALLaptevVK")
        friendsList = groupDefaults?.value(forKey: "friends") as! [String: Any]
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    override func willBecomeActive(with conversation: MSConversation) {
        // Called when the extension is about to move from the inactive to active state.
        // This will happen when the extension is about to present UI.
        
        // Use this method to configure the extension and restore previously stored state.
    }
    
    override func didResignActive(with conversation: MSConversation) {
        // Called when the extension is about to move from the active to inactive state.
        // This will happen when the user dissmises the extension, changes to a different
        // conversation or quits Messages.
        
        // Use this method to release shared resources, save user data, invalidate timers,
        // and store enough state information to restore your extension to its current state
        // in case it is terminated later.
    }
   
    override func didReceive(_ message: MSMessage, conversation: MSConversation) {
        // Called when a message arrives that was generated by another instance of this
        // extension on a remote device.
        
        // Use this method to trigger UI updates in response to the message.
    }
    
    override func didStartSending(_ message: MSMessage, conversation: MSConversation) {
        // Called when the user taps the send button.
    }
    
    override func didCancelSending(_ message: MSMessage, conversation: MSConversation) {
        // Called when the user deletes the message without sending it.
    
        // Use this to clean up state related to the deleted message.
    }
    
    override func willTransition(to presentationStyle: MSMessagesAppPresentationStyle) {
        guard presentationStyle == .expanded else { return }
        if let message = activeConversation?.selectedMessage, let url = message.url {
            let safariVC = SFSafariViewController(url: url)
            present(safariVC, animated: true, completion: nil)
        }
    }
    
    override func didTransition(to presentationStyle: MSMessagesAppPresentationStyle) {
        // Called after the extension transitions to a new presentation style.
    
        // Use this method to finalize any behaviors associated with the change in presentation style.
    }

}

extension MessagesViewController: UITableViewDelegate, UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        guard let maxCount = friendsList["count"] as? Int  else {
            return 0
        }
        return maxCount
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "FriendsMessagesCellVC") as! FriendsMessagesCellVC
        if  let friendInfo = friendsList[String(indexPath.row)] as? [String: Any],
            let name = friendInfo["name"] as? String,
            let data = friendInfo["image"] as? Data{
            cell.avatarImage.image = UIImage(data: data)
            cell.nameLabel.text = name
        }
        
        return cell
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let layout = MSMessageTemplateLayout()
        layout.caption = "VK"
        layout.imageTitle = (friendsTable.cellForRow(at: indexPath) as! FriendsMessagesCellVC).nameLabel.text
        layout.image = (friendsTable.cellForRow(at: indexPath) as! FriendsMessagesCellVC).avatarImage.image
        let message = MSMessage()
        if  let friendInfo = friendsList[String(indexPath.row)] as? [String: Any],
            let id = friendInfo["id"] as? Int{
            message.url = URL(string: "http://vk.com/id" + String(id))
        }
        message.layout = layout
        activeConversation?.insert(message, completionHandler:   nil)
    }
}
