//
//  Item.swift
//  QiitaKit
//
//  Created on 2015/06/08.
//  Copyright (c) 2015年 林達也. All rights reserved.
//

import Foundation

/**
*  ユーザからの投稿を表します。
*/
public struct Item {
    public typealias Identifier = String
    
    /// HTML形式の本文
    /// example: <h1>Example</h1>
    public let rendered_body: String

    /// Markdown形式の本文
    /// example: # Example
    public let body: String

    /// この投稿が共同更新状態かどうか (Qiita:Teamでのみ有効)
    public let coediting: Bool

    /// データが作成された日時
    /// example: 2000-01-01T00:00:00+00:00
    public let created_at: String

    /// 投稿の一意なID
    /// example: 4bd431809afb1bb99e4f
    public let id: Identifier

    /// 限定共有状態かどうかを表すフラグ (Qiita:Teamでは無効)
    public let `private`: Bool

    /// 投稿に付いたタグ一覧
    /// example: [{"name"=>"Ruby", "versions"=>["0.0.1"]}]
    public let tags: Array<Tagging>

    /// 投稿のタイトル
    /// example: Example title
    public let title: String

    /// データが最後に更新された日時
    /// example: 2000-01-01T00:00:00+00:00
    public let updated_at: String

    /// 投稿のURL
    /// example: https://qiita.com/yaotti/items/4bd431809afb1bb99e4f
    public let url: String

    /// Qiita上のユーザを表します。
    public let user: User

}
