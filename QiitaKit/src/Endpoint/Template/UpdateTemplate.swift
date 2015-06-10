//
//  UpdateTemplate.swift
//  QiitaKit
//
//  Created on 2015/06/08.
//  Copyright (c) 2015年 林達也. All rights reserved.
//

import Foundation
import APIKit

/**
*  テンプレートを更新します。
*/
public class UpdateTemplate {
    
    public let template_id: String
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

    public init(template_id: String, body: String, name: String, tags: Array<Tagging>, title: String) {
        self.template_id = template_id
        self.body = body
        self.name = name
        self.tags = tags
        self.title = title
    }
}

extension UpdateTemplate: RequestToken {
    
    public typealias Response = Template
    public typealias SerializedType = [String: AnyObject]

    public var method: HTTPMethod {
        return .PATCH
    }

    public var URL: String {
        return "/api/v2/templates/\(template_id)"
    }

    public var headers: [String: AnyObject]? {
        return nil
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

    public var resonseEncoding: ResponseEncoding {
        return .JSON(.AllowFragments)
    }
}

extension UpdateTemplate {
    
    public static func transform(request: NSURLRequest, response: NSHTTPURLResponse?, object: SerializedType) -> Result<Response> {
        
        let expanded_tags = object["expanded_tags"] as! [[String: AnyObject]]
        let tags = object["tags"] as! [[String: AnyObject]]
        let template = Template(
            body: object["body"] as! String,
            id: object["id"] as! Int,
            name: object["name"] as! String,
            expanded_body: object["expanded_body"] as! String,
            expanded_tags: expanded_tags.map({ Tagging(name: $0["name"] as! String, versions: $0["versions"] as! [String]) }),
            expanded_title: object["expanded_title"] as! String,
            tags: tags.map({ Tagging(name: $0["name"] as! String, versions: $0["versions"] as! [String]) }),
            title: object["title"] as! String
        )
        return Result(template)
    }
}
