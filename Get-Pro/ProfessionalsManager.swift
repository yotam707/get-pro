//
//  ProfessionalsManager.swift
//  Get-Pro
//
//  Created by Yotam Bloom on 8/8/17.
//  Copyright © 2017 Yotam Bloom. All rights reserved.
//

import Foundation
import Firebase

public class ProfessionalsManager{
    static private let professionalsRef = FirebaseManager.databaseRef.child("professionals")
    static private(set) var professionals = [Professional]()
    
    
    ///////////////////////////////////////////////
    //GETTERS
    
    static func getProfessionals(orderRequestId:String, view: GetDataProtocol){
        let res = Response()
        res.actionType = K.ActionTypes.getProfessionals
        professionalsRef.queryOrdered(byChild: "orderRequestId").queryEqual(toValue: orderRequestId)
            .observe(.value, with: {  (DataSnapshot) in
                self.professionals = []
                
                guard let snapshots = DataSnapshot.children.allObjects as? [DataSnapshot] else{
                    res.status = false
                    res.errorTxt = "failed to get professionals"
                    view.onGetDataResponse(response: res)
                    return
                }
                for snap in snapshots{
                    if let professionalDic = snap.value as? Dictionary<String, AnyObject>{
                        let id_d = professionalDic["id"] as! String
                        let name_d = professionalDic["name"] as! String
                        let phone_d = professionalDic["phone"] as! String
                        let imageUrl_d = professionalDic["imageUrl"] as! String
                        let rating_d = professionalDic["rating"] as! Int
                        let isTopPro_d = professionalDic["isTopProfessional"] as! Bool
                        let pro = Professional(id: id_d, name: name_d, phone: phone_d, imageUrl: imageUrl_d, rating: rating_d, isTopProfessional: isTopPro_d)
                        self.professionals.append(pro)
                        
                    }
                }
                res.entities = self.professionals
                view.onGetDataResponse(response: res)
            })
    }
    
    static func getProfessionalDetils(professionalId: String, _ compleation:@escaping (_ result: Professional) -> ()){
        
        professionalsRef.child(professionalId)
            .observe(.value, with: {(DataSnapshot) in
                let pro = Professional.init()
                if let proDic = DataSnapshot.value as? Dictionary<String, AnyObject>{
                    pro.id = professionalId
                    pro.name = proDic["name"] as! String
                    pro.phone = proDic["phone"] as! String
                    pro.imageUrl = proDic["imageUrl"] as! String
                    pro.rating = proDic["rating"] as! Int
                    pro.isTopProfessional = proDic["isTopProfessional"] as! Bool
                    
                }
                compleation(pro)
            })
    }
    
    ////////////////////////////////////////////////
    //SETTERS
    static func setProfessionalStatus(professionalId:String, status:Bool){
        professionalsRef.child(professionalId).updateChildValues(["active": status])
    }
    
    static func addProfessionalUser(proId: String, proName: String){
        professionalsRef.child(proId).setValue(["active":true, "name" : proName, "rating" : "0"])
    }
}
