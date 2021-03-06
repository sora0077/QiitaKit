//
//  CreateExpandedTemplate.swift
//  QiitaKit
//
//  Created on 2015/06/08.
//  Copyright (c) 2015年 林達也. All rights reserved.
//

import Foundation
import APIKit

/**
*  受け取ったテンプレート用文字列の変数を展開して返します。
*/
public struct CreateExpandedTemplate {
    /// テンプレートの本文
    /// example: Weekly MTG on %{Year}/%{month}/%{day}
    /// 
    public let body: String

    /// タグ一覧
    /// example: [{"name"=>"MTG/%{Year}/%{month}/%{day}", "versions"=>["0.0.1"]}]
    /// 
    public let tags: Array<Tagging>

    /// 生成される投稿のタイトルの雛形
    /// example: Weekly MTG on %{Year}/%{month}/%{day}
    /// 
    public let title: String

    public init(body: String, tags: Array<Tagging>, title: String) {
        self.body = body
        self.tags = tags
        self.title = title
    }
}

extension CreateExpandedTemplate: QiitaRequestToken {

    public typealias Response = ExpandedTemplate
    public typealias SerializedObject = [String: AnyObject]

    public var method: HTTPMethod {
        return .POST
    }

    public var path: String {
        return "/api/v2/expanded_templates"
    }
    
    public var parameters: [String: AnyObject]? {
        return [
            "body": body,
            "tags": tags.map({ ["name": $0.name, "versions": $0.versions] }),
            "title": title
        ]
    }

    public var encoding: RequestEncoding {
        return .JSON
    }
}

public extension CreateExpandedTemplate {
    
    func transform(request: NSURLRequest?, response: NSHTTPURLResponse?, object: SerializedObject) throws -> Response {
        
        return _ExpandedTemplate(object)
    }
}
