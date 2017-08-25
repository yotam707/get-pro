//
//  RegisterViewController.swift
//  Get-Pro
//
//  Created by Eliran Levy on 06/07/2017.
//  Copyright © 2017 Yotam Bloom. All rights reserved.
//

import UIKit

class RegisterViewController: BaseUIViewController, GetDataProtocol {
    

    @IBOutlet weak var emailTB: UITextField!
    @IBOutlet weak var passwordTB: UITextField!
    @IBOutlet weak var registerBtn: UIButton!
    @IBOutlet weak var registerAsProBtn: UIButton!
    var selectedloginType: String = ""
    
    override func viewDidLoad() {
        
        super.viewDidLoad()
        registerBtn.isEnabled = false
        registerAsProBtn.isEnabled = false
        selectedloginType = ""
        self.enableDisableRegisterBtn(isEnabled: false)
        self.setViewColor(view: self.view, color: K.Colors.darkGray)
    }
    
    
    @IBAction func onRegisterClick(_ sender: Any) {
        AppManager.register(email: emailTB.text!, password: passwordTB.text!, name: "Bob", loginType: K.LoginTypes.user, view: self)
        self.selectedloginType = K.LoginTypes.user
    }
    
    
    @IBAction func onRegisterAsProClick(_ sender: Any) {
        AppManager.register(email: emailTB.text!, password: passwordTB.text!, name: "Bobi", loginType: K.LoginTypes.professional, view: self)
        self.selectedloginType = K.LoginTypes.professional
    }
    
    
    @IBAction func onTBChanged(_ sender: Any) {
        enableDisableRegisterBtn(isEnabled: (emailTB.text != nil && !(emailTB.text?.isEmpty)! && passwordTB.text != nil && self.isPasswordValid(password: passwordTB.text!) && self.isEmailValid(email: emailTB.text!)))
    }
    
    
    func enableDisableRegisterBtn(isEnabled:Bool){
        
        registerBtn.isEnabled = isEnabled
        registerAsProBtn.isEnabled = isEnabled
        
        if isEnabled {
            self.setViewColor(view: registerBtn, color: K.Colors.darkRed)
            self.setViewColor(view: registerAsProBtn, color: K.Colors.darkRed)
        }
        else {
            self.setViewColor(view: registerBtn, color: K.Colors.disabledGray)
            self.setViewColor(view: registerAsProBtn, color: K.Colors.disabledGray)
        }
    }
    
    func isEmailValid(email:String) -> Bool{
        /* from http://emailregex.com/
        */
        let emailTest = NSPredicate(format: "SELF MATCHES %@", "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,64}")
        return emailTest.evaluate(with: email)
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
    
    func onGetDataResponse(response: Response) {
        if response.status {
            let user = (response.entities as! [User])[0]
            AppManager.postRegister(userId: user.id, email: user.email, password: user.password, loginType: selectedloginType)
            
            if self.selectedloginType == K.LoginTypes.user {
                self.performSegue(withIdentifier: "r_UserMenuSeg", sender: self)
            }
            else {
                self.performSegue(withIdentifier: "r_ProfessionalMenuSeg", sender: self)
            }
        }
    }
    
}
