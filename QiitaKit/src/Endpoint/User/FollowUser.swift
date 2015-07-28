//
//  FollowUser.swift
//  QiitaKit
//
//  Created on 2015/06/08.
//  Copyright (c) 2015年 林達也. All rights reserved.
//

import Foundation
import APIKit
import Result

/**
*  ユーザをフォローします。
*/
public struct FollowUser {
    
    public let id: String
    
    public init(id: String) {
        self.id = id
    }
}

extension FollowUser: RequestToken {
    
    public typealias Response = ()
    public typealias SerializedType = Any

    public var method: HTTPMethod {
        return .PUT
    }
    
    public var URL: String {
        return "/api/v2/users/\(id)/following"
    }
}
