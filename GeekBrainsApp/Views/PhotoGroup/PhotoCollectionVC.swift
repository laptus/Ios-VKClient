//
//  PhotoCollectionViewController.swift
//  GeekBrainsApp
//
//  Created by Laptev Sasha on 04/12/2017.
//  Copyright © 2017 Laptev Sasha. All rights reserved.
//

import UIKit
import RealmSwift

private let reuseIdentifier = "Cell"

class PhotoCollectionVC: UICollectionViewController {
    
    var photoList: Results<PhotoInfo>?
    var userId: Int = 0
    var realmToken : NotificationToken?
    
    var labelPhotoText=""
    override func viewDidLoad() {
        super.viewDidLoad()
        loadUserPhotos()
        pairWithRealm()
    }

    func pairWithRealm(){
        let realm = try! Realm()
        photoList = realm.objects(PhotoInfo.self)
        realmToken = photoList!.observe {[weak self] (changes: RealmCollectionChange) in
            guard let collectionView = self?.collectionView else {return}
            collectionView.reloadData()
        }
    }
    
    var environment: Environment {
        return EnvironmentImp.VKEnvironment()
    }
    
    func loadUserPhotos(){
        let tabsVC = navigationController?.tabBarController as! TabsVCProtocol
        let UserServie = UserService(environment: environment, token: tabsVC.token)
        UserServie.downloadPhoto(forUser: userId)
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using [segue destinationViewController].
        // Pass the selected object to the new view controller.
    }
 

    // MARK: UICollectionViewDataSource

    override func numberOfSections(in collectionView: UICollectionView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }


    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of items
        return photoList?.count ?? 0
    }

    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "PhotoViewCell", for: indexPath) as! PhotoCell
        guard let photo = photoList?[indexPath.row] else {
            cell.photoImage.image = #imageLiteral(resourceName: "no_avatar")
            return cell
        }
        if let url = URL(string: photo.url){
            let data = try? Data(contentsOf: url)
            cell.photoImage.image = UIImage(data: data!)}
        else{
            cell.photoImage.image = #imageLiteral(resourceName: "no_avatar")
        }
        return cell
    }

    // MARK: UICollectionViewDelegate

    /*
    // Uncomment this method to specify if the specified item should be highlighted during tracking
    override func collectionView(_ collectionView: UICollectionView, shouldHighlightItemAt indexPath: IndexPath) -> Bool {
        return true
    }
    */

    /*
    // Uncomment this method to specify if the specified item should be selected
    override func collectionView(_ collectionView: UICollectionView, shouldSelectItemAt indexPath: IndexPath) -> Bool {
        return true
    }
    */

    /*
    // Uncomment these methods to specify if an action menu should be displayed for the specified item, and react to actions performed on the item
    override func collectionView(_ collectionView: UICollectionView, shouldShowMenuForItemAt indexPath: IndexPath) -> Bool {
        return false
    }

    override func collectionView(_ collectionView: UICollectionView, canPerformAction action: Selector, forItemAt indexPath: IndexPath, withSender sender: Any?) -> Bool {
        return false
    }

    override func collectionView(_ collectionView: UICollectionView, performAction action: Selector, forItemAt indexPath: IndexPath, withSender sender: Any?) {
    
    }
    */
    
    
}
