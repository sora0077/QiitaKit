//
//  ListTagItems.swift
//  QiitaKit
//
//  Created on 2015/06/08.
//  Copyright (c) 2015年 林達也. All rights reserved.
//

import Foundation
import APIKit

/**
*  指定されたタグが付けられた投稿一覧を、タグを付けた日時の降順で返します。
*/
public class ListTagItems {
    /// ページ番号 (1から100まで)
    /// example: 1
    /// ^[0-9]+$
    public let page: String

    /// 1ページあたりに含まれる要素数 (1から100まで)
    /// example: 20
    /// ^[0-9]+$
    public let per_page: String

    public init(page: String, per_page: String) {
        self.page = page
        self.per_page = per_page
    }
}