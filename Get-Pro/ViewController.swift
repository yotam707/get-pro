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
    var isLoginSuccessfull = false
    var userDataProgress = 2
    var userDataProgressCounter = 2
    var proDataProgress = 2
    var proDataProgressCounter = 2

    override func viewWillAppear(_ animated: Bool) {
        
        super.viewWillAppear(animated)
        
        //LocalStorageManager.clearKeys()
        
        //get my orders (user & pro)
        if AppManager.getUserId() != "" {
            self.isLoginSuccessfull = true
            if AppManager.isUserLoggedin() {
                //get user orders
                //get categories
                AppManager.initApp(view: self, userType: K.LoginTypes.user)
                self.handleDataProgressResponse(progress: self.userDataProgress, counter: self.userDataProgressCounter)
            }
            else {
                //get pro orders (pending & history)
                 AppManager.initApp(view: self, userType: K.LoginTypes.professional)
                self.handleDataProgressResponse(progress: self.proDataProgress, counter: self.proDataProgressCounter)
            }
        }
        else {
            AppManager.login(view: self)
        }
    }
    

    func onGetDataResponse(response: Response) {
        
        switch response.actionType {
        case K.ActionTypes.getCategories:
            self.userDataProgressCounter-=1
            self.handleDataProgressResponse(progress: self.userDataProgress, counter: self.userDataProgressCounter)
            break;
        case K.ActionTypes.getMyOrders_User:
            self.userDataProgressCounter-=1
            self.handleDataProgressResponse(progress: self.userDataProgress, counter: self.userDataProgressCounter)
            break;
        case K.ActionTypes.getMyOrders_Pro:
            self.proDataProgressCounter-=1
            self.handleDataProgressResponse(progress: self.proDataProgress, counter: self.proDataProgressCounter)
            break;
        case K.ActionTypes.getPendingOrders:
            self.proDataProgressCounter-=1
            self.handleDataProgressResponse(progress: self.proDataProgress, counter: self.proDataProgressCounter)
            break;
        default:
            //login action type
            if response.status {
                isLoginSuccessfull = true
                //in case all loaders ends & we got success for user login - we navigate to next view
                if self.userDataProgressCounter == 0 || self.proDataProgressCounter == 0 {
                    self.handleLoginState()
                }
            }
            else {
                //navigate to register
                DispatchQueue.main.async(){
                    self.performSegue(withIdentifier: "registerSeg", sender: self)
                }
            }
        }
    }
    
    func handleDataProgressResponse(progress:Int, counter:Int){
        self.progressBar.progress = (Float(1 - counter/progress))
        //in case all loaders ends & we got success for user login - we navigate to next view
        if counter == 0 && isLoginSuccessfull{
            self.handleLoginState()
        }
    }
    
    func handleLoginState(){
        var segName = ""
        if AppManager.isUserLoggedin() {
            //navigate to user menu
            segName = "userMenuSeg"
        }
        else {
            //navigate to user menu
            segName = "professionalMenuSeg"
        }
        DispatchQueue.main.async(){
            self.performSegue(withIdentifier: segName, sender: self)
        }
    }
    
}

