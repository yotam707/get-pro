//
//  BaseUIViewController.swift
//  Get-Pro
//
//  Created by Eliran Levy on 09/07/2017.
//  Copyright © 2017 Yotam Bloom. All rights reserved.
//

import UIKit

class BaseUIViewController: UIViewController {

    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    func setViewColor(view:UIView, color:String){
        view.backgroundColor = AppManager.getColor(colorKey: color)
    }
    
    func setAsRootView(view:UIViewController){
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        appDelegate.window?.rootViewController = view
    }
    
}
