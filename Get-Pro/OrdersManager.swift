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
    static private(set) var userOrders = [UserOrderView]()
    static private(set) var proOrders = [ProfessionalOrderDetailsView]()
    
    
    
    
    
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
                self.proOrders = []
                
                guard let snapshots = DataSnapshot.children.allObjects as? [DataSnapshot] else{
                    res.status = false
                    res.errorTxt = "Failed to bring Professional Orders"
                    view.onGetDataResponse(response: res)
                    return
                }
                
                for snap in snapshots{
                    let proOrder = ProfessionalOrderDetailsView()
                    if let ordersDic = snap.value as? Dictionary<String,AnyObject>{
                        proOrder.orderRequestId = snap.key
                        proOrder.professionalId = proId
                        proOrder.userName = ordersDic["userName"] as! String
                        proOrder.userImageUrl = ordersDic["userImageUrl"] as! String
                        proOrder.problemDescription = ordersDic["problemDescription"] as! String
                        proOrder.acceptedDate = convertStringToDate(dateString: (ordersDic["acceptedDate"] as! String))
                        self.proOrders.append(proOrder)
                    }
                }
                res.entities = self.proOrders
                view.onGetDataResponse(response: res)
            })

    }
    
    static func getUserOrders(userId: String, view: GetDataProtocol, res: Response){
        res.actionType = K.ActionTypes.getMyOrders_User
        myOrdersUserRef.child("\(userId)")
            .observe(.value, with: {(DataSnapshot) in
                self.userOrders = []
                
                guard let snapshots = DataSnapshot.children.allObjects as? [DataSnapshot] else{
                    res.status = false
                    res.errorTxt = "Failed to bring User Orders"
                    view.onGetDataResponse(response: res)
                    return
                }
                
                for snap in snapshots{
                    if let ordersDic = snap.value as? Dictionary<String,AnyObject>{
                        let userOrder = UserOrderView()
                        userOrder.orderRequstId = snap.key
                        userOrder.categoryName = ordersDic["categoryName"] as! String
                        userOrder.professionalId = ordersDic["professionalId"] as! String
                        userOrder.professionalName = ordersDic["professionalName"] as! String
                        userOrder.professionalImageUrl = ordersDic["professionalImageUrl"] as! String
                        userOrder.professionalRating = ordersDic["professionalRating"] as! Int
                        userOrder.problemDescription = ordersDic["problemDescription"] as! String
                        userOrder.acceptedDate = convertStringToDate(dateString: (ordersDic["acceptDate"] as! String))
                        self.userOrders.append(userOrder)
                    }
                }
                res.entities = self.userOrders
                view.onGetDataResponse(response: res)
            })

    }

    
    static func getProfessionalOrderDetails(orderRequsetId:String, view: GetDataProtocol){
        let res = Response()
        res.actionType = K.ActionTypes.getProfessionalOrderDetails
        requestOrdersRef.child(orderRequsetId).observe(.value ,with: { (DataSnapshot) in
                    let currentOrder = ProfessionalOrderDetailsView.init()
                    let orderRequestDic = DataSnapshot.value as? [String: AnyObject] ?? [:]
                    currentOrder.userName = orderRequestDic["userName"] as! String
                    currentOrder.problemDescription = orderRequestDic["problemDescription"] as! String
                    currentOrder.userImageUrl = orderRequestDic["userImageUrl"] as! String
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
                return
            }
            if (dic["professionalId"]?.exists())!{
                compleation(true)
            }
        })
    }
    
    static func getProApprovedOrderByUser(orderReqId: String, professionalId: String, _ compleation:@escaping (_ result: Bool)->()){
        myOrdersProRef.child(professionalId).child(orderReqId).observeSingleEvent(of: .childAdded, with: { (DataSnapshot) in
            guard let dic = DataSnapshot.value as? [String: AnyObject] else {
                return
            }
            if (!dic.isEmpty) {
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
        let orderRequset = ["categoryId": orderReq.categoryId,"cateogryName": orderReq.categoryName,"problemDescription" : orderReq.problemDescription, "requestDate" : orderReq.requestDate.description, "userId": orderReq.userId, "userName" : orderReq.userName, "userImageUrl" : orderReq.userImageUrl ,"status" : K.OrderStatus.pending]
        requsetOrdersRefByUserId.setValue(orderRequset)
        let orderReqId = requsetOrdersRefByUserId.key
        orderReq.id = orderReqId
        getProfessionalsApprovedOrder(orderReqId: orderReqId,{ (proOrder) in
            res.entities.append(proOrder)
            view.onGetDataResponse(response: res)
        })
        
    }
    
    
    
    static func addUserOrder(orderReqId: String, userId: String, requestDate: String, categoryName: String){
        let userOrderRef = myOrdersUserRef.child("\(userId)").child("\(orderReqId)")
        let userOrderObj = ["requestDate" : requestDate, "categoryName" : categoryName]
        userOrderRef.setValue(userOrderObj)
    }
    
    static func confirmOrderByProfessional(orderProDetails: ProfessionalOrderDetailsView ,view: GetDataProtocol){
        let res = Response()
        res.actionType = K.ActionTypes.confirmOrderRequestByPro
        let orderRequestApprovedRefByOrderId = requestOrderApprovedRef.child("\(orderProDetails.orderRequestId)")
        let timestamp = convertDateToString(date: Date())
        let orderRequestApproved = ["professionalId": orderProDetails.professionalId ,"acceptDate" : timestamp]
       
        orderRequestApprovedRefByOrderId.setValue(orderRequestApproved)
        ProfessionalsManager.setProfessionalStatus(professionalId: orderProDetails.professionalId, status: false)
        getProApprovedOrderByUser(orderReqId: orderProDetails.orderRequestId, professionalId: orderProDetails.professionalId, { (result) in
            if result {
                view.onGetDataResponse(response: res)
            }
            else{
                res.status = false
                res.errorTxt = "Confirm order by professional failed"
                view.onGetDataResponse(response: res)
            }
        
        })
        
    }

    
    static func confirmOrderByUser(userOrder: UserOrderView, view: GetDataProtocol){
        //change order request status to in progress
        //send to professional approval
        //write this order for the user and professional
        
        let res = Response()
        res.actionType = K.ActionTypes.confirmOrderRequestByUser
        getUserApprovedOrder(orderReqId: userOrder.orderRequstId, { (result) in
            if result {
                //update order request status
                updateOrderRequestStatus(orderRequestId: userOrder.orderRequstId, status: K.OrderStatus.inProgress)
                let timestamp = convertDateToString(date: Date())
                //need to add function here
                let userOrderDetails = ["professionalId": userOrder.professionalId, "professionalName": userOrder.professionalName, "professionalImageUrl" : userOrder.professionalImageUrl, "professionalRating": userOrder.professionalRating.description ,"userName" : userOrder.userName, "categoryName": userOrder.categoryName, "problemDescription" : userOrder.problemDescription ,"acceptDate" : timestamp]
                
                let proOrderDetails = ["userId": userOrder.userId, "userImageUrl" : userOrder.userImageUrl, "userName" : userOrder.userName, "categoryName": userOrder.categoryName,
                                       "problemDescription" : userOrder.problemDescription ,"acceptDate" : timestamp]
                let userOrderRef = myOrdersUserRef.child(userOrder.userId).child(userOrder.orderRequstId)
                userOrderRef.setValue(userOrderDetails)
                let proOrderRef =  myOrdersProRef.child(userOrder.professionalId).child(userOrder.orderRequstId)
                proOrderRef.setValue(proOrderDetails)
                
                view.onGetDataResponse(response: res)
            }
            else{
                res.status = false
                res.errorTxt = "The order was not approved"
                view.onGetDataResponse(response: res)
            }
        })
    }
    
    static func updateOrderRequestStatus(orderRequestId: String, status: String){
        let orderRequestRefById = requestOrdersRef.child(orderRequestId)
        let updateOrderReqObj = ["status" : status]
        orderRequestRefById.updateChildValues(updateOrderReqObj)
        
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
