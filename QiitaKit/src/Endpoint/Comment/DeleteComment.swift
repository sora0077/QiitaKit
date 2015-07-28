//
//  DeleteComment.swift
//  QiitaKit
//
//  Created on 2015/06/08.
//  Copyright (c) 2015年 林達也. All rights reserved.
//

import Foundation
import APIKit
import Result

/**
*  コメントを削除します。
*/
public struct DeleteComment {
    
    public let id: String
    
    public init(id: Comment.Identifier) {
        self.id = id
    }
}

extension DeleteComment: RequestToken {

    public typealias Response = ()
    public typealias SerializedType = Any

    public var method: HTTPMethod {
        return .DELETE
    }

    public var URL: String {
        return "/api/v2/comments/\(id)"
    }
}
