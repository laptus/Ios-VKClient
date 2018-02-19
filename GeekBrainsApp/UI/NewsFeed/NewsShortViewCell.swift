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
    
    var photos : [String] = []
    
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
        ImageService.getImage(urlPath: photos[indexPath.row]){[weak cell] result in
            DispatchQueue.main.async {
                cell?.image.image = result
            }
        }
        return cell
    }
}

