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
    var userName:String = ""
    var userImageUrl: String = ""
    var professionalId: String = ""
    var categoryId:String = ""
    var categoryName: String = ""
    var problemDescription:String = ""
    var requestDate:Date = Date()
    
    init(id: String, userId: String, categoryId: String, problemDescription: String) {
        self.id = id
        self.userId = userId
        self.categoryId = categoryId
        self.problemDescription = problemDescription
        self.requestDate = Date()
    }
    
    convenience override init(){
        self.init(id: "", userId: "", categoryId: "", problemDescription: "")
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




////////////////
//View DTO



class UserOrderView : BaseDTO {
    var orderRequstId: String = ""
    var categoryName:String = ""
    var userId: String = ""
    var userName: String = ""
    var userImageUrl: String = ""
    var professionalId: String = ""
    var professionalName:String = ""
    var professionalImageUrl:String = ""
    var professionalRating:Int = 0
    var problemDescription: String = ""
    var acceptedDate: Date = Date()
    var completedDate:Date = Date()
    
    init(orderRequstId :String ,categoryName: String, userName: String, professionalId:String ,professionalName: String, professionalImageUrl: String, professionalRating: Int, completedDate: Date) {
        self.professionalId = professionalId
        self.orderRequstId = orderRequstId
        self.professionalName = professionalName
        self.categoryName = categoryName
        self.professionalImageUrl = professionalImageUrl
        self.professionalRating = professionalRating
        self.completedDate = completedDate
    }
    
    convenience override init(){
        self.init(orderRequstId : "",categoryName: "", userName: "", professionalId:"", professionalName: "" , professionalImageUrl: "", professionalRating: 0, completedDate: Date())
    }
}


class ProfessionalOrderDetailsView: BaseDTO{
    var orderRequestId:String = ""
    var professionalId:String = ""
    var professionalName:String = ""
    var professionalImageUrl:String = ""
    var professionalRating:Int = 0
    var userName:String = ""
    var userImageUrl:String = ""
    var userLocationDistance: Float
    var userCity: String
    var problemDescription:String = ""
    var acceptedDate: Date = Date()
    var completedDate:Date = Date()
    
    init(orderRequestId: String, professionalId: String, userName: String, userImageUrl: String, userLocationDistance: Float, userCity: String, problemDescription: String, completedDate : Date) {
        self.orderRequestId = orderRequestId
        self.professionalId = professionalId
        self.userName = userName
        self.userImageUrl = userImageUrl
        self.userLocationDistance = userLocationDistance
        self.userCity = userCity
        self.problemDescription = problemDescription
        self.completedDate = completedDate
    }
    
    convenience override init(){
        self.init(orderRequestId: "", professionalId: "", userName: "", userImageUrl: "",userLocationDistance: 0.0, userCity: "", problemDescription: "", completedDate : Date())
    }
}







