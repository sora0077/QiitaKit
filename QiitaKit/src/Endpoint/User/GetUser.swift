//
//  GetUser.swift
//  QiitaKit
//
//  Created on 2015/06/08.
//  Copyright (c) 2015年 林達也. All rights reserved.
//

import Foundation
import APIKit
import Result

/**
*  ユーザを取得します。
*/
public struct GetUser {
    
    public let id: User.Identifier
    
    public init(id: User.Identifier) {
        self.id = id
    }
}

extension GetUser: RequestToken {
    
    public typealias Response = User
    public typealias SerializedObject = [String: AnyObject]

    public var method: HTTPMethod {
        return .GET
    }

    public var path: String {
        return "/api/v2/users/\(id)"
    }
}

public extension GetUser {
    
    func transform(request: NSURLRequest?, response: NSHTTPURLResponse?, object: SerializedObject) throws -> Response {
        
        return try _User(object)
    }
}
