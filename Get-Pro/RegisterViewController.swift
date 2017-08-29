//
//  RegisterViewController.swift
//  Get-Pro
//
//  Created by Eliran Levy on 06/07/2017.
//  Copyright © 2017 Yotam Bloom. All rights reserved.
//

import UIKit

class RegisterViewController: BaseUIViewController, GetDataProtocol {
    
    @IBOutlet weak var nameTB: UITextField!
    @IBOutlet weak var emailTB: UITextField!
    @IBOutlet weak var passwordTB: UITextField!
    @IBOutlet weak var registerBtn: UIButton!
    @IBOutlet weak var registerAsProBtn: UIButton!
    @IBOutlet weak var loadingAI: UIActivityIndicatorView!
    
    var selectedloginType: String = ""
    
    override func viewDidLoad() {
        
        super.viewDidLoad()
        self.registerBtn.isEnabled = false
        self.registerAsProBtn.isEnabled = false
        self.loadingAI.isHidden = true
        self.selectedloginType = ""
        self.enableDisableRegisterBtn(isEnabled: false)
        self.setViewColor(view: self.view, color: K.Colors.darkGray)
    }
    
    
    @IBAction func onRegisterClick(_ sender: Any) {
        self.setViewState(isEnabled: false)
        self.loadingAI.startAnimating()
        self.loadingAI.isHidden = false
        AppManager.register(email: emailTB.text!, password: passwordTB.text!, name: nameTB.text!, loginType: K.LoginTypes.user, view: self)
        self.selectedloginType = K.LoginTypes.user
    }
    
    
    @IBAction func onRegisterAsProClick(_ sender: Any) {
        self.setViewState(isEnabled: false)
        self.loadingAI.startAnimating()
        self.loadingAI.isHidden = false
        AppManager.register(email: emailTB.text!, password: passwordTB.text!, name: nameTB.text!, loginType: K.LoginTypes.professional, view: self)
        self.selectedloginType = K.LoginTypes.professional
    }
    
    
    @IBAction func onTBChanged(_ sender: Any) {
        enableDisableRegisterBtn(isEnabled: (emailTB.text != nil && !(emailTB.text?.isEmpty)! && nameTB.text != nil && !(nameTB.text?.isEmpty)! && passwordTB.text != nil && self.isPasswordValid(password: passwordTB.text!) && self.isEmailValid(email: emailTB.text!)))
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
    
    func setViewState(isEnabled:Bool){
        registerBtn.isEnabled = isEnabled
        registerAsProBtn.isEnabled = isEnabled
        nameTB.isEnabled = isEnabled
        emailTB.isEnabled = isEnabled
        passwordTB.isEnabled = isEnabled
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
        
        switch response.actionType {
        case K.ActionTypes.getCategories:
            self.loadingAI.stopAnimating()
            self.loadingAI.isHidden = true
            if self.selectedloginType == K.LoginTypes.user {
                self.performSegue(withIdentifier: "r_UserMenuSeg", sender: self)
            }
            else {
                self.performSegue(withIdentifier: "r_ProfessionalMenuSeg", sender: self)
            }
            break;
        case K.ActionTypes.getMyOrders_Pro:
            break;
        case K.ActionTypes.getMyOrders_User:
            break;
        case K.ActionTypes.getPendingOrders:
            break;
        default:
            //register action
            if response.status {
                let user = (response.entities as! [User])[0]
                AppManager.postRegister(user: user, loginType: selectedloginType)
                AppManager.initApp(view: self, userType: self.selectedloginType)
            }
            else {
                //alert here
                self.loadingAI.stopAnimating()
                self.loadingAI.isHidden = false
                self.setViewState(isEnabled: true)

            }
        }
    }
    
}
