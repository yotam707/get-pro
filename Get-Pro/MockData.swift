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
        c1.id = "1"
        c1.name = "category 1"
        categories.append(c1)
        
        let c2 = Category()
        c2.id = "2"
        c2.name = "category 2"
        categories.append(c2)
        
        let c3 = Category()
        c3.id = "3"
        c3.name = "category 3"
        categories.append(c3)
        
        let c4 = Category()
        c4.id = "4"
        c4.name = "category 4"
        categories.append(c4)
        
        let c5 = Category()
        c5.id = "5"
        c5.name = "category 5"
        categories.append(c5)
        
        let c6 = Category()
        c6.id = "6"
        c6.name = "category 6"
        categories.append(c6)
        
        let c7 = Category()
        c7.id = "7"
        c7.name = "category 7"
        categories.append(c7)
        
        return categories
    }
    
    static func getProfessionals(orderRequestId:String) -> [Professional]{
        var professionals =  [Professional]()
        
        let p1 = Professional()
        p1.id = "1"
        p1.name = "p1"
        p1.phone = "0500000000"
        p1.rating = 3
        professionals.append(p1)
        
        let p2 = Professional()
        p2.id = "2"
        p2.name = "p2"
        p2.phone = "0500000000"
        p2.rating = 5
        professionals.append(p2)
        
        let p3 = Professional()
        p3.id = "3"
        p3.name = "p3"
        p3.phone = "0500000000"
        p3.rating = 0
        professionals.append(p3)
        
        let p4 = Professional()
        p4.id = "4"
        p4.name = "p4"
        p4.phone = "0500000000"
        p4.rating = 1
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
    
}
