//
//  ProOrderInProgressViewController.swift
//  Get-Pro
//
//  Created by Eliran Levy on 29/08/2017.
//  Copyright © 2017 Yotam Bloom. All rights reserved.
//

import UIKit

class ProOrderInProgressViewController : BaseUIViewController , GetDataProtocol{
    
    @IBAction func onDoneButtonClick(_ sender: Any) {
        //send data to server
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    func onGetDataResponse(response: Response) {
        if response.status {
            
            //stop timer
            
            //navigate to pro menu view
            self.view.window!.rootViewController?.dismiss(animated: true, completion: nil)
        }
    }
    
}
