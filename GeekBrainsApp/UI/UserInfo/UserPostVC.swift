//
//  UserPostVC.swift
//  GeekBrainsApp
//
//  Created by Laptev Sasha on 23/02/2018.
//  Copyright © 2018 Laptev Sasha. All rights reserved.
//

import UIKit

class UserPostCellVC: UITableViewCell {
    
    @IBOutlet weak var userAvatarView: UIImageView!
    @IBOutlet weak var firstNameLabel: UILabel!
    @IBOutlet weak var lastNameLabel: UILabel!
    @IBOutlet weak var repostCountLabel: UILabel!
    @IBOutlet weak var commentsCountLabel: UILabel!
    @IBOutlet weak var likesCountLabel: UILabel!
    @IBOutlet weak var postTextLabel: UILabel!
    @IBOutlet weak var postPhotosCollection: UICollectionView!
    var photos: [String] = []
    
    override func awakeFromNib() {
        super.awakeFromNib()
        postPhotosCollection.dataSource = self
        postPhotosCollection.delegate = self
    }
}

extension UserPostCellVC: UICollectionViewDataSource, UICollectionViewDelegate{
    private func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func collectionView(_ collectionView: UICollectionView,
                        numberOfItemsInSection section: Int) -> Int {
        return photos.count
    }
    
    func collectionView(_ collectionView: UICollectionView,
                        cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "PostAttachedPhotoCell",
                                                      for: indexPath) as! PostAttachedPhotoCell
        ImageService.getImage(urlPath: photos[indexPath.row]){[weak cell] result in
            DispatchQueue.main.async {
                cell?.image.image = result
            }
        }
        return cell
    }
}
