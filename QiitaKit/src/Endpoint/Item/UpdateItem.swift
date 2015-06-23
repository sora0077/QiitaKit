//
//  UpdateItem.swift
//  QiitaKit
//
//  Created on 2015/06/08.
//  Copyright (c) 2015年 林達也. All rights reserved.
//

import Foundation
import APIKit

/**
*  投稿を更新します。
*/
public struct UpdateItem {
    
    public let item_id: String
    /// Markdown形式の本文
    /// example: # Example
    /// 
    public let body: String

    /// この投稿が共同更新状態かどうか (Qiita:Teamでのみ有効)
    /// 
    public let coediting: Bool

    /// 限定共有状態かどうかを表すフラグ (Qiita:Teamでは無効)
    /// 
    public let `private`: Bool

    /// 投稿に付いたタグ一覧
    /// example: [{"name"=>"Ruby", "versions"=>["0.0.1"]}]
    /// 
    public let tags: Array<Tagging>

    /// 投稿のタイトル
    /// example: Example title
    /// 
    public let title: String

    public init(item_id: String, body: String, coediting: Bool, `private`: Bool, tags: Array<Tagging>, title: String) {
        self.item_id = item_id
        self.body = body
        self.coediting = coediting
        self.`private` = `private`
        self.tags = tags
        self.title = title
    }
}

extension UpdateItem: RequestToken {
    
    public typealias Response = Item
    public typealias SerializedType = [String: AnyObject]

    public var method: HTTPMethod {
        return .PATCH
    }

    public var URL: String {
        return "/api/v2/items/\(item_id)"
    }

    public var headers: [String: AnyObject]? {
        return nil
    }

    public var parameters: [String: AnyObject]? {
        return [
            "body": body,
            "coediting": coediting,
            "private": `private`,
            "tags": tags.map({ ["name": $0.name, "versions": $0.versions] }),
            "title": title
        ]
    }

    public var encoding: RequestEncoding {
        return .JSON
    }

    public var resonseEncoding: ResponseEncoding {
        return .JSON(.AllowFragments)
    }
}

extension UpdateItem {
    
    public static func transform(request: NSURLRequest, response: NSHTTPURLResponse?, object: SerializedType) -> Result<Response> {
        
        return Result(_Item(object))
    }
}
