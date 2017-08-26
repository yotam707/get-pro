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
        let rController = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "ProfessionalMenuTabBarController") as! UITabBarController
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        appDelegate.window?.rootViewController = rController
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
}
