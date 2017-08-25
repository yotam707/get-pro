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
    
    var lunchTimer: Timer!

    override func viewWillAppear(_ animated: Bool) {
        
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
        
        lunchTimer = Timer.scheduledTimer(timeInterval: 1.1, target: self, selector: #selector(runTimedCode), userInfo: nil, repeats: true)
        let when = DispatchTime.now() + 10
        DispatchQueue.main.asyncAfter(deadline: when) {
            self.lunchTimer.invalidate()
            self.progressBar.progress = 1
        }
    }
    
    func runTimedCode() {
        self.progressBar.progress += 0.07
    }

    func onGetDataResponse(response: Response) {
        if response .errorTxt == "" {
            if AppManager.isUserLoggedin() {
                //navigate to user menu
                self.performSegue(withIdentifier: "userMenuSeg", sender: self)
            }
            else {
                //navigate to user menu
                self.performSegue(withIdentifier: "professionalMenuSeg", sender: self)
            }
        }
        else {
            //navigate to register
            self.performSegue(withIdentifier: "registerSeg", sender: self)
        }
        self.lunchTimer.invalidate()
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        self.dismiss(animated: true, completion: nil)
    }
}

