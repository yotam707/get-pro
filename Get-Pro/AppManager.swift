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
    
    static func register(userName:String, password:String) -> Bool{
        let auth = MockData.register(userName: userName, password: password)
        if auth {
            //write regstration details to local storage
            LocalStorageManager.writeToStorage(key: K.Auth.userName, value: userName)
            LocalStorageManager.writeToStorage(key: K.Auth.password, value: password)
            return true
        }
        return false
    }
    
    
    static func login() -> Bool{
        
        let userName = LocalStorageManager.readFromStorage(key: K.Auth.userName)
        let password = LocalStorageManager.readFromStorage(key: K.Auth.password)
        
        return MockData.login(userName: userName, password: password)
    }

    
    static func getCategories() -> [Category]{
        return MockData.getCategories()
    }
    
    
    static func getProfessionals(categoryId:String) -> [Professional]{
        return MockData.getProfessionals(categoryId:categoryId)
    }
    
    
    static func getMyOrders() -> [Order]{
        return MockData.getMyOrders()
    }
    
    
    static func getMyOrderDetails(orderId:String) -> Order{
        return MockData.getMyOrderDetails(orderId:orderId)
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
            return UIColor.init(red: rgb(number: 36), green: rgb(number: 49), blue: rgb(number: 49), alpha: alpha)
        case K.Colors.mediumGray:
            return UIColor.init(red: rgb(number: 80), green: rgb(number: 100), blue: rgb(number: 100), alpha: alpha)
        case K.Colors.lightGray:
            return UIColor.init(red: rgb(number: 195), green: rgb(number: 210), blue: rgb(number: 210), alpha: alpha)
        case K.Colors.appBlue:
            return UIColor.init(red: rgb(number: 56), green: rgb(number: 208), blue: rgb(number: 255), alpha: alpha)
            
        default:
            return UIColor.white
        }
        
    }
    
    
    
    static func rgb(number:Double) -> CGFloat{
        return CGFloat(number/255.0)
    }
    
}
