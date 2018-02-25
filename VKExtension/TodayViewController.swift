//
//  TodayViewController.swift
//  VKExtension
//
//  Created by Laptev Sasha on 25/02/2018.
//  Copyright © 2018 Laptev Sasha. All rights reserved.
//

import UIKit
import NotificationCenter
import RealmSwift

class TodayViewController: UIViewController, NCWidgetProviding {
    var friends: [UserInfo] = []
    
    @IBOutlet weak var friendsTablewView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        friends = []
        let groupDefaults = UserDefaults(suiteName: "group.ALLaptevVK")
        guard let friendsObjects = groupDefaults?.array(forKey: "friends") else{return}

        let maxCount = min(5,friendsObjects.count)
        for i in 0..<maxCount{
            let fr = UserInfo(value: friendsObjects[i])
            friends.append(fr)
        }
        friendsTablewView.reloadData()
        friendsTablewView.delegate = self
        friendsTablewView.dataSource = self
        // Do any additional setup after loading the view from its nib.
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func widgetPerformUpdate(completionHandler: (@escaping (NCUpdateResult) -> Void)) {
        // Perform any setup necessary in order to update the view.
        
        // If an error is encountered, use NCUpdateResult.Failed
        // If there's no update required, use NCUpdateResult.NoData
        // If there's an update, use NCUpdateResult.NewData
        
        completionHandler(NCUpdateResult.newData)
    }
    
}

extension TodayViewController: UITableViewDataSource, UITableViewDelegate{
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return friends.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "UserInfoViewCell")  as! UserInfoViewCell
        let info = friends[indexPath.row]
        let data = try? Data(contentsOf: URL(string: info.photoUrl)!)
        cell.avatarImage.image = UIImage(data: data!)
        cell.nameLabel.text = info.name
        return cell
    }
    

}
