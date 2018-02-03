//
//  FriendsTableViewController.swift
//  GeekBrainsApp
//
//  Created by Laptev Sasha on 03/12/2017.
//  Copyright © 2017 Laptev Sasha. All rights reserved.
//

import UIKit
import Alamofire
import SwiftyJSON
import RealmSwift

class FriendsTablveVC: UITableViewController {
    var friendsList: Results<UserInfo>?
    var realmToken: NotificationToken?
    @IBOutlet var friendsTableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        loadFriendsList()
        pairWithRealm()
    }
        
    var environment: Environment {
        return EnvironmentImp.VKEnvironment()
    }
    
    func loadFriendsList(){
        let tabsVC = navigationController?.tabBarController as! TabsVCProtocol
        let userService = UserService(environment: environment, token: tabsVC.token)
        userService.downloadFriendsList()
    }
    
    func pairWithRealm(){
        let realm = try! Realm()
        friendsList = realm.objects(UserInfo.self)
        realmToken = friendsList!.observe {[weak self] (changes: RealmCollectionChange) in
//            self?.tableView.reloadData()
            guard let tableView = self?.tableView else {return}
            switch changes{
            case .initial:
                tableView.reloadData()
            case .update(_, let deletions, let insertions, let modifications):
                tableView.beginUpdates()
                tableView.insertRows(at: insertions.map({ IndexPath(row: $0, section: 0) }),
                                     with: .automatic)
                tableView.deleteRows(at: deletions.map({ IndexPath(row: $0, section: 0)}),
                                     with: .automatic)
                tableView.reloadRows(at: modifications.map({ IndexPath(row: $0, section: 0) }),
                                     with: .automatic)
                tableView.endUpdates()
            case .error(let error):
                fatalError("\(error)")
            }
        }
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return friendsList?.count ?? 0
    }

    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "friendCellView", for: indexPath) as! UserCell
        if let friendInfo = friendsList?[indexPath.row]{
        cell.nameLabel.text = friendInfo.name
        if let url = URL(string: friendInfo.photoUrl){
        let data = try? Data(contentsOf: url) 
            cell.avatarImageView.image = UIImage(data: data!)}
        else{
            cell.avatarImageView.image = #imageLiteral(resourceName: "no_avatar")
            }
        }else{
            cell.nameLabel.text = ""
            cell.avatarImageView.image = #imageLiteral(resourceName: "no_avatar")
        }
        return cell
    }

    /*
    // Override to support conditional editing of the table view.
    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the specified item to be editable.
        return true
    }
    */

    /*
    // Override to support editing the table view.
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            // Delete the row from the data source
            tableView.deleteRows(at: [indexPath], with: .fade)
        } else if editingStyle == .insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
        }    
    }
    */

    /*
    // Override to support rearranging the table view.
    override func tableView(_ tableView: UITableView, moveRowAt fromIndexPath: IndexPath, to: IndexPath) {

    }
    */

    /*
    // Override to support conditional rearranging of the table view.
    override func tableView(_ tableView: UITableView, canMoveRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the item to be re-orderable.
        return true
    }
    */

    
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "toPhotos",
            let ctrl = segue.destination as? PhotoCollectionVC,
            let indexpath = tableView.indexPathForSelectedRow{
            let id = friendsList?[indexpath.row].id
            ctrl.userId = id!
        }
    }
}
