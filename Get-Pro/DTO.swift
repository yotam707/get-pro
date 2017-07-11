//
//  DTO.swift
//  Get-Pro
//
//  Created by Eliran Levy on 04/07/2017.
//  Copyright © 2017 Yotam Bloom. All rights reserved.
//

import Foundation


class User{
    var id:String = ""
    var name:String = ""
    var email:String = ""
}

class Professional{
    var id:String = ""
    var name:String = ""
    var phone:String = ""
    var imageUrl:String = ""
    var rating:Int = 0
}

class Category{
    var id:String = ""
    var name:String = ""
}

class Order{
    var orderRequestId:String = ""
    var professionalId:String = ""
    var acceptedDate:DispatchTime = DispatchTime.now()
    var completedDate:DispatchTime = DispatchTime.now()
}

class OrderRequest{
    var id:String = ""
    var userId:String = ""
    var categoryId:String = ""
    var problemDescription:String = ""
    var requestDate:DispatchTime = DispatchTime.now()
}


