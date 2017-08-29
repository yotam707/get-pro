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
    private static let professionalsDatabaseRef = databaseRef.child("professionals")
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
    //TODO: check profile change request for display name 
    static func register(email:String, password:String, name: String, loginType: String, view: GetDataProtocol) {
        let res = Response()
        res.actionType = K.ActionTypes.register
        Auth.auth().createUser(withEmail: email, password: password) { (user, error) in
            if user != nil{
                let pushToken = getPushToken()
                if loginType == K.LoginTypes.user{
                    let u = registerUserInFbDb(id: (user?.uid)!, password: password, email: email ,name: name, apnToken: pushToken)
                    res.entities.append(u)
                    
                }
                else{
                    let p = registerProfessionalInDb(id: (user?.uid)!, password: password, email: email, name: name, apnToken: pushToken)
                    res.entities.append(p)
                }
                view.onGetDataResponse(response: res)
                let changeRequest = Auth.auth().currentUser?.createProfileChangeRequest()
                changeRequest?.displayName = name
                changeRequest?.commitChanges(completion: { error in
                    if let error = error {
                        print("error in profile change request \(error)")
                    } else {
                         print("success in profile change request")
                    }
                })
            }
            else{
                res.errorTxt = "Resgiter Failed | \(error.debugDescription)"
                res.status = false
                view.onGetDataResponse(response: res)
            }
        }
    }

    static func login(email:String, password: String, loginType: String ,view: GetDataProtocol){
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
    
    static func registerUserInFbDb(id: String, password: String, email: String ,name: String, apnToken: String) -> User{
        let u = User.init(id: id, password: password, email: email ,name: name, apnToken: apnToken, imageUrl: "")
        let usersDatabaseRefById = usersDatabaseRef.child("\(id)")
        let userObj = ["name" : name, "email" : email, "pushToken" : apnToken, "imageUrl" : ""]
        usersDatabaseRefById.setValue(userObj)
        return u
    }
    
    static func registerProfessionalInDb(id: String, password: String, email: String ,name: String, apnToken: String) -> Professional{
        let p = Professional.init(id: id, name: name + "-Pro", phone: "", imageUrl: "", rating: 0, isTopProfessional: false)
        
        let professionalsDatabaseRefById = professionalsDatabaseRef.child(id)
        let proObject = ["name" : name, "email": email, "phone": p.phone, "pushToken" : p.apnToken, "rating" : p.rating, "isTopProfessional": p.isTopProfessional, "imageUrl": p.imageUrl, "status" : true, "categoryId" : "1"] as [String : Any]
        professionalsDatabaseRefById.setValue(proObject)
        return p
    }
    
    
    ///////////////////////////////////////////////
    //PRIVATE
    
}

