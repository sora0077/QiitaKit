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
    
    public let id: Item.Identifier
    /// コメントの内容を表すMarkdown形式の文字列
    /// example: # Example
    /// 
    public let body: String

    public init(id: Item.Identifier, body: String) {
        self.id = id
        self.body = body
    }
}

extension CreateItemComment: QiitaRequestToken {

    public typealias Response = Comment
    public typealias SerializedObject = [String: AnyObject]

    public var method: HTTPMethod {
        return .POST
    }

    public var path: String {
        return "/api/v2/items/\(id)/comments"
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
