//
//  ViewController.swift
//  Get-Pro
//
//  Created by Yotam Bloom on 7/3/17.
//  Copyright © 2017 Yotam Bloom. All rights reserved.
//

import UIKit

class ViewController: BaseUIViewController {
    
    @IBOutlet weak var progressBar: UIProgressView!
    
    var lunchTimer: Timer!
    var isLoadedOnce = false


    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        
        CategoriesManager.getCategories { (categories) in
          
            DispatchQueue.main.async {
                
            }
            
            print(categories)
        }
        
//        var res = false
//        FirebaseManager.login(email: "yotam707@gmail.com", password: "test123",{(result) in
//            res = result
//        })
//        print(res)
//        var res = false
//        FirebaseManager.register(email: "yotam7077@gmail.com", password: "test123",name:"Yotam 2", { (result) in
//            res = result
//        })
//        print("Register was: \(res)")
//
        let orderReq = OrderRequest(id: "2", userId: "2", categoryId: "1", problemDescription: "this is a test request cloud functions", requestDate: Date())
        let id = OrdersManager.publishOrder(orderReq: orderReq)
        print(id)
        
        //load data from server
        //LocalStorageManager.clearKeys()
    
        
        if self.isLoadedOnce {
            self.handleLogin();
        }
        else{
            lunchTimer = Timer.scheduledTimer(timeInterval: 1.1, target: self, selector: #selector(runTimedCode), userInfo: nil, repeats: true)
            //check for registration
            let when = DispatchTime.now() //+ 4.5
            DispatchQueue.main.asyncAfter(deadline: when) {
                self.lunchTimer.invalidate()
                self.progressBar.progress = 0.99
                self.isLoadedOnce = true
                self.handleLogin();
            }
        }
    }
    
    func handleLogin(){
        if AppManager.login() {
            if AppManager.isUserLoggedin() {
                //navigate to user menu
                self.performSegue(withIdentifier: "userMenuSeg", sender: self)
                
            }
            else {
                //navigate to user menu
                self.performSegue(withIdentifier: "professionalMenuSeg", sender: self)
            }
        }
        else{
            //navigate to register
            self.performSegue(withIdentifier: "registerSeg", sender: self)
        }
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        self.dismiss(animated: true, completion: nil)
    }

    
    func runTimedCode() {
        if self.progressBar.progress < 0.7 {
            self.progressBar.progress += 0.05
        }
    }


}

