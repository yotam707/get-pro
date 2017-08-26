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
    static private let myOrdersUserRef = FirebaseManager.databaseRef.child("UserOrders")
    static private let myOrdersProRef = FirebaseManager.databaseRef.child("ProfessionalOrders")
    static private(set) var orders = [Order]()
    
    
    
    
    
    ///////////////////////////////////////////////
    //GETTERS
    static func getConfirmedOrderPros(orderRequestId: String, view: GetDataProtocol){
        let res = Response()
        res.actionType = K.ActionTypes.getConfirmedOrderPros
        requestOrderApprovedRef.child(orderRequestId).observeSingleEvent(of: .childAdded, with: {(DataSnapshot) in
            let approvedOrderDic = DataSnapshot.value as? [String: AnyObject] ?? [:]
            let proId = approvedOrderDic["professionalId"] as! String
            ProfessionalsManager.getProfessionalDetils(professionalId: proId, { (pro) in
                res.entities.append(pro)
                view.onGetDataResponse(response: res)
            })
        })
    }

    static func getMyOrders(userId: String, loginType:String, view: GetDataProtocol){
        let res = Response()
        switch loginType {
        case K.LoginTypes.user:
            getUserOrders(userId: userId, view: view, res: res)
        case K.LoginTypes.professional:
            getProOrders(proId: userId, view: view, res: res)
        default:
            res.status = false
            res.errorTxt = "Unknowen login type in getMyOrders"
        }
    }
    
    static func getProOrders(proId: String, view: GetDataProtocol, res: Response){
        res.actionType = K.ActionTypes.getMyOrders_Pro
        myOrdersProRef.child("\(proId)")
            .observe(.value, with: {(DataSnapshot) in
                self.orders = []
                
                guard let snapshots = DataSnapshot.children.allObjects as? [DataSnapshot] else{
                    res.status = false
                    res.errorTxt = "Failed to bring Professional Orders"
                    view.onGetDataResponse(response: res)
                    return
                }
                
                for snap in snapshots{
                    if let ordersDic = snap.value as? Dictionary<String,AnyObject>{
                        let orderReqId_d = ordersDic["orderRequestId"] as! String
                        let professionalId_d = ordersDic["userId"] as! String
                        let acceptedDate_d = ordersDic["acceptedDate"] as! Date
                        let completedDate_d = ordersDic["completedDate"] as! Date
                        
                        let order = Order(orderRequestId: orderReqId_d, professionalId: professionalId_d, acceptedDate: acceptedDate_d, completedDate: completedDate_d)
                        
                        self.orders.append(order)
                    }
                }
                res.entities = self.orders
                view.onGetDataResponse(response: res)
            })

    }
    
    static func getUserOrders(userId: String, view: GetDataProtocol, res: Response){
        res.actionType = K.ActionTypes.getMyOrders_User
        myOrdersUserRef.child("\(userId)")
            .observe(.value, with: {(DataSnapshot) in
                self.orders = []
                
                guard let snapshots = DataSnapshot.children.allObjects as? [DataSnapshot] else{
                    res.status = false
                    res.errorTxt = "Failed to bring User Orders"
                    view.onGetDataResponse(response: res)
                    return
                }
                
                for snap in snapshots{
                    if let ordersDic = snap.value as? Dictionary<String,AnyObject>{
                        let orderReqId_d = snap.key
                        //let categoryId = ordersDic["categoryId"] as! String
                        let requestDate = ordersDic["requestDate"] as! Date
                        //let status = ordersDic["status"] as! String
                        
                        
                        let order = Order(orderRequestId: orderReqId_d, professionalId: "", acceptedDate: requestDate, completedDate: requestDate)
                        
                        print(order)
                    }
                }
                res.entities = self.orders
                view.onGetDataResponse(response: res)
            })

    }

    
    static func getProfessionalOrderDetails(orderId:String, view: GetDataProtocol){
        let res = Response()
        res.actionType = K.ActionTypes.getProfessionalOrderDetails
        requestOrdersRef.child(orderId).observe(.value ,with: { (DataSnapshot) in
                    let currentOrder = OrderRequest.init()
                    let orderRequestDic = DataSnapshot.value as? [String: AnyObject] ?? [:]
                    currentOrder.categoryId = orderRequestDic["categoryId"] as! String
                    currentOrder.problemDescription = orderRequestDic["problemDescription"] as! String
                    currentOrder.requestDate = convertStringToDate(dateString: orderRequestDic["requestDate"] as! String)
                    currentOrder.id = orderId
                    currentOrder.userId = orderRequestDic["userId"] as! String
                    res.entities.append(currentOrder)
                    view.onGetDataResponse(response: res)
        })
        
    }
    
    static func getMyOrderDetails(orderId:String, view: GetDataProtocol){
        let res = Response()
        res.actionType = K.ActionTypes.getOrderDetails
        ordersRef.queryEqual(toValue: orderId)
            .observe(.value, with: {(DataSnapshot) in
                let currentOrder = Order.init()
                let orderDic = DataSnapshot.value as? [String: AnyObject] ?? [:]
                currentOrder.orderRequestId = orderDic["orderRequestId"] as! String
                currentOrder.professionalId = orderDic["professionalId"] as! String
                currentOrder.acceptedDate = orderDic["acceptedDate"] as! Date
                currentOrder.completedDate = orderDic["completedDate"] as! Date
                res.entities.append(currentOrder)
                view.onGetDataResponse(response: res)
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
    
    static func getProfessionalsApprovedOrder(orderReqId: String, _ compleation:@escaping (_ result: ProfessionalOrder) ->()){
        requestOrderApprovedRef.child(orderReqId).observeSingleEvent(of: .childAdded, with: {(DataSnapshot) in
            let approvedOrderDic = DataSnapshot.value as? [String: AnyObject] ?? [:]
            let proId = approvedOrderDic["professionalId"] as! String
            ProfessionalsManager.getProfessionalDetils(professionalId: proId, { (pro) in
                let orderPro = ProfessionalOrder.init(pro: pro, orderReqId: orderReqId)
                compleation(orderPro)
            })
        })
        
    }
    
    
    static func getUserApprovedOrder(orderReqId: String, _ compleation:@escaping (_ result: Bool)->()){
        requestOrderApprovedRef.child(orderReqId).observeSingleEvent(of: .childChanged, with: { (DataSnapshot) in
            guard let dic = DataSnapshot.value as? [String: AnyObject] else {
                //compleation(false)
                return
            }
            if (dic["userId"]?.exists())!{
                compleation(true)
            }
        })
    }
    ///////////////////////////////////////////////////
    //SETTERS
    
    static func publishOrder(orderReq:OrderRequest, view: GetDataProtocol){
        let res = Response()
        res.actionType = K.ActionTypes.publishOrder
        let requsetOrdersRefByUserId = requestOrdersRef.childByAutoId()
        let orderRequset = ["categoryId": orderReq.categoryId, "problemDescription" : orderReq.problemDescription, "requestDate" : orderReq.requestDate.description, "userId": orderReq.userId]
        requsetOrdersRefByUserId.setValue(orderRequset)
        let orderReqId = requsetOrdersRefByUserId.key
        orderReq.id = orderReqId
        addUserOrder(orderReqId: orderReq.id, userId: orderReq.userId, requestDate: orderReq.requestDate.description, categoryId: orderReq.categoryId)
        getProfessionalsApprovedOrder(orderReqId: orderReqId, { (proOrder) in
            res.entities.append(proOrder)
            view.onGetDataResponse(response: res)
        })
        
    }
    
    
    
    static func addUserOrder(orderReqId: String, userId: String, requestDate: String, categoryId: String){
        let userOrderRef = myOrdersUserRef.child("\(userId)").child("\(orderReqId)")
        let userOrderObj = ["status" : K.OrderStatus.pending, "requestDate" : requestDate, "categoryId" : categoryId]
        userOrderRef.setValue(userOrderObj)
    }
    
    static func confirmOrderByProfessional(orderReqId:String, professionalId: String, userId: String, view: GetDataProtocol){
        let orderRequestApprovedRefByOrderId = requestOrderApprovedRef.child("\(orderReqId)")
        let timestamp = convertDateToString(date: Date())
        let orderRequestApproved = ["professionalId": professionalId, "userId" : userId, "acceptDate" : timestamp]
        orderRequestApprovedRefByOrderId.setValue(orderRequestApproved)
        addProfessionalOrder(orderReqId: orderReqId, professionalId: professionalId, acceptDate: timestamp, userId: userId)
        updateUserOrderWithProId(proId: professionalId, userId: userId, orderReqId: orderReqId)
        ProfessionalsManager.setProfessionalStatus(professionalId: professionalId, status: false)
        
    }
    
    static func confirmOrderByUser(orderReqId: String, professionalId: String, userId: String, view: GetDataProtocol){
        //need to add function here
        //getUserApprovedOrder
    }
    
    static func updateFinishOrder(orderReqId: String, proId: String, userId: String){
        //update user
        updateUserFinishOrder(orderReqId: orderReqId, userId: userId)
        //update pro
        updateProFinishOrder(orderReqId: orderReqId, proId: proId)
        
    }
    
    static func updateUserFinishOrder(orderReqId: String, userId: String){
        let userOrderRef = myOrdersUserRef.child("\(userId)").child("\(orderReqId)")
        let userOrderObj = ["status" : K.OrderStatus.finished, "finishedDate" : convertDateToString(date: Date())]
        userOrderRef.updateChildValues(userOrderObj)
    }
    
    static func updateProFinishOrder(orderReqId: String, proId: String){
        let proOrderRef = myOrdersProRef.child("\(proId)").child("\(orderReqId)")
        let proOrderObj = ["finishedDate": convertDateToString(date: Date())]
        proOrderRef.updateChildValues(proOrderObj)
        ProfessionalsManager.setProfessionalStatus(professionalId: proId, status: true)

    }

    
    static func updateUserOrderWithProId(proId: String, userId: String, orderReqId: String){
        myOrdersProRef.child(userId).child(orderReqId).updateChildValues(["status" : K.OrderStatus.inProgress, "professionalId" : proId])
        requestOrderApprovedRef.child(orderReqId).updateChildValues(["userId": userId])
    }
    
    static func addProfessionalOrder(orderReqId:String, professionalId: String, acceptDate: String, userId: String){
        let proOrderRef = myOrdersProRef.child("\(professionalId)").child("\(orderReqId)")
        let proOrderObj = ["acceptDate": acceptDate, "userId": userId]
        proOrderRef.setValue(proOrderObj)
    }
    
    static func rateOrder(orderId:String, rate:Int){
        let requestOrderRateRefByOrderId = requestOrderRateRef.child("\(orderId)")
        let timestamp = convertDateToString(date: Date())
        let rateOrder = ["rate" : rate.description, "timestamp": timestamp]
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
