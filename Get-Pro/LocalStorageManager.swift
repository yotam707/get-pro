//
//  LocalStorageManager.swift
//  Get-Pro
//
//  Created by Eliran Levy on 04/07/2017.
//  Copyright © 2017 Yotam Bloom. All rights reserved.
//

import Foundation

public class LocalStorageManager{

    static var storage = UserDefaults.standard
    
    static func writeToStorage(key:String, value:String){
        self.storage.set(value, forKey: key)
    }
    
    static func readFromStorage(key:String) -> String{
        if let result = self.storage.string(forKey: key) {
            return result
        }
        return "-1"
    }
    
    static func clearKeys(){
        for key in Array(storage.dictionaryRepresentation().keys) {
            storage.removeObject(forKey: key)
        }
    }
    
    ///////////////////////////////////////
    //PRIVATE
    
    
}
