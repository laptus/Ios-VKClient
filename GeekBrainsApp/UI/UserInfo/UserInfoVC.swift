import UIKit

class UserInfoVC: UIViewController {

    @IBOutlet weak var firstNameLabel: UILabel!
    @IBOutlet weak var lastNameLabel: UILabel!
    @IBOutlet weak var avatarImageView: UIImageView!
    @IBOutlet weak var postTableView: UITableView!
    var posts: [NewsInfo] = []
    
    var userId: Int = 0
    var firstName: String = ""
    var lastName: String = ""
    var avatarURL: String = ""
    
    override func viewDidLoad() {
        super.viewDidLoad()
        firstNameLabel.text = firstName
        lastNameLabel.text = lastName
        postTableView.delegate = self
        postTableView.dataSource = self
        
        ImageService.getImage(urlPath: avatarURL){[weak self] result in
            DispatchQueue.main.async {
                guard let imView = self?.avatarImageView else {return}
                imView.image = result
            }
        }
        VKAccessor.Wall.getPosts(userId: String(userId)){[weak self] result in
            DispatchQueue.main.async {
                self?.posts = result
                self?.postTableView.reloadData()
            }
        }
    }
    
    func setRounfAvatar(){
        avatarImageView.layer.borderWidth = 1
        avatarImageView.layer.masksToBounds = false
        avatarImageView.layer.borderColor = UIColor.black.cgColor
        avatarImageView.layer.cornerRadius = avatarImageView.frame.height/2
        avatarImageView.clipsToBounds = true
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "toAlbumsCollection",
            let ctrl = segue.destination as? AlbumsCollectionVC{
            ctrl.ownerId = userId
        }
    }
 
    @IBAction func close(_ sender: Any) {
        dismiss(animated: true){
        }
    }
}

extension UserInfoVC: UITableViewDelegate, UITableViewDataSource{
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return posts.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "UserPostCellVC") as! UserPostCellVC
        let post = posts[indexPath.row]
        completeDataInPostCell(cell, post)
        return cell
    }
    
    fileprivate func completeDataInPostCell(_ cell: UserPostCellVC, _ post: NewsInfo) {
        cell.firstNameLabel.text = self.firstNameLabel.text
        cell.lastNameLabel.text = self.lastNameLabel.text
        cell.userAvatarView.image = self.avatarImageView.image
        cell.postTextLabel.text = post.text
        cell.likesCountLabel.text = String(post.likes)
        cell.commentsCountLabel.text = String(post.views)
        cell.repostCountLabel.text = String(post.reposts)
        cell.photos = []
        let minCount = min(6,post.photoList.count)
        for i in 0..<minCount{
            cell.photos.append(post.photoList[i])
        }
        cell.postPhotosCollection.reloadData()
    }
}
