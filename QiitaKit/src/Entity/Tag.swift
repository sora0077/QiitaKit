//
//  Tag.swift
//  QiitaKit
//
//  Created on 2015/06/08.
//  Copyright (c) 2015年 林達也. All rights reserved.
//

import Foundation

/**
*  投稿に付けられた個々のタグを表します。
*/
public struct Tag {
    /// このタグをフォローしているユーザの数
    /// example: 100
    public let followers_count: Int

    /// このタグに設定されたアイコン画像のURL
    /// example: https://s3-ap-northeast-1.amazonaws.com/qiita-tag-image/9de6a11d330f5694820082438f88ccf4a1b289b2/medium.jpg
    public let icon_url: String?

    /// タグを特定するための一意な名前
    /// example: qiita
    public let id: String

    /// このタグが付けられた投稿の数
    /// example: 200
    public let items_count: Int

}
