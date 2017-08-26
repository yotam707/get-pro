//
//  NotificationsManager.swift
//  Get-Pro
//
//  Created by Yotam Bloom on 8/19/17.
//  Copyright © 2017 Yotam Bloom. All rights reserved.
//

import Foundation
import UIKit



public class NotificationsManger{
    
    static func parseNotification(_ userInfo: [AnyHashable: Any])-> URL{
        
        var msgURL = ""
        guard let aps = userInfo["aps"] as? [String : AnyObject] else {
            print("Error parsing aps")
            return URL(string: "www.nourl.com")!
        }
        print(aps)
        
        
        if let alert1 = aps["category"] as? String {
            msgURL = alert1
        }
        return URL(string: msgURL)!
    }
    
    static func handleNotificationUrl(url: URL) -> [String]{
        return url.pathComponents
    }
    
    static func saveApnToken(token: Data){
        UserDefaults.standard.set(token, forKey: K.NotificationManager.apnToken)
    }
    static func getApnToken()->String{
        if let token = UserDefaults.standard.string(forKey: K.NotificationManager.apnToken){
            return token
        }
        return ""
    }
}
