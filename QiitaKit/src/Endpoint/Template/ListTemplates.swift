//
//  ListTemplates.swift
//  QiitaKit
//
//  Created on 2015/06/08.
//  Copyright (c) 2015年 林達也. All rights reserved.
//

import Foundation
import APIKit

/**
*  チーム内のテンプレート一覧を返します。
*/
public class ListTemplates {
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

extension ListTemplates: RequestToken {
    
    public typealias Response = [Template]
    public typealias SerializedType = [[String: AnyObject]]

    public var method: HTTPMethod {
        return .GET
    }

    public var URL: String {
        return "/api/v2/templates"
    }

    public var headers: [String: AnyObject]? {
        return nil
    }

    public var parameters: [String: AnyObject]? {
        return [
            "page": page,
            "per_page": per_page
        ]
    }

    public var encoding: RequestEncoding {
        return .JSON
    }

    public var resonseEncoding: ResponseEncoding {
        return .JSON(.AllowFragments)
    }
}

extension ListTemplates {
    
    public static func transform(request: NSURLRequest, response: NSHTTPURLResponse?, object: SerializedType) -> Result<Response> {
        
        let templates = object.map { object -> Template in
            
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
            return template
        }
        return Result(templates)
    }
}
