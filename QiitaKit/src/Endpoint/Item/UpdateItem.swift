//
//  UpdateItem.swift
//  QiitaKit
//
//  Created on 2015/06/08.
//  Copyright (c) 2015年 林達也. All rights reserved.
//

import Foundation
import APIKit
import Result

/**
*  投稿を更新します。
*/
public struct UpdateItem {
    
    public let id: Item.Identifier
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

    public init(id: Item.Identifier, body: String, coediting: Bool, `private`: Bool, tags: Array<Tagging>, title: String) {
        self.id = id
        self.body = body
        self.coediting = coediting
        self.`private` = `private`
        self.tags = tags
        self.title = title
    }
}

extension UpdateItem: QiitaRequestToken {
    
    public typealias Response = Item
    public typealias SerializedObject = [String: AnyObject]

    public var method: HTTPMethod {
        return .PATCH
    }

    public var path: String {
        return "/api/v2/items/\(id)"
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
}
