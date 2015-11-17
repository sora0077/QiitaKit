//
//  ListItemStockers.swift
//  QiitaKit
//
//  Created on 2015/06/08.
//  Copyright (c) 2015年 林達也. All rights reserved.
//

import Foundation
import APIKit
import Result

/**
*  投稿をストックしているユーザ一覧を、ストックした日時の降順で返します。
*/
public struct ListItemStockers {
    
    public let id: Item.Identifier
    /// ページ番号 (1から100まで)
    /// example: 1
    /// ^[0-9]+$
    public let page: String

    /// 1ページあたりに含まれる要素数 (1から100まで)
    /// example: 20
    /// ^[0-9]+$
    public let per_page: String

    public init(id: Item.Identifier, page: String, per_page: String) {
        self.id = id
        self.page = page
        self.per_page = per_page
    }
}

extension ListItemStockers: RequestToken {
    
    public typealias Response = ([User], LinkMeta<ListItemStockers>)
    public typealias SerializedObject = [[String: AnyObject]]

    public var method: HTTPMethod {
        return .GET
    }

    public var path: String {
        return "/api/v2/items/\(id)/stockers"
    }

    public var parameters: [String: AnyObject]? {
        return [
            "page": page,
            "per_page": per_page
        ]
    }
}

extension ListItemStockers: LinkProtocol {
    
    public init(url: NSURL!) {
        
        let component = NSURLComponents(URL: url, resolvingAgainstBaseURL: false)
        var query: [String: String] = [:]
        for i in component?.queryItems ?? [] {
            query[i.name] = i.value
        }
        self.page = query["page"]!
        self.per_page = query["per_page"]!
        
        self.id = url.pathComponents![url.pathComponents!.count - 2]
    }
}

public extension ListItemStockers {
    
    func transform(request: NSURLRequest?, response: NSHTTPURLResponse?, object: SerializedObject) throws -> Response {
        
        return (try _Users(object), LinkMeta<ListItemStockers>(dict: response!.allHeaderFields))
    }
}
