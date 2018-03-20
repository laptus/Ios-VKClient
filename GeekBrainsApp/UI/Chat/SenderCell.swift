//
//  SenderCell.swift
//  GeekBrainsApp
//
//  Created by Laptev Sasha on 23/02/2018.
//  Copyright © 2018 Laptev Sasha. All rights reserved.
//

import UIKit

class SenderCell: UITableViewCell {

    @IBOutlet weak var avatarImage: UIImageView!
    @IBOutlet weak var messageText: UILabel!
    @IBOutlet weak var statusImageView: UIImageView!
    var photoPaths: [String] = []
    @IBOutlet weak var attachedPhotoCollection: UICollectionView!
    override func awakeFromNib() {
        super.awakeFromNib()
        attachedPhotoCollection.dataSource = self
        attachedPhotoCollection.delegate = self
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }

}

extension SenderCell: UICollectionViewDataSource, UICollectionViewDelegate{
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return photoPaths.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "SenderPhotoViewCell", for: indexPath) as! SenderPhotoViewCell
        let photoPath = photoPaths[indexPath.row]
        ImageService.getImage(urlPath: photoPath){[weak cell] originalPath, result in
            if originalPath == photoPath{
                cell?.image.image = result
            }
        }
        return cell
    }
    
    
}
