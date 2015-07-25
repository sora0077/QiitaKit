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
import Result

extension Result {

    init(_ value: T) {
        self = .Success(value)
    }
}

extension AccessToken {
    
    public enum Scope: String {
        case ReadQiita = "read_qiita"
        case WriteQiita = "write_qiita"
        case ReadQiitaTeam = "read_qiita_team"
        case WriteQiitaTeam = "write_qiita_team"
        
    }
    
    private static func ScopeValues(scopes: [AccessToken.Scope]) -> String {
        return "+".join(scopes.map({ $0.rawValue }))
    }
}

public let QiitaKitErrorDomain = "jp.sora0077.QiitaKit.ErrorDomain"
public let QiitaAPIErrorDomain = "jp.sora0077.QiitaAPI.ErrorDomain"

public enum QiitaKitError: APIKitErrorType {
    
    case QiitaAPIError(type: String, message: String, code: Int)
//    case ValidationError(ErrorType)
    
    case NonAccessToken
    
    case OAuthStateMismatchError(String)
    case UnknownError
    
    public static func NetworkError(error: ErrorType) -> QiitaKitError {
        return .UnknownError
    }
    
    public static func SerializeError(error: ErrorType) -> QiitaKitError {
        return .UnknownError
    }
    
    public static func ValidationError(error: ErrorType) -> QiitaKitError {
        return .UnknownError
    }
}


/**
*  <#Description#>
*/
public class QiitaKit: API<QiitaKitError> {
    
    let baseURL: String
    
    let clientId: String
    let clientSecret: String
    
    private var callbackScheme: String?
    private var oauthPromise: Promise<AccessToken, QiitaKitError>?
    
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
    
    public override func validate(request URLRequest: NSURLRequest, response: NSHTTPURLResponse, object: AnyObject?) -> QiitaKitError? {
        
        do {
            let JSON = try json_encode_dictionary(object)
            
            if  let type = JSON?["type"] as? String,
                let message = JSON?["message"] as? String
            {
                let code = response.statusCode
                return .QiitaAPIError(type: type, message: message, code: code)
            }
            return nil
        }
        catch let error {
            return .ValidationError(error)
        }
        
    }
    
    public func setAccessToken(clientId: String, scopes: [String], token: String) {
        accessToken = AccessToken(client_id: clientId, scopes: scopes, token: token)
    }
    
    public func oauthAuthorize(scopes: [AccessToken.Scope], scheme: String, state: String? = nil) -> Future<AccessToken, QiitaKitError> {
        
        let promise = Promise<AccessToken, QiitaKitError>()
        
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
    
    public func oauthCallback(state: String? = nil, url: NSURL, sourceApplication: String?, annotation: AnyObject?) throws -> Bool {
        
        func query(items: [NSURLQueryItem], _ name: String) -> String? {
            return items.filter({ $0.name == name }).first?.value
        }
        
        let urlString = url.absoluteString
        if  let scheme = callbackScheme,
            let promise = oauthPromise,
            let components = NSURLComponents(string: urlString),
            let items = components.queryItems,
            let code = query(items, "code")
            where urlString.hasPrefix(scheme)
        {
            
            let returnedState = query(items, "state")
            if let returnedState = returnedState where state != returnedState {
                try! promise.failure(.OAuthStateMismatchError(returnedState))
                return false
            }
            
            let createAccessToken = CreateAccessToken(client_id: clientId, client_secret: clientSecret, code: code)
            
            request(createAccessToken).onComplete { [weak self] result in
                switch result {
                case .Success(let accessToken):
                    self?.accessToken = accessToken
                default:
                    break
                }
                try! promise.complete(result)
            }
            return true
        }
        return false
    }
    
    public func oauthDelete() -> Future<(), QiitaKitError> {
        if let accessToken = accessToken {
            let deleteAccessToken = DeleteAccessToken(access_token: accessToken.token)
            return request(deleteAccessToken).map { [weak self] t in
                self?.accessToken = nil
                return t
            }
        }
        return Future(error: .NonAccessToken)
    }
    
    public func flatMap<T, U>(v: T, _ transform: T -> Future<U, NSError>) -> Future<U, NSError> {
        return transform(v)
    }
    
    public func flatMap<U>(transform: () -> Future<U, NSError>) -> Future<U, NSError> {
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

private func json_encode_dictionary(data: AnyObject?) throws -> [String: AnyObject]? {
    
    if let data = data as? NSData {
        let f = NSJSONSerialization.JSONObjectWithData
        
        do {
            let JSON = try f(data, options: .AllowFragments) as? [String: AnyObject]
            return JSON
        }
    }
    
    if let JSON = data as? [String: AnyObject] {
        return JSON
    }
    
    return nil
}

