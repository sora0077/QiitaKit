//
//  UnfollowTag.swift
//  QiitaKit
//
//  Created on 2015/06/08.
//  Copyright (c) 2015年 林達也. All rights reserved.
//

import Foundation
import APIKit
import Result

/**
*  タグのフォローを外します。
*/
public struct UnfollowTag {
    
    public let id: Tag.Identifier
    
    public init(id: Tag.Identifier) {
        self.id = id
    }
}

extension UnfollowTag: RequestToken {
    
    public typealias Response = ()
    public typealias SerializedType = Any

    public var method: HTTPMethod {
        return .DELETE
    }

    public var URL: String {
        return "/api/v2/tags/\(id)/following"
    }
}
