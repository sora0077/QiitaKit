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

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?


    func application(application: UIApplication, didFinishLaunchingWithOptions launchOptions: [NSObject: AnyObject]?) -> Bool {
        // Override point for customization after application launch.
        
        LOGGING_VERBOSE()
        
        dispatch_async(dispatch_get_main_queue()) {
            Qiita.oauthAuthorize([.ReadQiita, .WriteQiita], scheme: "qiitakitdemo://oauth/callback")
                .flatMap { _ in
                    Qiita.request(GetAuthenticatedUser())
                }
                .flatMap {
                    Qiita.request(GetUser(user_id: $0.id))
                }
                .onSuccess {
                    Logging.d($0.github_login_name)
                }
        }
        
        
        return true
    }

    func application(application: UIApplication, openURL url: NSURL, sourceApplication: String?, annotation: AnyObject?) -> Bool {
        
        if Qiita.oauthCallback(url, sourceApplication: sourceApplication, annotation: annotation) {
            
            return true
        }
        
        return false
    }
}

