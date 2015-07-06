//
//  ListItemStockers.swift
//  QiitaKit
//
//  Created on 2015/06/08.
//  Copyright (c) 2015年 林達也. All rights reserved.
//

import Foundation
import APIKit

/**
*  投稿をストックしているユーザ一覧を、ストックした日時の降順で返します。
*/
public struct ListItemStockers {
    
    public let item_id: String
    /// ページ番号 (1から100まで)
    /// example: 1
    /// ^[0-9]+$
    public let page: String

    /// 1ページあたりに含まれる要素数 (1から100まで)
    /// example: 20
    /// ^[0-9]+$
    public let per_page: String

    public init(item_id: String, page: String, per_page: String) {
        self.item_id = item_id
        self.page = page
        self.per_page = per_page
    }
}

extension ListItemStockers: RequestToken {
    
    public typealias Response = ([User], LinkMeta<ListItemStockers>)
    public typealias SerializedType = [[String: AnyObject]]

    public var method: HTTPMethod {
        return .GET
    }

    public var URL: String {
        return "/api/v2/items/\(item_id)/stockers"
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
        return .URL
    }

    public var resonseEncoding: ResponseEncoding {
        return .JSON(.AllowFragments)
    }
}

extension ListItemStockers: LinkProtocol {
    
    public init(url: NSURL!) {
        
        let component = NSURLComponents(URL: url, resolvingAgainstBaseURL: false)
        var query: [String: String] = [:]
        for i in component?.queryItems as! [NSURLQueryItem] {
            query[i.name] = i.value
        }
        self.page = query["page"]!
        self.per_page = query["per_page"]!
        
        self.item_id = url.pathComponents?[url.pathComponents!.count - 2] as! String
    }
}

extension ListItemStockers {
    
    public static func transform(request: NSURLRequest, response: NSHTTPURLResponse?, object: SerializedType) -> Result<Response> {
        
        return Result(_Users(object), LinkMeta<ListItemStockers>(dict: response!.allHeaderFields))
    }
}
