//
//  ListItems.swift
//  QiitaKit
//
//  Created on 2015/06/08.
//  Copyright (c) 2015年 林達也. All rights reserved.
//

import Foundation
import APIKit
import Result

/**
*  投稿の一覧を作成日時の降順で返します。
*/
public struct ListItems {
    /// ページ番号 (1から100まで)
    /// example: 1
    /// ^[0-9]+$
    public let page: String

    /// 1ページあたりに含まれる要素数 (1から100まで)
    /// example: 20
    /// ^[0-9]+$
    public let per_page: String

    /// 検索クエリ
    /// example: qiita user:yaotti
    /// 
    public let query: String

    public init(page: String, per_page: String, query: String) {
        self.page = page
        self.per_page = per_page
        self.query = query
    }
}

extension ListItems: QiitaRequestToken {
    
    public typealias Response = ([Item], LinkMeta<ListItems>)
    public typealias SerializedObject = [[String: AnyObject]]

    public var method: HTTPMethod {
        return .GET
    }

    public var path: String {
        return "/api/v2/items"
    }

    public var parameters: [String: AnyObject]? {
        return [
            "page": page,
            "per_page": per_page,
            "query": query,
        ]
    }
}

extension ListItems: LinkProtocol {
    
    public init(url: NSURL!) {
        
        let component = NSURLComponents(URL: url, resolvingAgainstBaseURL: false)
        var query: [String: String] = [:]
        for i in component?.queryItems ?? [] {
            query[i.name] = i.value
        }
        self.page = query["page"]!
        self.per_page = query["per_page"]!
        self.query = query["query"]!
    }
}

public extension ListItems {
    
    func transform(request: NSURLRequest?, response: NSHTTPURLResponse?, object: SerializedObject) throws -> Response {
        
        return (try _Items(object), LinkMeta<ListItems>(dict: response!.allHeaderFields))
    }
}
