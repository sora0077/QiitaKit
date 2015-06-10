//
//  ExpandedTemplate.swift
//  QiitaKit
//
//  Created on 2015/06/08.
//  Copyright (c) 2015年 林達也. All rights reserved.
//

import Foundation

/**
*  テンプレートを保存する前に変数展開後の状態をプレビューできます。Qiita:Teamでのみ有効です。
*/
public struct ExpandedTemplate {
    /// 変数を展開した状態の本文
    /// example: Weekly MTG on 2000/01/01
    public let expanded_body: String

    /// 変数を展開した状態のタグ一覧
    /// example: [{"name"=>"MTG/2000/01/01", "versions"=>["0.0.1"]}]
    public let expanded_tags: Array<Tagging>

    /// 変数を展開した状態のタイトル
    /// example: Weekly MTG on 2015/06/03
    public let expanded_title: String

}
