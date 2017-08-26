//
//  ViewController.swift
//  Get-Pro
//
//  Created by Yotam Bloom on 7/3/17.
//  Copyright © 2017 Yotam Bloom. All rights reserved.
//

import UIKit

class ViewController: BaseUIViewController, GetDataProtocol {
    
    @IBOutlet weak var progressBar: UIProgressView!

    override func viewWillAppear(_ animated: Bool) {
        
        super.viewWillAppear(animated)
        
        LocalStorageManager.clearKeys()
        
        //load data from server
        //get my orders (user & pro)
        if AppManager.getUserId() != "" {
            if AppManager.isUserLoggedin() {
                //get user orders
                //get categories
            }
            else {
                //get pro orders (pending & history)
            }
        }
        AppManager.login(view: self)
    }
    

    func onGetDataResponse(response: Response) {
        
        switch response.actionType {
        case K.ActionTypes.getCategories:
            break;
        case K.ActionTypes.getMyOrders_User:
            break;
        case K.ActionTypes.getMyOrders_Pro:
            break;
        case K.ActionTypes.getMyOrders_Pro:
            break;
        default:
            //login action type
            var segName = ""
            if response.status {
                if AppManager.isUserLoggedin() {
                    //navigate to user menu
                    segName = "userMenuSeg"
                }
                else {
                    //navigate to user menu
                    segName = "professionalMenuSeg"
                }
            }
            else {
                //navigate to register
                segName = "registerSeg"
            }
            
            DispatchQueue.main.async(){
                self.performSegue(withIdentifier: segName, sender: self)
            }

        }
    }
    
    
}

