import UIKit
import RealmSwift

private let reuseIdentifier = "Cell"

class AlbumsCollectionVC: UICollectionViewController {
    var albumsList: [AlbumInfo] = []
    var realmToken : NotificationToken?
    var ownerId = 0
    @IBOutlet var albumsCollectionView: UICollectionView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        loadUserAlbums()
        albumsCollectionView.refreshControl = UIRefreshControl()
        albumsCollectionView.refreshControl?.addTarget(self, action: #selector(updateCollection), for: .primaryActionTriggered)
    }
    
    @objc func updateCollection(){
        loadUserAlbums()
        albumsCollectionView.refreshControl?.endRefreshing()
    }
    
    func loadUserAlbums(){
        VKAccessor.Photos.getAlbums(ownerId: ownerId){[weak self] result in
            DispatchQueue.main.async {
                if let ctrl = self{
                    ctrl.albumsList = result
                    ctrl.albumsCollectionView.reloadData()
                }
            }
        }
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    override func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }


    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return albumsList.count
    }

    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = albumsCollectionView.dequeueReusableCell(withReuseIdentifier: "AlbumCellVC", for: indexPath) as! AlbumCellVC
        cell.nameLabel.text = albumsList[indexPath.row].title
        ImageService.getImage(urlPath: albumsList[indexPath.row].thumb_src){[weak cell] result in
            DispatchQueue.main.async {
                cell?.coverImageView.image = result
            }
            
        }
        return cell
    }

    override func collectionView(_ collectionView: UICollectionView, shouldSelectItemAt indexPath: IndexPath) -> Bool {
        return true
    }
 
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "toAlbum",
            let ctrl = segue.destination as? PhotoCollectionVC,
            let cell = sender as? UICollectionViewCell,
            let indexPath = albumsCollectionView.indexPath(for: cell){
            let album = albumsList[indexPath.row]
            ctrl.ownerId = ownerId
            ctrl.albumId = album.id
        }
    }
}
