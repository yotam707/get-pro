//
//  ProfessionalMenuTabBarController.swift
//  Get-Pro
//
//  Created by Eliran Levy on 24/08/2017.
//  Copyright © 2017 Yotam Bloom. All rights reserved.
//

import UIKit

class ProfessionalMenuTabBarController : UITabBarController {
    
    var orderRequestId = ""
    var isOpenedFromNotification = false
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        if(isOpenedFromNotification){
            self.isOpenedFromNotification = false
            //proFromNotificationSeg
            DispatchQueue.main.async ( execute:{
                self.performSegue(withIdentifier: "proFromNotificationSeg", sender: self)
            })
        }
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let vc = segue.destination as! ProfessionalOrderDetailsViewController
        vc.orderRequestId = self.orderRequestId
    }
    
}
