//
//  QiitaKit.swift
//  QiitaKit
//
//  Created by 林達也 on 2015/06/08.
//  Copyright (c) 2015年 林達也. All rights reserved.
//

import Foundation
import UIKit
import APIKit
import BrightFutures
import LoggingKit

extension AccessToken {
    
    public enum Scope: String {
        case ReadQiita = "read_qiita"
        case WriteQiita = "write_qiita"
        
    }
    
}

/**
*  <#Description#>
*/
public class QiitaKit: API {
    
    let baseURL: String
    
    let clientId: String
    let clientSecret: String
    
    private var callbackScheme: String?
    private var oauthPromise: Promise<AccessToken>?
    private var accessToken: AccessToken?
    
    public init(baseURL: String, clientId: String, clientSecret: String) {
        self.baseURL = baseURL
        
        self.clientId = clientId
        self.clientSecret = clientSecret
        
        NSURLProtocol.registerClass(LoggingURLProtocol.self)
        
        super.init(baseURL: baseURL)
    }
    
    
    public func oauthAuthorize(scopes: [AccessToken.Scope], scheme: String) -> Future<AccessToken> {
        
        let promise = Promise<AccessToken>()
        
        callbackScheme = scheme
        oauthPromise = promise
        
        let app = UIApplication.sharedApplication()
        let url = NSURL(string: "\(baseURL)/api/v2/oauth/authorize?client_id=\(clientId)&scope=read_qiita")
        app.openURL(url!)
        
        return promise.future
    }
    
    public func oauthCallback(url: NSURL, sourceApplication: String?, annotation: AnyObject?) -> Bool {
        
        if let scheme = callbackScheme,
            let urlString = url.absoluteString,
            let components = NSURLComponents(string: urlString),
            let items = components.queryItems as? [NSURLQueryItem],
            let code = items.filter({ $0.name == "code" }).first?.value
            where urlString.hasPrefix(scheme)
        {
            let createAccessToken = CreateAccessToken(client_id: clientId, client_secret: clientSecret, code: code)
            
            let f = self.request(createAccessToken)
            let p = oauthPromise!
            f.onComplete {
                p.complete($0)
            }
            return true
        }
        return false
    }
    
}

class LoggingURLProtocol: NSURLProtocol {
    
    override class func canInitWithRequest(request: NSURLRequest) -> Bool {
        Logging.d(request)
        return false
    }
}
