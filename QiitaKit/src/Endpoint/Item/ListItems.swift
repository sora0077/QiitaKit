//
//  ListItems.swift
//  QiitaKit
//
//  Created on 2015/06/08.
//  Copyright (c) 2015年 林達也. All rights reserved.
//

import Foundation
import APIKit

/**
*  投稿の一覧を作成日時の降順で返します。
*/
public class ListItems {
    /// ページ番号 (1から100まで)
    /// example: 1
    /// ^[0-9]+$
    public let page: String

    /// 1ページあたりに含まれる要素数 (1から100まで)
    /// example: 20
    /// ^[0-9]+$
    public let per_page: String

    /// 検索クエリ
    /// example: qiita user:yaotti
    /// 
    public let query: String

    public init(page: String, per_page: String, query: String) {
        self.page = page
        self.per_page = per_page
        self.query = query
    }
}
