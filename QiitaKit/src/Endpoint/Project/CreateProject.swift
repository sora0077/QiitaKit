//
//  CreateProject.swift
//  QiitaKit
//
//  Created on 2015/06/08.
//  Copyright (c) 2015年 林達也. All rights reserved.
//

import Foundation
import APIKit

/**
*  プロジェクトを新たに作成します。
*/
public class CreateProject {
    /// このプロジェクトが進行中かどうか
    /// 
    public let archived: Bool

    /// Markdown形式の本文
    /// example: # Example
    /// 
    public let body: String

    /// プロジェクト名
    /// example: Kobiro Project
    /// 
    public let name: String

    /// 投稿に付いたタグ一覧
    /// example: [{"name"=>"Ruby", "versions"=>["0.0.1"]}]
    /// 
    public let tags: Array<Dictionary<String, AnyObject>>

    public init(archived: Bool, body: String, name: String, tags: Array<Dictionary<String, AnyObject>>) {
        self.archived = archived
        self.body = body
        self.name = name
        self.tags = tags
    }
}
