//
//  AppManager.swift
//  Get-Pro
//
//  Created by Eliran Levy on 04/07/2017.
//  Copyright © 2017 Yotam Bloom. All rights reserved.
//

import Foundation
import UIKit


public class AppManager{
    
    ///////////////////////////////////////
    //GENERAL
    
    static func getUserId() -> String {
        return LocalStorageManager.readFromStorage(key: K.User.userId)
    }
    
    static func isUserLoggedin() -> Bool{
        let loginType = LocalStorageManager.readFromStorage(key: K.Auth.loginType)
        return loginType == K.LoginTypes.user
    }
    
    
    ///////////////////////////////////////
    //GETTERS
    
    static func register(email:String, password:String, name:String, loginType:String, view: GetDataProtocol){
        FirebaseManager.register(email: email, password: password, name: name, loginType: loginType, view: view)
    }
    
    
    static func postRegister(user :User, loginType:String) {
        
        LocalStorageManager.writeToStorage(key: K.User.userId, value: user.id)
        LocalStorageManager.writeToStorage(key: K.User.imageUrl, value: user.imageUrl)
        LocalStorageManager.writeToStorage(key: K.User.name, value: user.name)
        LocalStorageManager.writeToStorage(key: K.Auth.email, value: user.email)
        LocalStorageManager.writeToStorage(key: K.Auth.password, value: user.password)
        LocalStorageManager.writeToStorage(key: K.Auth.loginType, value: loginType)
    }
    
    
    static func login(view: GetDataProtocol){
        let email = LocalStorageManager.readFromStorage(key: K.Auth.email)
        let password = LocalStorageManager.readFromStorage(key: K.Auth.password)
        let loginType = LocalStorageManager.readFromStorage(key: K.Auth.loginType)
        if (email != "" && password != "") {
           FirebaseManager.login(email: email, password: password,loginType: loginType, view: view)
        }
        else {
            //call to view protocol with login error
            let res = Response()
            res.actionType = K.ActionTypes.login
            res.status = false
            res.errorTxt = "User not exist"
            view.onGetDataResponse(response: res)
        }
        
    }
    
    
    static func initApp(view: GetDataProtocol, userType:String){
        if userType == K.LoginTypes.user {
            getCategories(view: view)
        }
        getMyOrders(view: view, userType: userType)
    }
    
    
    static func getCategories(view: GetDataProtocol){
        CategoriesManager.getCategories(view: view)
    }
    
    
    static func getMyOrders(view: GetDataProtocol, userType:String){
        OrdersManager.getMyOrders(userId: getUserId(), loginType: userType, view: view)
    }
    
    
    
    ///////////////////////////////////////
    //SETTERS
    
    static func publishOrder(view: GetDataProtocol, orderReq:OrderRequest){
        OrdersManager.publishOrder(orderReq: orderReq, view: view)
    }
    
    
    
    //** mockData will be replaced with the real api (FirebaseManager) when we done.
    
    ///////////////////////////////////////
    //GENERAL
    
    
    static func getAlert(){
    
    }
    
    static func getLocationPermission(){
        
    }
    
    static func getInternetPermission(){
        
    }
    
    
    static func getColor(colorKey: String, alpha: CGFloat = 1.0) -> UIColor{
        
        switch colorKey {
        case K.Colors.disabledGray:
            return UIColor.init(red: rgb(number: 150), green: rgb(number: 150), blue: rgb(number: 150), alpha: alpha)
        case K.Colors.darkGray:
            return UIColor.init(red: rgb(number: 28), green: rgb(number: 58), blue: rgb(number: 85), alpha: alpha)
        case K.Colors.mediumGray:
            return UIColor.init(red: rgb(number: 129), green: rgb(number: 147), blue: rgb(number: 161), alpha: alpha)
        case K.Colors.lightGray:
            return UIColor.init(red: rgb(number: 168), green: rgb(number: 180), blue: rgb(number: 190), alpha: alpha)
        case K.Colors.darkRed:
            return UIColor.init(red: rgb(number: 216), green: rgb(number: 67), blue: rgb(number: 82), alpha: alpha)
        case K.Colors.mediumRed:
            return UIColor.init(red: rgb(number: 231), green: rgb(number: 142), blue: rgb(number: 151), alpha: alpha)
        case K.Colors.lightRed:
            return UIColor.init(red: rgb(number: 223), green: rgb(number: 212), blue: rgb(number: 217), alpha: alpha)
            
        default:
            return UIColor.white
        }
        
    }
    
    static func rgb(number:Double) -> CGFloat{
        return CGFloat(number/255.0)
    }
    
    static func getImageFromUrl(url: String, imgView: UIImageView) {
        let catPictureURL = URL(string: url)!
        
        // Creating a session object with the default configuration.
        // You can read more about it here https://developer.apple.com/reference/foundation/urlsessionconfiguration
        let session = URLSession(configuration: .default)
        
        // Define a download task. The download task will download the contents of the URL as a Data object and then you can do what you wish with that data.
        let downloadPicTask = session.dataTask(with: catPictureURL) { (data, response, error) in
            // The download has finished.
            if let e = error {
                print("Error downloading cat picture: \(e)")
                DispatchQueue.main.async ( execute:{
                    imgView.image = UIImage(named: "avatar.png")
                })
            } else {
                // No errors found.
                // It would be weird if we didn't have a response, so check for that too.
                if let res = response as? HTTPURLResponse {
                    print("Downloaded cat picture with response code \(res.statusCode)")
                    if let imageData = data {
                        // Finally convert that Data into an image and do what you wish with it.
                        let img =  UIImage(data: imageData)
                        DispatchQueue.main.async ( execute:{
                            imgView.image = img
                        })
                    } else {
                        print("Couldn't get image: Image is nil")
                        DispatchQueue.main.async ( execute:{
                            imgView.image = UIImage(named: "avatar.png")
                        })
                    }
                } else {
                    print("Couldn't get response code for some reason")
                    DispatchQueue.main.async ( execute:{
                        imgView.image = UIImage(named: "avatar.png")
                    })
                }
            }
        }
        
        downloadPicTask.resume()
    }
    
}
