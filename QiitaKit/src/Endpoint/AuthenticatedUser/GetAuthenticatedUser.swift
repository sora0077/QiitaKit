//
//  GetAuthenticatedUser.swift
//  QiitaKit
//
//  Created on 2015/06/08.
//  Copyright (c) 2015年 林達也. All rights reserved.
//

import Foundation
import APIKit
import Result

/**
*  アクセストークンに紐付いたユーザを返します。
*/
public struct GetAuthenticatedUser {
    public init() {
    }
}

extension GetAuthenticatedUser: RequestToken {

    public typealias Response = AuthenticatedUser
    public typealias SerializedType = [String: AnyObject]

    public var method: HTTPMethod {
        return .GET
    }

    public var URL: String {
        return "/api/v2/authenticated_user"
    }
}

extension GetAuthenticatedUser {
    
    public static func transform(request: NSURLRequest, response: NSHTTPURLResponse?, object: SerializedType) -> Response {
        
        return _AuthenticatedUser(object)
    }
}
