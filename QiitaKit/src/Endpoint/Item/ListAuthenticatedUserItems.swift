//
//  ListAuthenticatedUserItems.swift
//  QiitaKit
//
//  Created on 2015/06/08.
//  Copyright (c) 2015年 林達也. All rights reserved.
//

import Foundation
import APIKit
import Result

/**
*  認証中のユーザの投稿の一覧を作成日時の降順で返します。
*/
public struct ListAuthenticatedUserItems {
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

extension ListAuthenticatedUserItems: RequestToken {
    
    public typealias Response = ([Item], LinkMeta<ListAuthenticatedUserItems>)
    public typealias SerializedType = [[String: AnyObject]]

    public var method: HTTPMethod {
        return .GET
    }

    public var URL: String {
        return "/api/v2/authenticated_user/items"
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

extension ListAuthenticatedUserItems: LinkProtocol {
    
    public init!(url: NSURL!) {
        
        let component = NSURLComponents(URL: url, resolvingAgainstBaseURL: false)
        var query: [String: String] = [:]
        for i in component?.queryItems as! [NSURLQueryItem] {
            query[i.name] = i.value
        }
        self.page = query["page"]!
        self.per_page = query["per_page"]!
    }
}

extension ListAuthenticatedUserItems {
    
    public static func transform(request: NSURLRequest, response: NSHTTPURLResponse?, object: SerializedType) -> Result<Response, NSError> {
        
        return Result(_Items(object), LinkMeta<ListAuthenticatedUserItems>(dict: response!.allHeaderFields))
    }
}
