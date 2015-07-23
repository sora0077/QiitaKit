//
//  ListUserStocks.swift
//  QiitaKit
//
//  Created on 2015/06/08.
//  Copyright (c) 2015年 林達也. All rights reserved.
//

import Foundation
import APIKit
import Result

/**
*  指定されたユーザがストックした投稿一覧を、ストックした日時の降順で返します。
*/
public struct ListUserStocks {
    
    public let user_id: String
    /// ページ番号 (1から100まで)
    /// example: 1
    /// ^[0-9]+$
    public let page: String

    /// 1ページあたりに含まれる要素数 (1から100まで)
    /// example: 20
    /// ^[0-9]+$
    public let per_page: String

    public init(user_id: String, page: String, per_page: String) {
        self.user_id = user_id
        self.page = page
        self.per_page = per_page
    }
}

extension ListUserStocks: RequestToken {
    
    public typealias Response = ([Item], LinkMeta<ListUserStocks>)
    public typealias SerializedType = [[String: AnyObject]]

    public var method: HTTPMethod {
        return .GET
    }

    public var URL: String {
        return "/api/v2/users/\(user_id)/stocks"
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

extension ListUserStocks: LinkProtocol {
    
    public init(url: NSURL!) {
        
        let component = NSURLComponents(URL: url, resolvingAgainstBaseURL: false)
        var query: [String: String] = [:]
        for i in component?.queryItems as! [NSURLQueryItem] {
            query[i.name] = i.value
        }
        self.page = query["page"]!
        self.per_page = query["per_page"]!
        
        self.user_id = url.pathComponents?[url.pathComponents!.count - 2] as! String
    }
}

extension ListUserStocks {
    
    public static func transform(request: NSURLRequest, response: NSHTTPURLResponse?, object: SerializedType) -> Result<Response, NSError> {
        
        return Result(_Items(object), LinkMeta<ListUserStocks>(dict: response!.allHeaderFields))
    }
}
