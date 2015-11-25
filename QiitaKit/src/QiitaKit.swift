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
import Alamofire
import BrightFutures
import Result

extension AccessToken {
    
    public enum Scope: String {
        case ReadQiita = "read_qiita"
        case WriteQiita = "write_qiita"
        case ReadQiitaTeam = "read_qiita_team"
        case WriteQiitaTeam = "write_qiita_team"
        
    }
    
    private static func ScopeValues(scopes: [AccessToken.Scope]) -> String {
        return scopes.map({ $0.rawValue }).joinWithSeparator("+")
    }
}

public protocol QiitaRequestToken: RequestToken {}


public enum QiitaKitError: APIKitErrorType {
    
    case QiitaAPIError(message: String, type: String)
    
    case NetworkError(ErrorType)
    
    case OAuthStateMismatchError(String)
    case UnknownError(ErrorType?)
    
    public static func networkError(error: ErrorType) -> QiitaKitError {
        return .NetworkError(error)
    }
    
    public static func serializeError(error: ErrorType) -> QiitaKitError {
        return .NetworkError(error)
    }
    
    public static func validationError(error: ErrorType) -> QiitaKitError {
        return .NetworkError(error)
    }
    
    public static func unsupportedError(error: ErrorType) -> QiitaKitError {
        return .UnknownError(error)
    }
}

/// QiitaKit
public final class QiitaSession {
    
    private let clientId: String
    private let clientSecret: String
    private let baseURL: NSURL
    
    private let api: API<Error>
    
    private var callbackScheme: String?
    private var oauthPromise: Promise<AccessToken, Error>?
    
    public private(set) var accessToken: AccessToken?
    
    public init(clientId: String, clientSecret: String, baseURL: NSURL! = NSURL(string: "https://qiita.com"), configuration: NSURLSessionConfiguration = NSURLSessionConfiguration.defaultSessionConfiguration()) {
        
        self.clientId = clientId
        self.clientSecret = clientSecret
        self.baseURL = baseURL
        self.api = API(baseURL: baseURL, configuration: configuration)
        
        self.api.delegate = self
    }
    
    /**
     <#Description#>
     
     - parameter clientId: <#clientId description#>
     - parameter scopes:   <#scopes description#>
     - parameter token:    <#token description#>
     */
    public func setAccessToken(clientId: String, scopes: [String], token: String) {
        accessToken = AccessToken(client_id: clientId, scopes: scopes, token: token)
    }
    
    /**
     <#Description#>
     
     - parameter scopes: <#scopes description#>
     - parameter scheme: <#scheme description#>
     - parameter state:  <#state description#>
     
     - returns: <#return value description#>
     */
    public func oauthAuthorize(scopes: [AccessToken.Scope], scheme: String, state: String? = nil) -> Future<AccessToken, Error> {
        
        let promise = Promise<AccessToken, Error>()
        
        callbackScheme = scheme
        oauthPromise = promise
        
        assert(scopes.count > 0, "where scopes.count > 0")
        
        let app = UIApplication.sharedApplication()
        var string = baseURL.URLByAppendingPathComponent("/api/v2/oauth/authorize").absoluteString
        string += "?client_id=\(clientId)&scope=\(AccessToken.ScopeValues(scopes))"
        if let state = state {
            string += "&state=\(state)"
        }
        let url = NSURL(string: string)
        app.openURL(url!)
        
        return promise.future
    }
    
    /**
     <#Description#>
     
     - parameter state:             <#state description#>
     - parameter url:               <#url description#>
     - parameter sourceApplication: <#sourceApplication description#>
     - parameter annotation:        <#annotation description#>
     
     - returns: <#return value description#>
     */
    public func oauthCallback(state: String? = nil, url: NSURL, sourceApplication: String?, annotation: AnyObject?) -> Bool {
        
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
                promise.failure(.OAuthStateMismatchError(returnedState))
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
                promise.complete(result)
            }
            return true
        }
        return false
    }
    
    /**
     <#Description#>
     
     - returns: <#return value description#>
     */
    public func oauthDelete() -> Future<(), Error> {
        if let accessToken = accessToken {
            let deleteAccessToken = DeleteAccessToken(access_token: accessToken.token)
            return request(deleteAccessToken).map { [weak self] t in
                self?.accessToken = nil
                return t
            }
        }
        return Future(value: ())
    }
}

extension QiitaSession: APICustomizableDelegate {
    
    public func customHeaders(var tokenHeader: [String: String]) -> [String: String] {
        if let accessToken = accessToken {
            tokenHeader["Authorization"] = "Bearer \(accessToken.token)"
        }
        return tokenHeader
    }
}

extension QiitaSession: APIKitProtocol {
    
    public typealias Error = QiitaKitError
    
    
    public func cancel<T : RequestToken>(clazz: T.Type) {
        api.cancel(clazz)
    }
    
    public func cancel<T : RequestToken>(clazz: T.Type, _ f: T -> Bool) {
        api.cancel(clazz, f)
    }
    
    public func request<T: RequestToken>(token: T) -> Future<T.Response, Error> {
        return api.request(token)
    }
    
    public func request<T: RequestToken, S: ResponseSerializerType>(token: T, serializer: S) -> Future<T.Response, Error> {
        return api.request(token, serializer: serializer)
    }
    
    public func request<T: MultipartRequestToken>(token: T) -> Future<T.Response, Error> {
        return api.request(token)
    }
    
    public func request<T: MultipartRequestToken, S: ResponseSerializerType>(token: T, serializer: S) -> Future<T.Response, Error> {
        return api.request(token, serializer: serializer)
    }
    
}

