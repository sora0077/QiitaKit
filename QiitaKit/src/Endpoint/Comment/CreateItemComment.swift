//
//  CreateItemComment.swift
//  QiitaKit
//
//  Created on 2015/06/08.
//  Copyright (c) 2015年 林達也. All rights reserved.
//

import Foundation
import APIKit
import Result

/**
*  投稿に対してコメントを投稿します。
*/
public struct CreateItemComment {
    
    public let item_id: String
    /// コメントの内容を表すMarkdown形式の文字列
    /// example: # Example
    /// 
    public let body: String

    public init(item_id: String, body: String) {
        self.item_id = item_id
        self.body = body
    }
}

extension CreateItemComment: RequestToken {

    public typealias Response = Comment
    public typealias SerializedType = [String: AnyObject]

    public var method: HTTPMethod {
        return .POST
    }

    public var URL: String {
        return "/api/v2/items/\(item_id)/comments"
    }

    public var parameters: [String: AnyObject]? {
        return [
            "body": body
        ]
    }

    public var encoding: RequestEncoding {
        return .JSON
    }

    public var resonseEncoding: ResponseEncoding {
        return .JSON(.AllowFragments)
    }
}
