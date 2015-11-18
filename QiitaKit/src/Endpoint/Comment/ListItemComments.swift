//
//  ListItemComments.swift
//  QiitaKit
//
//  Created on 2015/06/08.
//  Copyright (c) 2015年 林達也. All rights reserved.
//

import Foundation
import APIKit
import Result

/**
*  投稿に付けられたコメント一覧を投稿日時の降順で取得します。
*/
public struct ListItemComments {
    
    public let id: Item.Identifier
    
    public init(id: Item.Identifier) {
        self.id = id
    }
}

extension ListItemComments: QiitaRequestToken {

    public typealias Response = ([Comment], LinkMeta<ListItemComments>)
    public typealias SerializedObject = [[String: AnyObject]]

    public var method: HTTPMethod {
        return .GET
    }

    public var path: String {
        return "/api/v2/items/\(id)/comments"
    }
}

extension ListItemComments: LinkProtocol {
    
    public init!(url: NSURL!) {
        
        self.id = url.pathComponents![url.pathComponents!.count - 2]
    }
}

extension ListItemComments {
    
    public func transform(request: NSURLRequest?, response: NSHTTPURLResponse?, object: SerializedObject) throws -> Response {
        
        return (try _Comments(object), LinkMeta<ListItemComments>(dict: response!.allHeaderFields))
    }
}
