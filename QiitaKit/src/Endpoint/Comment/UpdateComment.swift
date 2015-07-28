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
    
    public let comment_id: String
    /// コメントの内容を表すMarkdown形式の文字列
    /// example: # Example
    /// 
    public let body: String

    public init(comment_id: String, body: String) {
        self.comment_id = comment_id
        self.body = body
    }
}

extension UpdateComment: RequestToken {
    
    public typealias Response = Comment
    public typealias SerializedType = [String: AnyObject]

    public var method: HTTPMethod {
        return .PATCH
    }

    public var URL: String {
        return "/api/v2/comments/\(comment_id)"
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
