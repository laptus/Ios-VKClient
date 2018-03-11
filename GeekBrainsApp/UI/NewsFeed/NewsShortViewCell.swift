//
//  NewsShortViewCell.swift
//  GeekBrainsApp
//
//  Created by Laptev Sasha on 03/02/2018.
//  Copyright © 2018 Laptev Sasha. All rights reserved.
//

import UIKit
import AlamofireImage

class NewsShortViewCell: UITableViewCell {
    @IBOutlet weak var firstNameLabel: UILabel!
    @IBOutlet weak var lastNameLabel: UILabel!
    @IBOutlet weak var newsTextLabel: UILabel!
    @IBOutlet weak var repostsCountLabel: UILabel!
    @IBOutlet weak var viewsCountLabel: UILabel!
    @IBOutlet weak var likesCountLabel: UILabel!
    @IBOutlet weak var avatarImageView: UIImageView!
    @IBOutlet weak var attachedPhotosCollectionView: UICollectionView!
    
    @IBOutlet weak var photoCollectionHeight: NSLayoutConstraint!
    var photos : [String] = []{
        didSet{
            if photos.contains(where: {$0 != ""}){
                photoCollectionHeight.constant = 130
            }else{
                photoCollectionHeight.constant = 0
            }
        }
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        attachedPhotosCollectionView.dataSource = self
        attachedPhotosCollectionView.delegate = self
    }
}

extension NewsShortViewCell: UICollectionViewDataSource, UICollectionViewDelegate{
    private func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func collectionView(_ collectionView: UICollectionView,
                                 numberOfItemsInSection section: Int) -> Int {
        return photos.count
    }

    func collectionView(_ collectionView: UICollectionView,
                                 cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "AttachedPhotoCell",
                                                      for: indexPath) as! AttachedPhotoCell
        ImageService.getImage(urlPath: photos[indexPath.row]){[weak self,weak cell] urlPath, image in
                if indexPath.row < (self?.photos.count)!,
                    self?.photos[indexPath.row] == urlPath{
                    cell?.image.image = image
                }
        }
        return cell
    }
}

