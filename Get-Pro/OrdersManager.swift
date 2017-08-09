//
//  OrdersManager.swift
//  Get-Pro
//
//  Created by Yotam Bloom on 8/8/17.
//  Copyright © 2017 Yotam Bloom. All rights reserved.
//

import Foundation
import Firebase

public class OrdersManager{
    
    static private let ordersRef = FirebaseManager.databaseRef.child("Orders")
    static private let requestOrdersRef = FirebaseManager.databaseRef.child("OrderRequest")
    static private(set) var orders = [Order]()
    
    
    ///////////////////////////////////////////////
    //GETTERS
    static func getMyOrders(userId: String, _ compleation:@escaping(_ result:[Order]) -> ()){
        ordersRef.queryOrdered(byChild: "userId").queryEqual(toValue: userId)
            .observe(.value, with: {(DataSnapshot) in
                self.orders = []
                
                guard let snapshots = DataSnapshot.children.allObjects as? [DataSnapshot] else{
                    compleation(self.orders)
                    return
                }
                
                for snap in snapshots{
                    if let ordersDic = snap.value as? Dictionary<String,AnyObject>{
                        let orderReqId_d = ordersDic["orderRequestId"] as! String
                        let professionalId_d = ordersDic["professionalId"] as! String
                        let acceptedDate_d = ordersDic["acceptedDate"] as! Date
                        let completedDate_d = ordersDic["completedDate"] as! Date
                        
                        let order = Order(orderRequestId: orderReqId_d, professionalId: professionalId_d, acceptedDate: acceptedDate_d, completedDate: completedDate_d)
                        
                        self.orders.append(order)
                    }
                }
                compleation(self.orders)
        })
    }
    
    
    ///////////////////////////////////////////////////
    //SETTERS
    
    static func publishOrder(orderReq:OrderRequest){
        let requestOrdersRefByUser = requestOrdersRef.child("Users")
        let requsetOrdersRefByUserId = requestOrdersRefByUser.child("\(orderReq.userId)").childByAutoId()
        let orderRequset = ["categoryId": orderReq.categoryId, "problemDescription" : orderReq.problemDescription, "requestDate" : orderReq.requestDate.description, "ff": orderReq.userId]
       requsetOrdersRefByUserId.setValue(orderRequset)
        
    }
    
    static func confirmOrder(orderId:String){
        
    }
    
    static func rateOrder(orderId:String, rate:Int){
        
    }
    

}
