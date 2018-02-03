//
//  MyGroupsViewController.swift
//  GeekBrainsApp
//
//  Created by Laptev Sasha on 04/12/2017.
//  Copyright © 2017 Laptev Sasha. All rights reserved.
//

import UIKit
import RealmSwift

class GroupsListVC: UITableViewController {

    var groupsList : Results<GroupInfo>?
    var realmToken: NotificationToken?
    
    var environment: Environment {
        return EnvironmentImp.VKEnvironment()
    }
    
    @IBOutlet var joinedGroupsTableView: UITableView!
    override func viewDidLoad() {
        super.viewDidLoad()
        loadUserGroups()
        pairWithRealm()
    }

    func loadUserGroups(){
        let tabsVC = navigationController?.tabBarController as! TabsVCProtocol
        let groupService = GroupService(environment: environment, token: tabsVC.token)
        groupService.getGroupById()
    }
    
    func pairWithRealm(){
        let realm = try! Realm()
        groupsList = realm.objects(GroupInfo.self)
        realmToken = groupsList!.observe {[weak self] (changes: RealmCollectionChange) in
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
        // #warning Incomplete implementation, return the number of sections
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return groupsList?.count ?? 0
    }

    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "JoinedGroupViewCell", for: indexPath) as! GroupCell
        guard let groupInfo = groupsList?[indexPath.row] else{
            cell.name.text = ""
            cell.avatar.image = #imageLiteral(resourceName: "no_avatar")
            return cell
        }
        cell.name.text = groupInfo.name
        if let url = URL(string: groupInfo.photoUrl){
            let data = try? Data(contentsOf: url)
            cell.avatar.image = UIImage(data: data!)}
        else{
            cell.avatar.image = #imageLiteral(resourceName: "no_avatar")
        }
        return cell
    }
 
    @IBAction func  addGroup(  segue:   UIStoryboardSegue)  {
        if  segue.identifier  == "addGroup" {
            let  allGroupsController  =  segue.source  as!   SearchGroupsVC
            if let indexPath  =  allGroupsController.availableGroupsTable.indexPathForSelectedRow {
                let  groupName  =  allGroupsController.groupsList[indexPath.row]
                //let results = groupsList.filter { $0.id == groupName.id }
                do{
                    try Realm.updateObject(newObjects: [groupName])
//                    joinedGroupsTableView.reloadData()
                }
                catch{
                    print(error)
                }
//                let notExists = results.isEmpty == true
//                if notExists{
//                    groupsList.append(groupName)
//
//                }
            }
        }
    }

    // Override to support conditional editing of the table view.
    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the specified item to be editable.
        return true
    }

    
    // Override to support editing the table view.
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            do{
                let realm = try Realm()
                realm.beginWrite()
                realm.delete(groupsList![indexPath.row])
                try realm.commitWrite()
            }catch{
                print(error)
            }
            
            // Delete the row from the data source
            //groupsList.remove(at:  indexPath.row)
            joinedGroupsTableView.deleteRows(at: [indexPath], with: .fade)
        }
    }
    

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

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
