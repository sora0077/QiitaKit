//
//  ListTags.swift
//  QiitaKit
//
//  Created on 2015/06/08.
//  Copyright (c) 2015年 林達也. All rights reserved.
//

import Foundation
import APIKit
import Result

/**
*  タグ一覧を作成日時の降順で返します。
*/
public struct ListTags {
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

extension ListTags: RequestToken {
    
    public typealias Response = ([Tag], LinkMeta<ListTags>)
    public typealias SerializedType = [[String: AnyObject]]

    public var method: HTTPMethod {
        return .GET
    }

    public var URL: String {
        return "/api/v2/tags"
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

extension ListTags: LinkProtocol {
    
    public init(url: NSURL!) {
        
        let component = NSURLComponents(URL: url, resolvingAgainstBaseURL: false)
        var query: [String: String] = [:]
        for i in component?.queryItems as! [NSURLQueryItem] {
            query[i.name] = i.value
        }
        self.page = query["page"]!
        self.per_page = query["per_page"]!
    }
}

extension ListTags {
    
    public static func transform(request: NSURLRequest, response: NSHTTPURLResponse?, object: SerializedType) -> Result<Response, NSError> {
        
        let tags = object.map { object in
            Tag(
                followers_count: object["followers_count"] as! Int,
                icon_url: object["icon_url"] as? String,
                id: object["id"] as! String,
                items_count: object["items_count"] as! Int
            )
        }
        return Result(tags, LinkMeta<ListTags>(dict: response!.allHeaderFields))
    }
}
