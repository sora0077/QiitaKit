//
//  DeleteTemplate.swift
//  QiitaKit
//
//  Created on 2015/06/08.
//  Copyright (c) 2015年 林達也. All rights reserved.
//

import Foundation
import APIKit

/**
*  テンプレートを削除します。
*/
public class DeleteTemplate {
    public init() {
    }
}

extension DeleteTemplate: RequestToken {
    
    public typealias Response = Template
    public typealias SerializedType = [String: AnyObject]

    public var method: HTTPMethod {
        return .DELETE
    }

    public var URL: String {
        return "/api/v2/templates/:template_id"
    }

    public var headers: [String: AnyObject]? {
        return nil
    }

    public var parameters: [String: AnyObject]? {
        return nil
    }

    public var encoding: RequestEncoding {
        return .URL
    }

    public var resonseEncoding: ResponseEncoding {
        return .JSON(.AllowFragments)
    }
}

extension DeleteTemplate {
    
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
