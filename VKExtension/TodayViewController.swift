//
//  TodayViewController.swift
//  VKExtension
//
//  Created by Laptev Sasha on 25/02/2018.
//  Copyright © 2018 Laptev Sasha. All rights reserved.
//

import UIKit
import NotificationCenter

class TodayViewController: UIViewController, NCWidgetProviding {
    var friendsList: [String: Any] = [:]
    var friendsCount: Int = 0
    
    @IBOutlet weak var friendsTablewView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        friendsList = [:]
        let groupDefaults = UserDefaults(suiteName: "group.ALLaptevVK")
        friendsList = groupDefaults?.value(forKey: "friends") as! [String: Any]
        guard let frCount = friendsList["count"] as? Int  else {
            self.friendsCount = 0
            return
        }
        self.friendsCount = min(5,frCount)
        friendsTablewView.delegate = self
        friendsTablewView.dataSource = self
        friendsTablewView.reloadData()
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
        return friendsCount
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "UserInfoViewCell")  as! UserInfoViewCell
        if  let friendInfo = friendsList[String(indexPath.row)] as? [String: Any],
            let name = friendInfo["name"] as? String,
            let data = friendInfo["image"] as? Data{
            cell.avatarImage.image = UIImage(data: data)
            cell.nameLabel.text = name
        }
        return cell
    }
    
    func tableView(_ tableView: UITableView, didHighlightRowAt indexPath: IndexPath) {
        if  let friendInfo = friendsList[String(indexPath.row)] as? [String: Any],
            let id = friendInfo["id"] as? String{
            let url = URL(string: "vkUrl://friend." + id)
            self.extensionContext?.open(url!, completionHandler: nil)
        }
    }
    
    func tableView(_ tableView: UITableView, didDeselectRowAt indexPath: IndexPath) {
        if  let friendInfo = friendsList[String(indexPath.row)] as? [String: Any],
            let id = friendInfo["id"] as? String{
            let url = URL(string: "vkUrl://friend." + id)
            self.extensionContext?.open(url!, completionHandler: nil)
        }
    }
}
