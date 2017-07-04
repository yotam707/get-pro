//
//  MockData.swift
//  Get-Pro
//
//  Created by Eliran Levy on 04/07/2017.
//  Copyright © 2017 Yotam Bloom. All rights reserved.
//

import Foundation

public class MockData{
    
    
    ///////////////////////////////////////////////
    //GETTERS
    
    static func getCategories() -> [Category]{
        var categories = [Category]()
        
        let c1 = Category()
        categories.append(c1)
        
        let c2 = Category()
        categories.append(c2)
        
        let c3 = Category()
        categories.append(c3)
        
        let c4 = Category()
        categories.append(c4)
        
        let c5 = Category()
        categories.append(c5)
        
        let c6 = Category()
        categories.append(c6)
        
        let c7 = Category()
        categories.append(c7)
        
        return categories
    }
    
    static func getProfessionals(categoryId:String) -> [Professional]{
        var professionals =  [Professional]()
        
        let p1 = Professional()
        professionals.append(p1)
        
        let p2 = Professional()
        professionals.append(p2)
        
        let p3 = Professional()
        professionals.append(p3)
        
        let p4 = Professional()
        professionals.append(p4)
        
        return professionals
    }
    
    static func getMyOrders() -> [Order]{
        var orders = [Order]()
        
        let o1 = Order()
        orders.append(o1)
        
        let o2 = Order()
        orders.append(o2)
        
        let o3 = Order()
        orders.append(o3)
        
        let o4 = Order()
        orders.append(o4)
        
        return orders
    }
    
    static func getMyOrderDetails(orderId:String) -> Order{
        return Order()
    }
    
    
    ///////////////////////////////////////////////
    //SETTERS
    
    static func register(userName:String, password:String) -> Bool{
        return true
    }
    
    static func login(userName:String, password:String) -> Bool{
        return true
    }
    
    static func publishOrder(order:Order){
        
    }
    
    static func confirmOrder(orderId:String){
        
    }
    
    static func rateOrder(orderId:String, rate:Int){
        
    }
    
}
