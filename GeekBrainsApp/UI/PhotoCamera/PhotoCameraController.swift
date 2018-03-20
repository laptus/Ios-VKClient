//
//  PhotoCameraController.swift
//  GeekBrainsApp
//
//  Created by Laptev Sasha on 09/03/2018.
//  Copyright © 2018 Laptev Sasha. All rights reserved.
//

import UIKit

protocol ImageUser {
    func saveImage()
}

class PhotoCameraController: UIViewController{
    var isCamera: Bool = true
    var imageUser: ImageUser?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        if isCamera{
            loadCameraControl()
        }else{
            
        }
    }

    
    func loadCameraControl(){
        if !UIImagePickerController.isSourceTypeAvailable(.camera){
            return
        }
        let camera = UIImagePickerController()
        camera.sourceType = .camera
        camera.mediaTypes = UIImagePickerController.availableMediaTypes(for: .camera)!
        camera.delegate = self
        present(camera, animated: true,completion: nil)
    }
    
    func loadLibraryControl(){
        if !UIImagePickerController.isSourceTypeAvailable(.photoLibrary){
            return
        }
        let camera = UIImagePickerController()
        camera.sourceType = .photoLibrary
        camera.delegate = self
        present(camera, animated: true,completion: nil)
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
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

extension PhotoCameraController: UINavigationControllerDelegate, UIImagePickerControllerDelegate{
    
}
