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
    
    func displayAlert(title:String = "Error", message:String){
        let alert = UIAlertController(title: title, message: message, preferredStyle: UIAlertControllerStyle.alert)
        alert.addAction(UIAlertAction(title: "Close", style: UIAlertActionStyle.default, handler: nil))
        self.present(alert, animated: true, completion: nil)
    }
    
    func displayAlertWithCompletion(title:String = "Error", message:String, closeButtonHandler:@escaping (_ action: UIAlertAction)->Void){
        let alert = UIAlertController(title: title, message: message, preferredStyle: UIAlertControllerStyle.alert)
        alert.addAction(UIAlertAction(title: "Close", style: UIAlertActionStyle.default, handler: closeButtonHandler))
        self.present(alert, animated: true, completion: nil)
    }
    
    func initActionTimer(view: GetDataProtocol){
        let when = DispatchTime.now() + 90
        DispatchQueue.main.asyncAfter(deadline: when, execute: {
            let res = Response()
            res.status = true
            res.errorTxt = "The action was rejected duo to timeuot."
            res.actionType = K.ActionTypes.rejectAction
            view.onGetDataResponse(response: res)
        })
    }
    
}
