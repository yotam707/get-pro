//
//  CategoriesManager.swift
//  Get-Pro
//
//  Created by Yotam Bloom on 8/8/17.
//  Copyright © 2017 Yotam Bloom. All rights reserved.
//

import Foundation
import Firebase


public class CategoriesManager{
    
    static private let categoriesRef = FirebaseManager.databaseRef.child("Categories")
    static private(set) var categories = [Category]()
    
    
    ///////////////////////////////////////////////
    //GETTERS
    
    static func getCategories(view:GetDataProtocol){
        let res = Response()
        res.actionType = K.ActionTypes.getCategories
        categoriesRef.observe(.value, with: { (DataSnapshot) in
            self.categories = []
            
            guard let snapshots = DataSnapshot.children.allObjects as? [DataSnapshot] else {
                res.errorTxt = "No Categories to display"
                res.status = false
                view.onGetDataResponse(response: res)
                return
            }
            for snap in snapshots{
                if let catDictionary = snap.value as? Dictionary<String, AnyObject>{
                    let cat = Category(id: String(catDictionary["id"] as! Int), name: catDictionary["categoryName"] as! String)
                    self.categories.append(cat)
                }
            }
            
            res.entities = self.categories
            view.onGetDataResponse(response: res)
        })
        
    }

    
    
}


