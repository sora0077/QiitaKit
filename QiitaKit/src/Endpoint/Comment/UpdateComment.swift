//
//  UpdateComment.swift
//  QiitaKit
//
//  Created on 2015/06/08.
//  Copyright (c) 2015年 林達也. All rights reserved.
//

import Foundation
import APIKit
import Result

/**
*  コメントを更新します。
*/
public struct UpdateComment {
    
    public let id: Comment.Identifier
    /// コメントの内容を表すMarkdown形式の文字列
    /// example: # Example
    /// 
    public let body: String

    public init(id: Comment.Identifier, body: String) {
        self.id = id
        self.body = body
    }
}

extension UpdateComment: QiitaRequestToken {
    
    public typealias Response = Comment
    public typealias SerializedObject = [String: AnyObject]

    public var method: HTTPMethod {
        return .PATCH
    }

    public var path: String {
        return "/api/v2/comments/\(id)"
    }
    
    public var parameters: [String: AnyObject]? {
        return [
            "body": body
        ]
    }

    public var encoding: RequestEncoding {
        return .JSON
    }
}
