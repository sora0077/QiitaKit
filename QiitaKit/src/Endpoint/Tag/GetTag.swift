//
//  GetTag.swift
//  QiitaKit
//
//  Created on 2015/06/08.
//  Copyright (c) 2015年 林達也. All rights reserved.
//

import Foundation
import APIKit
import Result

/**
*  タグを取得します。
*/
public struct GetTag {
    
    public let id: Tag.Identifier
    
    public init(id: Tag.Identifier) {
        self.id = id
    }
}

extension GetTag: QiitaRequestToken {
    
    public typealias Response = Tag
    public typealias SerializedObject = [String: AnyObject]

    public var method: HTTPMethod {
        return .GET
    }

    public var path: String {
        return "/api/v2/tags/\(id)"
    }
}

public extension GetTag {
    
    func transform(request: NSURLRequest?, response: NSHTTPURLResponse?, object: SerializedObject) throws -> Response {
        
        let tag = Tag(
            followers_count: object["followers_count"] as! Int,
            icon_url: object["icon_url"] as? String,
            id: object["id"] as! String,
            items_count: object["items_count"] as! Int
        )
        return tag
    }
}
