//
//  GetUserFollowing.swift
//  QiitaKit
//
//  Created on 2015/06/08.
//  Copyright (c) 2015年 林達也. All rights reserved.
//

import Foundation
import APIKit
import Result

/**
*  ユーザをフォローしている場合に204を返します。
*/
public struct GetUserFollowing {
    
    public let id: String
    
    public init(id: String) {
        self.id = id
    }
}

extension GetUserFollowing: RequestToken {
    
    public typealias Response = ()
    public typealias SerializedType = Any

    public var method: HTTPMethod {
        return .GET
    }

    public var URL: String {
        return "/api/v2/users/\(id)/following"
    }
}
