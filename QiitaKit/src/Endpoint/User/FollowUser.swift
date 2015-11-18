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
    
    public let id: User.Identifier
    
    public init(id: User.Identifier) {
        self.id = id
    }
}

extension FollowUser: QiitaRequestToken {
    
    public typealias Response = ()
    public typealias SerializedObject = Any

    public var method: HTTPMethod {
        return .PUT
    }
    
    public var path: String {
        return "/api/v2/users/\(id)/following"
    }
}
