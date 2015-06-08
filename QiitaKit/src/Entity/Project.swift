//
//  Project.swift
//  QiitaKit
//
//  Created on 2015/06/08.
//  Copyright (c) 2015年 林達也. All rights reserved.
//

import Foundation

/**
*  Qiita:Team上でのプロジェクトを表します。Qiita:Teamでのみ有効です。
*/
public struct Project {
    /// HTML形式の本文
    /// example: <h1>Example</h1>
    public let rendered_body: String

    /// このプロジェクトが進行中かどうか
    public let archived: Bool

    /// Markdown形式の本文
    /// example: # Example
    public let body: String

    /// データが作成された日時
    /// example: 2000-01-01T00:00:00+00:00
    public let created_at: String

    /// プロジェクトのチーム上での一意なID
    /// example: 1
    public let id: Int

    /// プロジェクト名
    /// example: Kobiro Project
    public let name: String

    /// データが最後に更新された日時
    /// example: 2000-01-01T00:00:00+00:00
    public let updated_at: String

}
