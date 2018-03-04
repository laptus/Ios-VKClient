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
        return VKAccessor.EnvironmentImp.VKEnvironment()
    }
    
    func loadFriendsList(){
        //        let tabsVC = navigationController?.tabBarController as! TabsVCProtocol
        VKAccessor.Friends.getAndSaveToRealm()
        //        let userService = UserService(environment: environment, token: tabsVC.token)
        //        userService.downloadFriendsList()
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
        let cell = tableView.dequeueReusableCell(withIdentifier: "UserCell", for: indexPath) as! UserCell
        guard let friendInfo = friendsList?[indexPath.row] else {return cell}
            cell.nameLabel.text = friendInfo.name
        ImageService.getImage(urlPath: friendInfo.photoUrl){[weak cell] result in
            DispatchQueue.main.async {
                cell?.avatarImageView.image = result
            }
        }
        return cell
    }
    
    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "toPhotos",
            let ctrl = segue.destination as? PhotoCollectionVC,
            let indexpath = tableView.indexPathForSelectedRow{
            let id = friendsList?[indexpath.row].id
            ctrl.userId = id!
        }
        if segue.identifier == "toUserInfo"{
            if let ctrl = segue.destination as? UserInfoVC,
                let indexpath = tableView.indexPathForSelectedRow,
                let friend = friendsList?[indexpath.row]{
                ctrl.userId = friend.id
                let fullNameArray = friend.name.components(separatedBy: [" "])
                ctrl.firstName = fullNameArray[0]
                ctrl.lastName = fullNameArray.count > 1 ? fullNameArray[1] : ""
                ctrl.avatarURL = friend.photoUrl
            }
        }
    }
}

