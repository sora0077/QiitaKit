//
//  ListItemComments.swift
//  QiitaKit
//
//  Created on 2015/06/08.
//  Copyright (c) 2015年 林達也. All rights reserved.
//

import Foundation
import APIKit

/**
*  投稿に付けられたコメント一覧を投稿日時の降順で取得します。
*/
public struct ListItemComments {
    
    public let item_id: String
    
    public init(item_id: String) {
        self.item_id = item_id
    }
}

extension ListItemComments: RequestToken {

    public typealias Response = ([Comment], LinkMeta<ListItemComments>)
    public typealias SerializedType = [[String: AnyObject]]

    public var method: HTTPMethod {
        return .GET
    }

    public var URL: String {
        return "/api/v2/items/\(item_id)/comments"
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

extension ListItemComments: LinkProtocol {
    
    public init!(url: NSURL!) {
        
        self.item_id = url.pathComponents?[url.pathComponents!.count - 2] as! String
    }
}

extension ListItemComments {
    
    public static func transform(request: NSURLRequest, response: NSHTTPURLResponse?, object: SerializedType) -> Result<Response> {
        
        return Result(_Comments(object), LinkMeta<ListItemComments>(dict: response!.allHeaderFields))
    }
}
