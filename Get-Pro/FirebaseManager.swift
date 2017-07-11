//
//  FirebaseManager.swift
//  Get-Pro
//
//  Created by Eliran Levy on 04/07/2017.
//  Copyright © 2017 Yotam Bloom. All rights reserved.
//

import Foundation

public class FirebaseManager{
    
    
    ///////////////////////////////////////////////
    //GETTERS
    
    static func getCategories() -> [Category]{
        return [Category]()
    }
    
    static func getProfessionals(orderRequestId:String) -> [Professional]{
        return [Professional]()
    }
    
    static func getMyOrders() -> [Order]{
        return [Order]()
    }
    
    static func getMyOrderDetails(orderId:String) -> Order{
        return Order()
    }
    
    
    
    ///////////////////////////////////////////////
    //SETTERS
    
    static func register(email:String, password:String) -> Bool{
        return true
    }
    
    static func login(email:String, password:String) -> Bool{
        return true
    }
    
    static func publishOrder(orderReq:OrderRequest){
        
    }
    
    static func confirmOrder(orderId:String){
        
    }
    
    static func rateOrder(orderId:String, rate:Int){
        
    }
    
    
    ///////////////////////////////////////////////
    //PRIVATE
    
}

