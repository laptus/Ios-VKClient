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
        //self.albumsCollectionView!.register(UICollectionViewCell.self, forCellWithReuseIdentifier: "AlbumCellVC")

        // Do any additional setup after loading the view.
    }
    
    var environment: Environment {
        return VKAccessor.EnvironmentImp.VKEnvironment()
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
    
    // MARK: UICollectionViewDataSource

    override func numberOfSections(in collectionView: UICollectionView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }


    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of items
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
        // Configure the cell
    
        return cell
    }

    // Uncomment this method to specify if the specified item should be selected
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
