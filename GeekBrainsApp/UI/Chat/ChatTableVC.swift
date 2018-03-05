//
//  ChatTableVC.swift
//  GeekBrainsApp
//
//  Created by Laptev Sasha on 18/02/2018.
//  Copyright © 2018 Laptev Sasha. All rights reserved.
//

import UIKit

class ChatTableVC: UITableViewController {
    var chats: [ChatInfo] = []
    @IBOutlet var chatsListTV: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        getDialogs()
        tableView.refreshControl = UIRefreshControl()
        tableView.refreshControl?.addTarget(self, action: #selector(refreshTable), for: .primaryActionTriggered)
    }

    @objc func refreshTable(){
        VKAccessor.Messages.getDialogs(){[weak self] result in
            self?.chats = result
            self?.chatsListTV.reloadData()
            self?.tableView.refreshControl?.endRefreshing()
        }
    }
    
    func getDialogs(){
        VKAccessor.Messages.getDialogs(){[weak self] result in
                self?.chats = result
                self?.chatsListTV.reloadData()
        }
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return chats.count
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "ChatViewCell", for: indexPath) as! ChatViewCell
        let chatInfo = chats[indexPath.row]
        cell.lastMessageLabel.text = chatInfo.lastMessage
        if let userId = chatInfo.userId{
            VKAccessor.Info.getInfo(id: userId){[weak cell] id,fName,lName,avatarPath in
                cell?.userNameLabel.text = fName+" "+lName
                ImageService.getImage(urlPath: avatarPath){[weak cell] urlPath,image in
                    if avatarPath == urlPath{
                        cell?.userAvatarView.image = image
                    }
                }
            }
        }else{
            guard let chatId = chatInfo.groupChatId else {return cell}
            VKAccessor.Messages.getChatInfo(chatId: String(chatId)){[weak cell] title, photo in
                cell?.userNameLabel.text = title
                ImageService.getImage(urlPath: photo){[weak cell] urlPath,image in
                    if photo == urlPath {
                        cell?.userAvatarView.image = image
                    }
                }
            }
        }
        return cell
    }

    /*
    // Override to support conditional editing of the table view.
    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the specified item to be editable.
        return true
    }
    */

    /*
    // Override to support editing the table view.
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            // Delete the row from the data source
            tableView.deleteRows(at: [indexPath], with: .fade)
        } else if editingStyle == .insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
        }    
    }
    */

    /*
    // Override to support rearranging the table view.
    override func tableView(_ tableView: UITableView, moveRowAt fromIndexPath: IndexPath, to: IndexPath) {

    }
    */

    /*
    // Override to support conditional rearranging of the table view.
    override func tableView(_ tableView: UITableView, canMoveRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the item to be re-orderable.
        return true
    }
    */


    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "toMessaging",
            let ctrl = segue.destination as? MessagingVC,
            let indexpath = chatsListTV.indexPathForSelectedRow,
            let cell = chatsListTV.cellForRow(at: indexpath) as? ChatViewCell
        {
            let chatInfo = chats[indexpath.row]
            ctrl.chatTitle = cell.userNameLabel.text!
            ctrl.defandantAvatar = cell.userAvatarView.image == nil ? #imageLiteral(resourceName: "no_avatar") : cell.userAvatarView.image!
            ctrl.defandantGroupId = chatInfo.groupChatId
            ctrl.defandantUserId = chatInfo.userId
        }
    }


}
