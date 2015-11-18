//
//  GetTagFollowing.swift
//  QiitaKit
//
//  Created on 2015/06/08.
//  Copyright (c) 2015年 林達也. All rights reserved.
//

import Foundation
import APIKit
import Result

/**
*  タグをフォローしているかどうかを調べます。
*/
public struct GetTagFollowing {
    
    public let id: Tag.Identifier
    
    public init(id: Tag.Identifier) {
        self.id = id
    }
}

extension GetTagFollowing: QiitaRequestToken {
    
    public typealias Response = ()
    public typealias SerializedObject = Any

    public var method: HTTPMethod {
        return .GET
    }

    public var path: String {
        return "/api/v2/tags/\(id)/following"
    }
}
