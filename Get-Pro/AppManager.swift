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
    

    
    
    //** mockData will be replaced with the real api (FirebaseManager) when we done.

    /////////////////////////////////////////////////
    //ELIRAN'S PART
    
    static func getUserId() -> String {
        return LocalStorageManager.readFromStorage(key: K.User.userId)
    }
    
    static func register(email:String, password:String, name:String, loginType:String, view: GetDataProtocol){
        FirebaseManager.register(email: email, password: password, name: name, loginType: loginType, view: view)
    }
    
    static func postRegister(userId:String, email:String, password:String, loginType:String) {
        LocalStorageManager.writeToStorage(key: K.Auth.email, value: email)
        LocalStorageManager.writeToStorage(key: K.Auth.password, value: password)
        LocalStorageManager.writeToStorage(key: K.Auth.loginType, value: loginType)
        LocalStorageManager.writeToStorage(key: K.User.userId, value: userId)
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
            res.status = false
            res.errorTxt = "User not exist"
            view.onGetDataResponse(response: res)
        }
        
    }

    static func isUserLoggedin() -> Bool{
        let loginType = LocalStorageManager.readFromStorage(key: K.Auth.loginType)
        return loginType == K.LoginTypes.user
    }
    
    static func initApp(view: GetDataProtocol, userType:String){
        if userType == K.LoginTypes.user {
            getCategories(view: view)
            
        }
        else {
            getPendingOrders(view: view)
        }
        getMyOrders(view: view, userType: userType)
    }
    static func getCategories(view: GetDataProtocol){
        
    }
    
    
    static func getProfessionals(orderRequestId:String){
        //return MockData.getProfessionals(orderRequestId:orderRequestId)
    }
    
    
    static func getMyOrders(view: GetDataProtocol, userType:String){
        //return MockData.getMyOrders()
    }
    
    static func getPendingOrders(view: GetDataProtocol){
        //return MockData.getMyOrders()
    }
    
    
    
    
    
    
    
    
    
    
    
    
    
    static func getMyOrderDetails(orderId:String) -> Order{
        return MockData.getMyOrderDetails(orderId:orderId)
    }
    
    
    static func publishOrder(orderReq:OrderRequest){
        
    }
    
    static func confirmOrder(orderId:String){
        
    }
    
    static func rateOrder(orderId:String, rate:Int){
        
    }
    
    
    
    
    //** mockData will be replaced with the real api (FirebaseManager) when we done.
    
    /////////////////////////////////////////////////
    //YOTAM'S PART
    
    
    

    
    
    
    
    
    
    
    
    
    
    
    
    
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
    
}
