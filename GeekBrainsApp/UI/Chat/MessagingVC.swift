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
    @IBOutlet weak var messageTextView: UITextView!
    @IBOutlet weak var scrollView: UIScrollView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        NotificationCenter.default.addObserver(self, selector: #selector(self.keybordWasShown(notification:)), name: NSNotification.Name.UIKeyboardWillShow, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(self.keyboardWillBeHidden(notification:)), name: NSNotification.Name.UIKeyboardWillHide, object: nil)
        messageTextView.becomeFirstResponder()
        titleImage.image = defandantAvatar
        MessagesTableView.dataSource = self
        MessagesTableView.delegate = self
        loadMessages()
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        NotificationCenter.default.removeObserver(self, name: NSNotification.Name.UIKeyboardWillHide,object: nil)
        NotificationCenter.default.removeObserver(self, name: NSNotification.Name.UIKeyboardWillShow, object: nil)
    }
    
    @objc func keybordWasShown(notification: Notification){
        let info = notification.userInfo! as NSDictionary
        let kbSize = (info.value(forKey: UIKeyboardFrameEndUserInfoKey) as! NSValue).cgRectValue.size
        let contentInsets = UIEdgeInsetsMake(0.0, 0.0, kbSize.height, 0.0)
        self.scrollView?.contentInset = contentInsets
        self.scrollView?.scrollIndicatorInsets = contentInsets
    }
    
    @objc func keyboardWillBeHidden(notification: Notification){
        let contentInsets = UIEdgeInsets.zero
        scrollView?.contentInset = contentInsets
        scrollView?.scrollIndicatorInsets = contentInsets
    }
    
    fileprivate func loadMessages(){
        let peer = defandantGroupId == nil ? defandantUserId! : 2000000000 + defandantGroupId!
        VKAccessor.Messages.getHistory(peerdId: String(peer)){[weak self] result in
            self?.messages = result
            self?.messages.reverse()
            self?.MessagesTableView.reloadData()
        }
    }
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        let offset = scrollView.contentSize.height - scrollView.bounds.height
        
        if scrollView.contentOffset.y - offset > 200{
            let peer = defandantGroupId == nil ? defandantUserId! : 2000000000 + defandantGroupId!
            VKAccessor.Messages.getHistory(peerdId: String(peer)){[weak self] result in
                self?.messages = result
                self?.messages.reverse()
                self?.MessagesTableView.reloadData()
            }
        }
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    @IBAction func sendMessage(){
        let peer = defandantGroupId == nil ? defandantUserId! : 2000000000 + defandantGroupId!
        let text = messageTextView.text
        messages.append(MessageInfo(id: Int(VKAccessor.CurrentUser.instance.id)!,message: text!,photosPaths: []))
        MessagesTableView.reloadData()
        let ipath = IndexPath(row: messages.count-1, section: MessagesTableView.numberOfSections - 1)
        MessagesTableView.scrollToRow(at: ipath, at: UITableViewScrollPosition.top, animated: true)
        sleep(1)
        VKAccessor.Messages.postMessage(peerId: String(peer), message: text!){[weak self] result in
            
            let cell = self?.MessagesTableView.cellForRow(at: ipath)
            if result{
                cell?.backgroundColor = UIColor.gray
            }else{
                cell?.backgroundColor = UIColor.red
            }
        }
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
            cell.backgroundColor = UIColor.clear
            return cell
        }else{
            let cell = tableView.dequeueReusableCell(withIdentifier: "DefandantCell", for: indexPath) as! DefandantCell
            cell.messageText.text = messages[indexPath.row].text
            cell.backgroundColor = UIColor.clear
            return cell
        }
        
    }
}
