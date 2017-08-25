//
//  FirebaseManager.swift
//  Get-Pro
//
//  Created by Eliran Levy on 04/07/2017.
//  Copyright © 2017 Yotam Bloom. All rights reserved.
//

import Foundation
import Firebase
import FirebaseAuth


public class FirebaseManager{

    static let databaseRef = Database.database().reference()
    private static let usersDatabaseRef = databaseRef.child("Users")
    // let authHandler : Auth.self
    
    ///////////////////////////////////////////////
    //GETTERS
    
    static func getPushToken() -> String{
        if let refreshToken = InstanceID.instanceID().token(){
            return refreshToken
        }
        return ""
    }
    
    ///////////////////////////////////////////////
    //SETTERS
    
    static func register(email:String, password:String, name: String, view: GetDataProtocol) {
        let res = Response()
        Auth.auth().createUser(withEmail: email, password: password) { (user, error) in
            if user != nil{
                let u = User.init(id: (user?.uid)!, password: password, email: email ,name: name)

                 res.entities.append(u)
                 view.onGetDataResponse(response: res)
            }
            else{
                res.errorTxt = "Resgiter Failed"
                view.onGetDataResponse(response: res)
            }
        }
    }

    static func login(email:String, password:String,view: GetDataProtocol){
        let res = Response()
        Auth.auth().signIn(withEmail: email, password: password) { (user, error) in
            if user != nil{
                let u = User.init(id: (user?.uid)!, password: password, email: email, name: "")
                
                res.entities.append(u)
                view.onGetDataResponse(response: res)
            }
            else{
                res.errorTxt = "login Failed"
                view.onGetDataResponse(response: res)
            }
        }
        
    }
    
    ///////////////////////////////////////////////
    //PRIVATE
    
}

