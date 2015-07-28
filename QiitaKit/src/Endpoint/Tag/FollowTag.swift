//
//  FollowTag.swift
//  QiitaKit
//
//  Created on 2015/06/08.
//  Copyright (c) 2015年 林達也. All rights reserved.
//

import Foundation
import APIKit
import Result

/**
*  タグをフォローします。
*/
public struct FollowTag {
    
    public let id: String
    
    public init(id: String) {
        self.id = id
    }
}

extension FollowTag: RequestToken {

    public typealias Response = ()
    public typealias SerializedType = Any

    public var method: HTTPMethod {
        return .PUT
    }

    public var URL: String {
        return "/api/v2/tags/\(id)/following"
    }

    public var responseEncoding: ResponseEncoding {
        return .JSON(.AllowFragments)
    }
}
