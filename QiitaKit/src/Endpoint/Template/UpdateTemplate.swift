//
//  UpdateTemplate.swift
//  QiitaKit
//
//  Created on 2015/06/08.
//  Copyright (c) 2015年 林達也. All rights reserved.
//

import Foundation
import APIKit
import Result

/**
*  テンプレートを更新します。
*/
public struct UpdateTemplate {
    
    public let id: Template.Identifier
    /// テンプレートの本文
    /// example: Weekly MTG on %{Year}/%{month}/%{day}
    /// 
    public let body: String

    /// テンプレートを判別するための名前
    /// example: Weekly MTG
    /// 
    public let name: String

    /// タグ一覧
    /// example: [{"name"=>"MTG/%{Year}/%{month}/%{day}", "versions"=>["0.0.1"]}]
    /// 
    public let tags: Array<Tagging>

    /// 生成される投稿のタイトルの雛形
    /// example: Weekly MTG on %{Year}/%{month}/%{day}
    /// 
    public let title: String

    public init(id: Template.Identifier, body: String, name: String, tags: Array<Tagging>, title: String) {
        self.id = id
        self.body = body
        self.name = name
        self.tags = tags
        self.title = title
    }
}

extension UpdateTemplate: QiitaRequestToken {
    
    public typealias Response = Template
    public typealias SerializedObject = [String: AnyObject]

    public var method: HTTPMethod {
        return .PATCH
    }

    public var path: String {
        return "/api/v2/templates/\(id)"
    }

    public var parameters: [String: AnyObject]? {
        return [
            "body": body,
            "name": name,
            "tags": tags.map({ ["name": $0.name, "versions": $0.versions] }),
            "title": title
        ]
    }

    public var encoding: RequestEncoding {
        return .JSON
    }
}

public extension UpdateTemplate {
    
    func transform(request: NSURLRequest?, response: NSHTTPURLResponse?, object: SerializedObject) throws -> Response {
        
        return _Template(object)
    }
}
