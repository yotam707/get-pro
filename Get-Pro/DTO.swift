//
//  DTO.swift
//  Get-Pro
//
//  Created by Eliran Levy on 04/07/2017.
//  Copyright © 2017 Yotam Bloom. All rights reserved.
//

import Foundation


class User: BaseDTO{
    var id:String = ""
    var password:String = ""
    var email:String = ""
    var name: String = ""
    var apnToken: String = ""
    var imageUrl: String = ""
    init(id:String, password: String, email:String, name: String, apnToken: String, imageUrl: String) {
        self.id = id
        self.password = password
        self.email = email
        self.name = name
        self.apnToken = apnToken
        self.imageUrl = imageUrl
    }
    init(id:String, password: String, email:String, name: String) {
        self.id = id
        self.password = password
        self.email = email
        self.name = name
    }
    convenience override init(){
        self.init(id: "", password: "", email: "", name: "", apnToken: "", imageUrl: "")
    }
}

class Professional: BaseDTO{
    var id:String = ""
    var name:String = ""
    var phone:String = ""
    var imageUrl:String = ""
    var rating:Int = 0
    var isTopProfessional:Bool = false
    var apnToken: String = ""
    init(id: String, name: String, phone: String, imageUrl: String, rating:Int, isTopProfessional: Bool) {
        self.id = id
        self.name = name
        self.phone = phone
        self.imageUrl = imageUrl
        self.rating = rating
        self.isTopProfessional = isTopProfessional
    }
    
    convenience override init(){
        self.init(id: "", name: "", phone: "", imageUrl: "", rating: 0, isTopProfessional: false)
    }
}

class Category: BaseDTO{
    var id:String = ""
    var name:String = ""
    
    init(id:String, name: String){
        self.id = id
        self.name = name
    }
    
    convenience override init(){
        self.init(id: "", name:"")
    }
}

class Order : BaseDTO{
    var orderRequestId:String = ""
    var professionalId:String = ""
    var acceptedDate:Date = Date()
    var completedDate:Date = Date()
    
    init(orderRequestId: String, professionalId: String, acceptedDate: Date,completedDate: Date){
        self.orderRequestId = orderRequestId
        self.professionalId = professionalId
        self.acceptedDate = acceptedDate
        self.completedDate = completedDate
    }
    
    convenience override init(){
        self.init(orderRequestId: "", professionalId: "", acceptedDate: Date(), completedDate: Date())
    }
}

class OrderRequest : BaseDTO{
    var id:String = ""
    var userId:String = ""
    var categoryId:String = ""
    var problemDescription:String = ""
    var requestDate:Date = Date()
    
    init(id: String, userId: String, categoryId: String, problemDescription: String, requestDate: Date) {
        self.id = id
        self.userId = userId
        self.categoryId = categoryId
        self.problemDescription = problemDescription
        self.requestDate = requestDate
    }
    
    convenience override init(){
        self.init(id: "", userId: "", categoryId: "", problemDescription: "", requestDate: Date())
    }
}

class ProfessionalOrder: BaseDTO{
    var orderRequestId:String = ""
    var professionalId:String = ""
    var name:String = ""
    var phone:String = ""
    var imageUrl:String = ""
    var rating:Int = 0
    var isTopProfessional:Bool = false
    
    init(orderRequestId: String, professionalId: String, name: String, phone: String, imageUrl: String, rating:Int, isTopProfessional: Bool) {
        self.orderRequestId = orderRequestId
        self.professionalId = professionalId
        self.name = name
        self.phone = phone
        self.imageUrl = imageUrl
        self.rating = rating
        self.isTopProfessional = isTopProfessional
    }
    
    init(pro: Professional, orderReqId: String){
        self.orderRequestId = orderReqId
        self.professionalId = pro.id
        self.name = pro.name
        self.phone = pro.phone
        self.imageUrl = pro.imageUrl
        self.rating = pro.rating
    }
    
    convenience override init(){
        self.init(orderRequestId: "" ,professionalId: "", name: "", phone: "", imageUrl: "", rating: 0, isTopProfessional: false)
    }

    
}

class BaseDTO{
    
}


class Response{
    var entities: [BaseDTO] = [BaseDTO]()
    var errorTxt: String = ""
    var status: Bool = true
    var actionType: String = ""
    
    
}

