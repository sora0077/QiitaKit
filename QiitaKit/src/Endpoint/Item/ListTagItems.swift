//
//  ListTagItems.swift
//  QiitaKit
//
//  Created on 2015/06/08.
//  Copyright (c) 2015年 林達也. All rights reserved.
//

import Foundation
import APIKit
import Result

/**
*  指定されたタグが付けられた投稿一覧を、タグを付けた日時の降順で返します。
*/
public struct ListTagItems {
    
    public let id: String
    /// ページ番号 (1から100まで)
    /// example: 1
    /// ^[0-9]+$
    public let page: String

    /// 1ページあたりに含まれる要素数 (1から100まで)
    /// example: 20
    /// ^[0-9]+$
    public let per_page: String

    public init(id: String, page: String, per_page: String) {
        self.id = id
        self.page = page
        self.per_page = per_page
    }
}

extension ListTagItems: RequestToken {
    
    public typealias Response = ([Item], LinkMeta<ListTagItems>)
    public typealias SerializedType = [[String: AnyObject]]

    public var method: HTTPMethod {
        return .GET
    }

    public var URL: String {
        return "/api/v2/tags/\(id)/items"
    }

    public var parameters: [String: AnyObject]? {
        return [
            "page": page,
            "per_page": per_page
        ]
    }
}

extension ListTagItems: LinkProtocol {
    
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

extension ListTagItems {
    
    public static func transform(request: NSURLRequest, response: NSHTTPURLResponse?, object: SerializedType) -> Response {
        
        return (_Items(object), LinkMeta<ListTagItems>(dict: response!.allHeaderFields))
    }
}
