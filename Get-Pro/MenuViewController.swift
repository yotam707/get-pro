//
//  MenuViewController.swift
//  Get-Pro
//
//  Created by Eliran Levy on 06/07/2017.
//  Copyright © 2017 Yotam Bloom. All rights reserved.
//

import UIKit

class MenuViewController: BaseUIViewController {
    @IBOutlet var orderProffesionalBtn: UIButton!
    @IBOutlet var manageOrdersBtn: UIButton!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.setViewColor(view: self.view, color: K.Colors.darkGray)
        self.setViewColor(view: orderProffesionalBtn, color: K.Colors.darkRed)
        self.disableEnableManageOrdersBtn()
        
    }
    
    func disableEnableManageOrdersBtn(){
        let isEnabled = AppManager.getMyOrders().count > 0
        manageOrdersBtn.isEnabled = isEnabled
        if isEnabled {
            self.setViewColor(view: manageOrdersBtn, color: K.Colors.darkRed)
        }
        else {
            self.setViewColor(view: manageOrdersBtn, color: K.Colors.disabledGray)
        }
    }

}
