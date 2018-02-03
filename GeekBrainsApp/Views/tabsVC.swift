//
//  MainViewTabController.swift
//  GeekBrainsApp
//
//  Created by Laptev Sasha on 29/11/2017.
//  Copyright © 2017 Laptev Sasha. All rights reserved.
//

import UIKit

protocol TabsVCProtocol: class {
    var token: String { get }
}


class TabsVC: UITabBarController,TabsVCProtocol {
    var token: String = ""
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
// 
//    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
//        if (segue.destination is FriendsTableViewController){
//            (segue.destination as! FriendsTableViewController).token = self.token
//        }
//        if (segue.destination is MyGroupsViewController){
//            (segue.destination as! MyGroupsViewController).token = self.token
//        }
//        // Get the new view controller using segue.destinationViewController.
//        // Pass the selected object to the new view controller.
//    }
// 

}
