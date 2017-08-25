//
//  FirebaseConstants.swift
//  Get-Pro
//
//  Created by Yotam Bloom on 8/5/17.
//  Copyright © 2017 Yotam Bloom. All rights reserved.
//

import Foundation
import Firebase


struct FirebaseConstants{
    
    struct refs{
        let databaseRoot = Database.database().reference()
        let databaseUsers = databaseRoot.child("Users")
        let databaseCategories = databaseRoot.child("Categories")
    }
}
