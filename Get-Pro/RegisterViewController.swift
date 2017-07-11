//
//  RegisterViewController.swift
//  Get-Pro
//
//  Created by Eliran Levy on 06/07/2017.
//  Copyright © 2017 Yotam Bloom. All rights reserved.
//

import UIKit

class RegisterViewController: BaseUIViewController {
    

    @IBOutlet weak var emailTB: UITextField!
    @IBOutlet weak var passwordTB: UITextField!
    @IBOutlet weak var registerBtn: UIButton!
    
    
    override func viewDidLoad() {
        
        super.viewDidLoad()
        registerBtn.isEnabled = false
        self.enableDisableRegisterBtn(isEnabled: false)
        self.setViewColor(view: self.view, color: K.Colors.darkGray)
    }
    
    
    @IBAction func onRegisterClock(_ sender: Any) {
        
        //register - need to handle Async.
        if AppManager.register(email: emailTB.text!, password: passwordTB.text!) {
            self.dismiss(animated: true, completion: nil)
            
            // move to menu controller
            self.performSegue(withIdentifier: "menuSeg", sender: self)
        }
    }
    
    
    
    @IBAction func onTBChanged(_ sender: Any) {
        enableDisableRegisterBtn(isEnabled: (emailTB.text != nil && !(emailTB.text?.isEmpty)! && passwordTB.text != nil && self.isPasswordValid(password: passwordTB.text!) ))
    }
    
    
    func enableDisableRegisterBtn(isEnabled:Bool){
        
        registerBtn.isEnabled = isEnabled
        
        if isEnabled {
            self.setViewColor(view: registerBtn, color: K.Colors.darkRed)
        }
        else {
            self.setViewColor(view: registerBtn, color: K.Colors.disabledGray)
        }
    }
    
    
    func isPasswordValid(password : String) -> Bool{
        
        /*
         1 - Password length grater than 6.
         2 - One UpperCase letter in Password.
         3 - One Special Character in Password.
         4 - One Number in Password.
         5 - One Lowercase letter in password.
         */
        
        let passwordTest = NSPredicate(format: "SELF MATCHES %@", "^(?=.*[A-Z])(?=.*[!@#$&*])(?=.*[0-9])(?=.*[a-z]).{6,}$")
        return passwordTest.evaluate(with: password)
    }
    
}
