//
//  Comment.swift
//  QiitaKit
//
//  Created on 2015/06/08.
//  Copyright (c) 2015年 林達也. All rights reserved.
//

import Foundation

/**
*  投稿に付けられたコメントを表します。
*/
public struct Comment {
    /// コメントの内容を表すMarkdown形式の文字列
    /// example: # Example
    public let body: String

    /// データが作成された日時
    /// example: 2000-01-01T00:00:00+00:00
    public let created_at: String

    /// コメントの一意なID
    /// example: 3391f50c35f953abfc4f
    public let id: String

    /// コメントの内容を表すHTML形式の文字列
    /// example: <h1>Example</h1>
    public let rendered_body: String

    /// データが最後に更新された日時
    /// example: 2000-01-01T00:00:00+00:00
    public let updated_at: String

    /// Qiita上のユーザを表します。
    public let user: User

}
