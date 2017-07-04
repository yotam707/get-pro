//
//  AppManager.swift
//  Get-Pro
//
//  Created by Eliran Levy on 04/07/2017.
//  Copyright © 2017 Yotam Bloom. All rights reserved.
//

import Foundation

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
    
    
    
}
