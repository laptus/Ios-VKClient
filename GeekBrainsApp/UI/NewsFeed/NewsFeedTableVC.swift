//
//  NewsFeedTableVC.swift
//  GeekBrainsApp
//
//  Created by Laptev Sasha on 17/02/2018.
//  Copyright © 2018 Laptev Sasha. All rights reserved.
//

import UIKit
import RealmSwift

class NewsFeedTableVC: UITableViewController {
    var news: Results<NewsInfo>?
    var realmToken: NotificationToken?
    @IBOutlet var newsFeedTableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        loadNews()
        pairWithRealm()
        tableView.refreshControl = UIRefreshControl()
        tableView.refreshControl?.addTarget(self, action: #selector(refreshTable), for: .primaryActionTriggered)
    }
    
    @objc func refreshTable(){
        loadNews()
        tableView.refreshControl?.endRefreshing()
    }
    
    func loadNews(){
        VKAccessor.News.saveNewsToRealm()
    }
    
    func pairWithRealm(){
        let realm = try! Realm()
        news = realm.objects(NewsInfo.self)
        realmToken = news!.observe {[weak self] (changes: RealmCollectionChange) in
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
    }
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return news?.count ?? 0
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "NewsShortViewCell", for: indexPath) as! NewsShortViewCell
        guard let post = news?[indexPath.row] else {return cell}
        VKAccessor.Info.getInfo(id: post.sourceId){[weak cell] gName,sName,pPath in
            DispatchQueue.main.async {
                cell?.firstNameLabel.text = gName
                cell?.lastNameLabel.text = sName
                ImageService.getImage(urlPath: pPath){[weak cell] result in
                    DispatchQueue.main.async {cell?.avatarImageView.image = result}
                }
            }
        }
        cell.newsTextLabel.text = post.text
        cell.likesCountLabel.text = String(post.likes)
        cell.repostsCountLabel.text = String(post.reposts)
        cell.viewsCountLabel.text = String(post.views)
        cell.photos = []
        let maxPhotosCount = min(6,post.photoList.count)
        for i in 0..<maxPhotosCount{
            cell.photos.append(post.photoList[i])
        }
        cell.attachedPhotosCollectionView.reloadData()
        return cell
    }
}

