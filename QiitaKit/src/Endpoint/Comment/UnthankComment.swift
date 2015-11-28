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
    
    public let id: Comment.Identifier
    
    public init(id: Comment.Identifier) {
        self.id = id
    }
}

extension UnthankComment: QiitaRequestToken {
    
    public typealias Response = ()
    public typealias SerializedObject = Any

    public var method: HTTPMethod {
        return .DELETE
    }

    public var path: String {
        return "/api/v2/comments/\(id)/thank"
    }
}
