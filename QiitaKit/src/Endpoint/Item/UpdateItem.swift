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
public class UpdateItem {
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
    public let tags: Array<Dictionary<String, AnyObject>>

    /// 投稿のタイトル
    /// example: Example title
    /// 
    public let title: String

    public init(body: String, coediting: Bool, `private`: Bool, tags: Array<Dictionary<String, AnyObject>>, title: String) {
        self.body = body
        self.coediting = coediting
        self.`private` = `private`
        self.tags = tags
        self.title = title
    }
}
