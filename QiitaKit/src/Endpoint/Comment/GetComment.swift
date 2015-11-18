//
//  GetComment.swift
//  QiitaKit
//
//  Created on 2015/06/08.
//  Copyright (c) 2015年 林達也. All rights reserved.
//

import Foundation
import APIKit
import Result

/**
*  コメントを取得します。
*/
public struct GetComment {
    
    public let id: Comment.Identifier
    
    public init(id: Comment.Identifier) {
        self.id = id
    }
}

extension GetComment: QiitaRequestToken {
    
    public typealias Response = Comment
    public typealias SerializedObject = [String: AnyObject]

    public var method: HTTPMethod {
        return .GET
    }

    public var path: String {
        return "/api/v2/comments/\(id)"
    }
}
