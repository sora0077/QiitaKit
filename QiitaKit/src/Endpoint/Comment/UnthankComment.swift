//
//  UnthankComment.swift
//  QiitaKit
//
//  Created on 2015/06/08.
//  Copyright (c) 2015年 林達也. All rights reserved.
//

import Foundation
import APIKit
import Result

/**
*  コメントからThankを外します。
*/
public struct UnthankComment {
    
    public let comment_id: String
    
    public init(comment_id: String) {
        self.comment_id = comment_id
    }
}

extension UnthankComment: RequestToken {
    
    public typealias Response = ()
    public typealias SerializedType = Any

    public var method: HTTPMethod {
        return .DELETE
    }

    public var URL: String {
        return "/api/v2/comments/\(comment_id)/thank"
    }
}
