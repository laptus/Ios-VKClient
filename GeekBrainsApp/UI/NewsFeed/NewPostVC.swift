//
//  NewPostVC.swift
//  GeekBrainsApp
//
//  Created by Laptev Sasha on 18/02/2018.
//  Copyright © 2018 Laptev Sasha. All rights reserved.
//

import UIKit
import MobileCoreServices

class NewPostVC: UIViewController {
    @IBOutlet weak var scrollView: UIScrollView!
    var coordsString = ""
    
    @IBAction func send(_ sender: Any) {
        let message = newsTextView.text + coordsString
        let id = VKAccessor.CurrentUser.instance.id
        VKAccessor.Wall.postNews(userId: id, message: message, photosIds: [])
        dismiss(animated: true)
    }
    
    @IBAction func close(_ sender: Any) {
        dismiss(animated: true)
    }
    @IBOutlet weak var newsTextView: UITextView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        newsTextView.becomeFirstResponder()
        NotificationCenter.default.addObserver(self, selector: #selector(self.keybordWasShown(notification:)), name: NSNotification.Name.UIKeyboardWillShow, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(self.keyboardWillBeHidden(notification:)), name: NSNotification.Name.UIKeyboardWillHide, object: nil)
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
    
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        NotificationCenter.default.removeObserver(self, name: NSNotification.Name.UIKeyboardWillHide,object: nil)
        NotificationCenter.default.removeObserver(self, name: NSNotification.Name.UIKeyboardWillShow, object: nil)
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "toMap",
            let ctrl = segue.destination as? MapsVC{
            ctrl.coordUserDelegate = self
        }
    }

}

extension NewPostVC: UIImagePickerControllerDelegate, UINavigationControllerDelegate{
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
        let imageData = UIImagePNGRepresentation(image)!
        VKAccessor.News.uploadPhotoToWall(image: imageData){[weak self] wasSuccessful in
            if !wasSuccessful{
                //attention please
            }
        }
    }
    
    func imagePickerControllerDidCancel(_ picker:  UIImagePickerController) {
        picker.dismiss(animated: true, completion: nil)
    }
}

extension NewPostVC: CoordinateUserDelegete{
    func printCoordinates(coordinates: String) {
        coordsString = "\n"+coordinates
    }
}
