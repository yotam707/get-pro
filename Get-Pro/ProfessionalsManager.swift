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
    
    static func getProfessionals(orderRequestId:String, _ compleation:@escaping (_ result: [Professional]) ->()){
        professionalsRef.queryOrdered(byChild: "orderRequestId").queryEqual(toValue: orderRequestId)
            .observe(.value, with: {  (DataSnapshot) in
                self.professionals = []
                
                guard let snapshots = DataSnapshot.children.allObjects as? [DataSnapshot] else{
                    compleation(self.professionals)
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
                
                compleation(self.professionals)
            })
    }
}
