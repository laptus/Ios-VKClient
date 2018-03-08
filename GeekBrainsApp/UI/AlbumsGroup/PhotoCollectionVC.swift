import UIKit
import RealmSwift

private let reuseIdentifier = "Cell"

class PhotoCollectionVC: UICollectionViewController {
    
    var photoList: [PhotoInfo] = []
    var userId: Int = 0
    var realmToken : NotificationToken?
    var ownerId = 0
    var albumId = 0
    
    @IBOutlet var photoAlbumCollectionView: UICollectionView!
    override func viewDidLoad() {
        super.viewDidLoad()
        loadAlbumPhotos()
        photoAlbumCollectionView.refreshControl = UIRefreshControl()
        photoAlbumCollectionView.refreshControl?.addTarget(self, action: #selector(updateCollection), for: .primaryActionTriggered)
        
    }
    
    @objc func updateCollection(){
        loadAlbumPhotos()
        photoAlbumCollectionView.refreshControl?.endRefreshing()
    }
    
    var environment: Environment {
        return VKAccessor.EnvironmentImp.VKEnvironment()
    }
    
    func loadAlbumPhotos(){
        VKAccessor.Photos.getPhotos(ownerId: ownerId, albumId: albumId){[weak self] result in
            self?.photoList = result
            self?.photoAlbumCollectionView?.reloadData()
        }
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
    }

    override func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }


    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of items
        return photoList.count
    }

    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = photoAlbumCollectionView.dequeueReusableCell(withReuseIdentifier: "PhotoCell", for: indexPath) as! PhotoCell
        let photo = photoList[indexPath.row]
        ImageService.getImage(urlPath: photo.url){[weak cell,weak self] urlPath,image in
            if (self?.photoList.count)! > indexPath.row,
                self?.photoList[indexPath.row].url == urlPath{
                cell?.photoImageView.image = image
            }
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
