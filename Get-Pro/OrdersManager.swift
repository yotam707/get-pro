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
    static private let requestOrderApprovedRef = FirebaseManager.databaseRef.child("OrderRequestApproved")
    static private let requestOrderRateRef = FirebaseManager.databaseRef.child("OrderRate")
    static private(set) var orders = [Order]()
    
    
    
    
    
    ///////////////////////////////////////////////
    //GETTERS
    static func getConfirmedOrderPros(orderRequestId: String, _ compleation:@escaping(_ result:Professional)->()){
        requestOrderApprovedRef.child(orderRequestId).observeSingleEvent(of: .childAdded, with: {(DataSnapshot) in
            let approvedOrderDic = DataSnapshot.value as? [String: AnyObject] ?? [:]
            let proId = approvedOrderDic["professionalId"] as! String
            ProfessionalsManager.getProfessionalDetils(professionalId: proId, { (pro) in
                compleation(pro)
            })
        })
    }

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
    
    static func getProfessionalOrderDetails(orderId:String, _ compleation:@escaping(_ result: OrderRequest) -> ()){
        requestOrdersRef.child(orderId).observe(.value ,with: { (DataSnapshot) in
                    let currentOrder = OrderRequest.init()
                    let orderRequestDic = DataSnapshot.value as? [String: AnyObject] ?? [:]
                    currentOrder.categoryId = orderRequestDic["categoryId"] as! String
                    currentOrder.problemDescription = orderRequestDic["problemDescription"] as! String
                    currentOrder.requestDate = convertStringToDate(dateString: orderRequestDic["requestDate"] as! String)
                    currentOrder.id = orderId
                    currentOrder.userId = orderRequestDic["userId"] as! String
                    compleation(currentOrder)
        })
        
    }
    
    static func getMyOrderDetails(orderId:String, _ compleation:@escaping(_ result: Order) -> ()){
        ordersRef.queryEqual(toValue: orderId)
            .observe(.value, with: {(DataSnapshot) in
                let currentOrder = Order.init()
                let orderDic = DataSnapshot.value as? [String: AnyObject] ?? [:]
                currentOrder.orderRequestId = orderDic["orderRequestId"] as! String
                currentOrder.professionalId = orderDic["professionalId"] as! String
                currentOrder.acceptedDate = orderDic["acceptedDate"] as! Date
                currentOrder.completedDate = orderDic["completedDate"] as! Date
                compleation(currentOrder)
            })
    }
    
    
    //example!!!
    static func getMyOrderDetails2(orderId:String, view: GetDataProtocol){
        requestOrdersRef.child(orderId)
            .observe(.value, with: {(DataSnapshot) in
                let or = OrderRequest.init()
                let orderReqDic = DataSnapshot.value as? [String: AnyObject] ?? [:]
                or.problemDescription = orderReqDic["problemDescription"] as! String
                let res = Response()
                res.entities.append(or)
                view.onGetDataResponse(response: res)
        })
    }
    
    ///////////////////////////////////////////////////
    //SETTERS
    
    static func publishOrder(orderReq:OrderRequest) -> String{
        //let requestOrdersRefByUser = requestOrdersRef.child("Users")
        let requsetOrdersRefByUserId = requestOrdersRef.childByAutoId()
        let orderRequset = ["categoryId": orderReq.categoryId, "problemDescription" : orderReq.problemDescription, "requestDate" : orderReq.requestDate.description, "userId": orderReq.userId]
       requsetOrdersRefByUserId.setValue(orderRequset)
        return requsetOrdersRefByUserId.key
        
    }
    
    static func confirmOrder(orderReqId:String, professionalId: String){
        let orderRequestApprovedRefByOrderId = requestOrderApprovedRef.child("\(orderReqId)")
        let orderRequestApproved = ["professionalId": professionalId, "timestamp" : convertDateToString(date: Date())]
        orderRequestApprovedRefByOrderId.setValue(orderRequestApproved)
        ProfessionalsManager.setProfessionalStatus(professionalId: professionalId, status: false)
        
    }
    
    static func rateOrder(orderId:String, rate:Int){
        let requestOrderRateRefByOrderId = requestOrderRateRef.child("\(orderId)")
        let rateOrder = ["rate" : rate, "timestamp": Date()] as [String : Any]
        requestOrderRateRefByOrderId.setValue(rateOrder)
    }
    
    
    ////////////////////////////////////////////////////
    //HEPLER FUNCTIONS
    
    static func convertStringToDate(dateString: String)->Date{
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd hh:mm:ss +zzzz"
        let s = dateFormatter.date(from:dateString)
        return s!
    }
    
    static func convertDateToString(date: Date)->String{
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd hh:mm:ss +zzzz"
        let s = dateFormatter.string(from:date as Date)
        return s
    }

}
