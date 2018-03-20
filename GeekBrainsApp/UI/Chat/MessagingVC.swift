//
//  MessagingVC.swift
//  GeekBrainsApp
//
//  Created by Laptev Sasha on 23/02/2018.
//  Copyright © 2018 Laptev Sasha. All rights reserved.
//

import UIKit
import AlamofireImage
import MobileCoreServices

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
        
        if scrollView.contentOffset.y - offset > 100{
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
            
            guard let cell = self?.MessagesTableView.cellForRow(at: ipath) as? SenderCell else {return}
            cell.statusImageView.isHidden = false
            if result{
                cell.statusImageView.image = #imageLiteral(resourceName: "checked")
            }else{
                cell.statusImageView.image = #imageLiteral(resourceName: "cancel")
            }
        }
    }

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
            let messageInfo = messages[indexPath.row]
            cell.messageText.text = messageInfo.text
            cell.statusImageView.isHidden = true
            cell.messageText.backgroundColor = UIColor(named: "red")
            cell.photoPaths = []
            let minCount = min(5,messageInfo.photos.count)
            for i in 0 ..< minCount{
                cell.photoPaths.append(messageInfo.photos[i])
            }
            cell.attachedPhotoCollection.reloadData()
            cell.backgroundColor = UIColor.clear
            return cell
        }else{
            let cell = tableView.dequeueReusableCell(withIdentifier: "DefandantCell", for: indexPath) as! DefandantCell
            let messageInfo = messages[indexPath.row]
            cell.messageText.text = messageInfo.text
            cell.photoPaths = []
            let minCount = min(5,messageInfo.photos.count)
            for i in 0 ..< minCount{
                cell.photoPaths.append(messageInfo.photos[i])
            }
            cell.attachedPhotoCollection.reloadData()
            cell.backgroundColor = UIColor.clear
            return cell
        }
    }
}

extension MessagingVC: UIImagePickerControllerDelegate, UINavigationControllerDelegate{
    @IBAction func openCameraButton(sender: AnyObject) {
        if UIImagePickerController.isSourceTypeAvailable(.camera) {
            let imagePicker = UIImagePickerController()
            imagePicker.delegate = self
            imagePicker.sourceType = .camera;
            imagePicker.allowsEditing = false
            self.present(imagePicker, animated: true, completion: nil)
        }
    }
    
    @IBAction func openPhotoLibraryButton(sender: AnyObject) {
        if UIImagePickerController.isSourceTypeAvailable(.photoLibrary) {
            let imagePicker = UIImagePickerController()
            imagePicker.delegate = self
            imagePicker.sourceType = .photoLibrary;
            imagePicker.allowsEditing = true
            self.present(imagePicker, animated: true, completion: nil)
        }
    }
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : Any]) {
        guard let mediaType = info[UIImagePickerControllerMediaType] as? String else{return}
        var originalImage, editedImage, imageToSave:  UIImage?
        if mediaType ==  kUTTypeImage as String {
            editedImage = info[UIImagePickerControllerEditedImage]  as?  UIImage
            originalImage = info[ UIImagePickerControllerOriginalImage]  as? UIImage
            if editedImage != nil {
                imageToSave = editedImage
            } else {
                imageToSave = originalImage
            }
            if let image = imageToSave {
                postImage(image: image)
            }
        }
        picker.dismiss( animated: true, completion: nil)
    }
    
    func postImage(image: UIImage){
        messages.append(MessageInfo(id: Int(VKAccessor.CurrentUser.instance.id)!,message: "",photosPaths: [""]))
        MessagesTableView.reloadData()
        let ipath = IndexPath(row: messages.count-1, section: MessagesTableView.numberOfSections - 1)
        MessagesTableView.scrollToRow(at: ipath, at: UITableViewScrollPosition.top, animated: true)
        let imageData = UIImagePNGRepresentation(image)!
        let peer = defandantGroupId == nil ? defandantUserId! : 2000000000 + defandantGroupId!
        VKAccessor.Photos.uploadPhotoToMessage(peerId: String(peer),image: imageData){[weak self] wasSuccessful, imageUrl in
            guard let cell = self?.MessagesTableView.cellForRow(at: ipath) as? SenderCell else {return}
            cell.statusImageView.isHidden = false
            if wasSuccessful{
                cell.photoPaths = []
                cell.photoPaths.append(imageUrl)
                cell.attachedPhotoCollection.reloadData()
                cell.statusImageView.image = #imageLiteral(resourceName: "checked")
            }else{
                cell.statusImageView.image = #imageLiteral(resourceName: "cancel")
            }
        }
        sleep(2)
    }
    
    func imagePickerControllerDidCancel(_ picker:  UIImagePickerController) {
        picker.dismiss(animated: true, completion: nil)
    }
}
