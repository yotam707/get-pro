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
    
    static func register(email:String, password:String, loginType:String) -> Bool{
        return true
    }

    static func login(email:String, password:String, _ completion:@escaping (_ result: Bool) -> ()){
        Auth.auth().signIn(withEmail: email, password: password) { (user, error) in
            if user != nil{
                completion(true)
            }
            else{
            completion(false)
            }
        }
        
    }
    
    ///////////////////////////////////////////////
    //PRIVATE
    
}

