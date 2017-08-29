//
//  Keys.swift
//  Get-Pro
//
//  Created by Eliran Levy on 04/07/2017.
//  Copyright © 2017 Yotam Bloom. All rights reserved.
//

import Foundation

public struct K {
    
    struct ActionTypes {
        static let register = "register"
        static let login = "login"
        static let setOrderRequest = "setOrderRequest"
        static let confirmOrderRequestByPro = "confirmOrderRequestByPro"
        static let confirmOrderRequestByUser = "confirmOrderRequestByUser"
        static let declineOrderRequest = "declineOrderRequest"
        
        static let getCategories = "getCategories"
        static let getMyOrders_User = "getMyOrders_User"
        static let getMyOrders_Pro = "getMyOrders_Pro"
        static let getPendingOrders = "getPendingOrders"
        static let getProfessionals = "getProfessionals"
        static let getProfessionalDetails = "getProfessionalDetails"
        static let getOrderDetails = "getOrderDetails"
        static let getConfirmedOrderPros = "getConfirmedOrderPros"
        static let getProfessionalOrderDetails = "getProfessionalOrderDetails"
        static let publishOrder = "publishOrder"
        
    }
    
    struct LoginTypes{
        static let user = "user"
        static let professional = "professional"
    }
    
    struct Auth {
        static let email = "email"
        static let password = "password"
        static let loginType = "loginType"
    }
    
    struct User {
        static let userId = "userId"
        static let name = "name"
        static let imageUrl = "imageUrl"
    }
    
    struct Colors {
        static let disabledGray = "disabledGray"
        
        static let darkGray = "darkGray"
        static let mediumGray = "mediumGray"
        static let lightGray = "lightGray"

        static let darkRed = "darkRed"
        static let mediumRed = "mediumRed"
        static let lightRed = "lightRed"
        
    }
    
    struct OrderStatus{
        static let pending = "pending"
        static let inProgress = "inProgress"
        static let finished = "finished"
        static let cancelled  = "cancelled"
    }
    
    struct NotificationManager{
        static let apnToken = "apnToken"
    }
}




