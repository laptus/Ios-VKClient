//
//  MessagingVC.swift
//  GeekBrainsApp
//
//  Created by Laptev Sasha on 23/02/2018.
//  Copyright © 2018 Laptev Sasha. All rights reserved.
//

import UIKit
import AlamofireImage

class MessagingVC: UIViewController {
    var messages: [MessageInfo] = []
    var defandantUserId: Int? = nil
    var defandantGroupId: Int? = nil
    var defandantAvatar: UIImage = #imageLiteral(resourceName: "no_avatar")
    var chatTitle = ""
    
    @IBOutlet weak var MessagesTableView: UITableView!
    @IBOutlet weak var titleImage: UIImageView!
    @IBOutlet weak var chatViewLabel: UILabel!
    @IBOutlet weak var messageTextView: UITextView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
//        chatViewLabel.text = chatTitle
        titleImage.image = defandantAvatar
        MessagesTableView.dataSource = self
        MessagesTableView.delegate = self
        loadMessages()
    }
    
    fileprivate func loadMessages(){
        let peer = defandantGroupId == nil ? defandantUserId! : 2000000000 + defandantGroupId!
        VKAccessor.Messages.getHistory(peerdId: String(peer)){[weak self] result in
            self?.messages = result
            self?.messages.reverse()
            DispatchQueue.main.async {
                self?.MessagesTableView.reloadData()
            }
            
        }
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    @IBAction func sendMessage(){
        let text = "req"
        
    }


    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}

extension MessagingVC: UITableViewDelegate, UITableViewDataSource{
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return messages.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if (String(messages[indexPath.row].userId) == VKAccessor.CurrentUser.instance.id){
            let cell = tableView.dequeueReusableCell(withIdentifier: "SenderCell", for: indexPath) as! SenderCell
            cell.messageText.text = messages[indexPath.row].text
            cell.messageText.backgroundColor = UIColor(named: "red")
            return cell
        }else{
            let cell = tableView.dequeueReusableCell(withIdentifier: "DefandantCell", for: indexPath) as! DefandantCell
            cell.messageText.text = messages[indexPath.row].text
            return cell
        }
        
    }
}
