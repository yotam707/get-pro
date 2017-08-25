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
    
    static func register(email:String, password:String, name: String, loginType: String, view: GetDataProtocol) {
        let res = Response()
        Auth.auth().createUser(withEmail: email, password: password) { (user, error) in
            if user != nil{
                let u = User.init(id: (user?.uid)!, password: password, email: email ,name: name)
                registerUserInFbDb(user: u, loginType: loginType)
                res.entities.append(u)
                view.onGetDataResponse(response: res)
                let changeRequest = user?.createProfileChangeRequest()
                changeRequest?.displayName = name
                changeRequest?.commitChanges(completion: { error in
                    if let error = error {
                        print("error in profile change request \(error)")
                    } else {
                         print("success in profile change request")                    }
                })
            }
            else{
                res.errorTxt = "Resgiter Failed"
                res.status = false
                view.onGetDataResponse(response: res)
            }
        }
    }

    static func login(email:String, password:String,view: GetDataProtocol){
        let res = Response()
        Auth.auth().signIn(withEmail: email, password: password) { (user, error) in
            if user != nil{
                let u = User.init(id: (user?.uid)!, password: password, email: email, name: (user?.displayName)!)
                res.entities.append(u)
                view.onGetDataResponse(response: res)
            }
            else{
                res.errorTxt = "login Failed"
                res.status = false
                view.onGetDataResponse(response: res)
            }
        }
        
    }
    
    static func registerUserInFbDb(user: User, loginType :String){
        let usersDatabaseRefById = usersDatabaseRef.child("\(user.id)")
        let userObj = ["name" : user.name, "email" : user.email, "userType" : loginType]
        usersDatabaseRefById.setValue(userObj)
    }
    
    static func getUserNameById(uid: String,  _ compleation:@escaping(_ result: String) -> ()){
        usersDatabaseRef.child("\(uid)")
            .observe(.value, with: {(DataSnapshot) in
                let userDic = DataSnapshot.value as? [String: AnyObject] ?? [:]
                compleation(userDic["name"] as! String)
        })

    }
    
    ///////////////////////////////////////////////
    //PRIVATE
    
}

