//
//  ProfessionalMenuTabBarController.swift
//  Get-Pro
//
//  Created by Eliran Levy on 24/08/2017.
//  Copyright © 2017 Yotam Bloom. All rights reserved.
//

import UIKit

class ProfessionalMenuTabBarController : UITabBarController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Access the UITabBarController from a UIViewController and get all the elements (NSArray of UITabBarItem) (tabs) of the tab Bar
        let tabItems = self.tabBarController?.tabBar.items as NSArray!
        let tabItem = tabItems?[0] as! UITabBarItem
        if OrdersManager.proPendingOrders.count > 0 {
            tabItem.badgeValue = OrdersManager.proPendingOrders.count.description
        }
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
}
