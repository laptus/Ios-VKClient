import UIKit

class UserInfoVC: UIViewController {

    @IBOutlet weak var firstNameLabel: UILabel!
    @IBOutlet weak var lastNameLabel: UILabel!
    @IBOutlet weak var avatarImageView: UIImageView!
    @IBOutlet weak var postTableView: UITableView!
    
    var userId: Int = 0
    var firstName: String = ""
    var lastName: String = ""
    var avatarURL: String = ""
    
    override func viewDidLoad() {
        super.viewDidLoad()
        firstNameLabel.text = firstName
        lastNameLabel.text = lastName
        ImageService.getImage(urlPath: avatarURL){[weak self] result in
            DispatchQueue.main.async {
                guard let imView = self?.avatarImageView else {return}
                imView.image = result
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
