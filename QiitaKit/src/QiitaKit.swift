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

extension AccessToken {
    
    public enum Scope: String {
        case ReadQiita = "read_qiita"
        case WriteQiita = "write_qiita"
        case ReadQiitaTeam = "read_qiita_team"
        case WriteQiitaTeam = "write_qiita_team"
        
    }
    
    private static func ScopeValues(scopes: [AccessToken.Scope]) -> String {
        return join("+", scopes.map({ $0.rawValue }))
    }
}

public let QiitaKitErrorDomain = "jp.sora0077.QiitaKit.ErrorDomain"

/**
*  <#Description#>
*/
public class QiitaKit: API {
    
    let baseURL: String
    
    let clientId: String
    let clientSecret: String
    
    private var callbackScheme: String?
    private var oauthPromise: Promise<AccessToken>?
    
    public private(set) var accessToken: AccessToken?
    
    public init(baseURL: String, clientId: String, clientSecret: String, configuration: NSURLSessionConfiguration = NSURLSessionConfiguration.defaultSessionConfiguration(), debugger: APIDebugger? = nil) {
        self.baseURL = baseURL
        
        self.clientId = clientId
        self.clientSecret = clientSecret
        
        super.init(baseURL: baseURL, configuration: configuration, debugger: debugger)
    }
    
    public override func additionalHeaders() -> [String : AnyObject]? {
        if let accessToken = accessToken {
            return [
                "Authorization": "Bearer \(accessToken.token)"
            ]
        }
        return nil
    }
    
    public func setAccessToken(clientId: String, scopes: [String], token: String) {
        accessToken = AccessToken(client_id: clientId, scopes: scopes, token: token)
    }
    
    public func oauthAuthorize(scopes: [AccessToken.Scope], scheme: String, state: String? = nil) -> Future<AccessToken> {
        
        let promise = Promise<AccessToken>()
        
        callbackScheme = scheme
        oauthPromise = promise
        
        assert(scopes.count > 0, "where scopes.count > 0")
        
        let app = UIApplication.sharedApplication()
        var string = "\(baseURL)/api/v2/oauth/authorize?client_id=\(clientId)&scope=\(AccessToken.ScopeValues(scopes))"
        if let state = state {
            string += "&state=\(state)"
        }
        let url = NSURL(string: string)
        app.openURL(url!)
        
        return promise.future
    }
    
    public func oauthCallback(state: String? = nil, url: NSURL, sourceApplication: String?, annotation: AnyObject?) -> Bool {
        
        func query(items: [NSURLQueryItem], name: String) -> String? {
            return items.filter({ $0.name == name }).first?.value
        }
        
        if let scheme = callbackScheme,
            let promise = oauthPromise,
            let urlString = url.absoluteString,
            let components = NSURLComponents(string: urlString),
            let items = components.queryItems as? [NSURLQueryItem],
            let code = query(items, "code")
            where urlString.hasPrefix(scheme)
        {
            let returnedState = query(items, "state")
            if state != returnedState {
                promise.failure(NSError(
                    domain: QiitaKitErrorDomain,
                    code: -1,
                    userInfo: [
                        NSLocalizedDescriptionKey: "The operation couldn’t be completed. state:\(returnedState) mismatch."
                    ])
                )
                return false
            }
            
            let createAccessToken = CreateAccessToken(client_id: clientId, client_secret: clientSecret, code: code)
            
            request(createAccessToken).onComplete { [weak self] result in
                switch result {
                case .Success(let accessToken):
                    self?.accessToken = accessToken.value
                default:
                    break
                }
                promise.complete(result)
            }
            return true
        }
        return false
    }
    
    public func oauthDelete() -> Future<()> {
        if let accessToken = accessToken {
            let deleteAccessToken = DeleteAccessToken(access_token: accessToken.token)
            return request(deleteAccessToken).map { [weak self] t in
                self?.accessToken = nil
                return t
            }
        }
        return Future.failed(NSError(
            domain: QiitaKitErrorDomain,
            code: -1,
            userInfo: [
                NSLocalizedDescriptionKey: "The operation couldn’t be completed."
            ])
        )
    }
    
    public func flatMap<T, U>(v: T, _ transform: T -> Future<U>) -> Future<U> {
        return transform(v)
    }
    
    public func flatMap<U>(transform: () -> Future<U>) -> Future<U> {
        return transform()
    }
    
//    public func flatMap<T, U: RequestToken>(v: T, _ transform: T -> U) -> RequestChain<U> {
//        
//        return RequestChain(api: self, future: self.request(transform(v)))
//    }
}

//public final class RequestChain<T: RequestToken> {
//    
//    let api: API
//    let future: Future<T.Response>
//    
//    init(api: API, future: Future<T.Response>) {
//        self.api = api
//        self.future = future
//    }
//    
//    public func flatMap<U: RequestToken>(transform: T.Response -> U) -> RequestChain<U> {
//        
//        let a = api
//        
//        let u = future.flatMap {
//            a.request(transform($0))
//        }
//        
//        return RequestChain<U>(api: a, future: u)
//    }
//}

