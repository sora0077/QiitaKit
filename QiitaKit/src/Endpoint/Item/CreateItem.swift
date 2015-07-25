//
//  CreateItem.swift
//  QiitaKit
//
//  Created on 2015/06/08.
//  Copyright (c) 2015年 林達也. All rights reserved.
//

import Foundation
import APIKit

/**
*  新たに投稿を作成します。
*/
public struct CreateItem {
    /// Markdown形式の本文
    /// example: # Example
    /// 
    public let body: String

    /// この投稿が共同更新状態かどうか (Qiita:Teamでのみ有効)
    /// 
    public let coediting: Bool

    /// 本文中のコードをGistに投稿するかどうか (GitHub連携を有効化している場合のみ有効)
    /// 
    public let gist: Bool

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

    /// Twitterに投稿するかどうか (Twitter連携を有効化している場合のみ有効)
    /// 
    public let tweet: Bool

    public init(body: String, coediting: Bool, gist: Bool, `private`: Bool, tags: Array<Tagging>, title: String, tweet: Bool) {
        self.body = body
        self.coediting = coediting
        self.gist = gist
        self.`private` = `private`
        self.tags = tags
        self.title = title
        self.tweet = tweet
    }
}

extension CreateItem: RequestToken {

    public typealias Response = Item
    public typealias SerializedType = [String: AnyObject]

    public var method: HTTPMethod {
        return .POST
    }

    public var URL: String {
        return "/api/v2/items"
    }

    public var parameters: [String: AnyObject]? {
        return [
            "body": body,
            "coediting": coediting,
            "gist": gist,
            "private": `private`,
            "tags": tags.map({ ["name": $0.name, "versions": $0.versions] }),
            "title": title,
            "tweet": tweet
        ]
    }

    public var encoding: RequestEncoding {
        return .JSON
    }

    public var resonseEncoding: ResponseEncoding {
        return .JSON(.AllowFragments)
    }
}
