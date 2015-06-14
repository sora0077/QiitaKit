//
//  AppDelegate.swift
//  QiitaKitDemo
//
//  Created by 林達也 on 2015/06/11.
//  Copyright (c) 2015年 林達也. All rights reserved.
//

import UIKit
import LoggingKit
import BrightFutures

let Qiita = QiitaKit(
    baseURL: "https://qiita.com",
    clientId: ENV.DEMO_QIITA_CLIENT_ID,
    clientSecret: ENV.DEMO_QIITA_CLIENT_SECRET
)

extension Dictionary {
    
    func map<U>(transform: Element -> U) -> [U] {
        var projection: [U] = []
        for e in self {
            projection.append(transform(e))
        }
        return projection
    }
}

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?


    func application(application: UIApplication, didFinishLaunchingWithOptions launchOptions: [NSObject: AnyObject]?) -> Bool {
        // Override point for customization after application launch.
        
        LOGGING_VERBOSE()
        
        UINavigationBar.appearance().barTintColor = UIColor(red:0.35, green:0.73, blue:0.05, alpha:1)
        UINavigationBar.appearance().tintColor = UIColor(red:0.96, green:0.96, blue:0.96, alpha:1)
        UINavigationBar.appearance().titleTextAttributes = [
            NSForegroundColorAttributeName: UIColor(red:0.96, green:0.96, blue:0.96, alpha:1)
        ]
        
        let defaults = NSUserDefaults.standardUserDefaults()
        if let dict = defaults.objectForKey("AccessToken") as? [String: AnyObject] {
            let clientId = dict["client_id"] as! String
            let scopes = dict["scopes"] as! [String]
            let token = dict["token"] as! String
            Qiita.setAccessToken(clientId, scopes: scopes, token: token)
        }
        
        return true
    }

    func application(application: UIApplication, openURL url: NSURL, sourceApplication: String?, annotation: AnyObject?) -> Bool {
        
        if Qiita.oauthCallback(url: url, sourceApplication: sourceApplication, annotation: annotation) {
            
            return true
        }
        
        return false
    }
}

