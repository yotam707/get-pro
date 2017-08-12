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
    // let authHandler : Auth.self
    
    ///////////////////////////////////////////////
    //GETTERS
    
   
    
    ///////////////////////////////////////////////
    //SETTERS
    
    static func register(email:String, password:String,_ completion:@escaping (_ result: Bool) -> ()){
        Auth.auth().createUser(withEmail: email, password: password) { (user, error) in
            if user != nil {
                    completion(true)
                print("the user: \(String(describing: user)) was created in fire base")
            }
            else{
                completion(false)
                
            }
        }
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

