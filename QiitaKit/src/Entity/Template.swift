//
//  Template.swift
//  QiitaKit
//
//  Created on 2015/06/08.
//  Copyright (c) 2015年 林達也. All rights reserved.
//

import Foundation

/**
*  投稿のひな形に利用できるテンプレートを表します。Qiita:Teamでのみ有効です。
*/
public struct Template {
    public typealias Identifier = Int
    
    /// テンプレートの本文
    /// example: Weekly MTG on %{Year}/%{month}/%{day}
    public let body: String

    /// テンプレートの一意なID
    /// example: 1
    public let id: Identifier

    /// テンプレートを判別するための名前
    /// example: Weekly MTG
    public let name: String

    /// 変数を展開した状態の本文
    /// example: Weekly MTG on 2000/01/01
    public let expanded_body: String

    /// 変数を展開した状態のタグ一覧
    /// example: [{"name"=>"MTG/2000/01/01", "versions"=>["0.0.1"]}]
    public let expanded_tags: Array<Tagging>

    /// 変数を展開した状態のタイトル
    /// example: Weekly MTG on 2015/06/03
    public let expanded_title: String

    /// タグ一覧
    /// example: [{"name"=>"MTG/%{Year}/%{month}/%{day}", "versions"=>["0.0.1"]}]
    public let tags: Array<Tagging>

    /// 生成される投稿のタイトルの雛形
    /// example: Weekly MTG on %{Year}/%{month}/%{day}
    public let title: String

}
