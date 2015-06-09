//
//  CreateTagging.swift
//  QiitaKit
//
//  Created on 2015/06/08.
//  Copyright (c) 2015年 林達也. All rights reserved.
//

import Foundation
import APIKit

/**
*  投稿にタグを追加します。Qiita:Teamでのみ有効です。
*/
public class CreateTagging {
    /// タグを特定するための一意な名前
    /// example: qiita
    /// 
    public let name: String

    /// 
    /// example: ["0.0.1"]
    /// 
    public let versions: Array<String>

    public init(name: String, versions: Array<String>) {
        self.name = name
        self.versions = versions
    }
}
