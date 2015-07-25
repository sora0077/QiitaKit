//
//  ListUserFollowingTags.swift
//  QiitaKit
//
//  Created on 2015/06/08.
//  Copyright (c) 2015年 林達也. All rights reserved.
//

import Foundation
import APIKit
import Result

/**
*  ユーザがフォローしているタグ一覧をフォロー日時の降順で返します。
*/
public struct ListUserFollowingTags {
    
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

extension ListUserFollowingTags: RequestToken {
    
    public typealias Response = ([Tag], LinkMeta<ListUserFollowingTags>)
    public typealias SerializedType = [[String: AnyObject]]

    public var method: HTTPMethod {
        return .GET
    }

    public var URL: String {
        return "/api/v2/users/\(user_id)/following_tags"
    }

    public var parameters: [String: AnyObject]? {
        return [
            "page": page,
            "per_page": per_page
        ]
    }
    
    public var resonseEncoding: ResponseEncoding {
        return .JSON(.AllowFragments)
    }
}

extension ListUserFollowingTags: LinkProtocol {
    
    public init(url: NSURL!) {
        
        let component = NSURLComponents(URL: url, resolvingAgainstBaseURL: false)
        var query: [String: String] = [:]
        for i in component?.queryItems ?? [] {
            query[i.name] = i.value
        }
        self.page = query["page"]!
        self.per_page = query["per_page"]!
        
        self.user_id = url.pathComponents![url.pathComponents!.count - 2]
    }
}

extension ListUserFollowingTags {
    
    public static func transform(request: NSURLRequest, response: NSHTTPURLResponse?, object: SerializedType) -> Response {
        
        let tags = object.map { object in
            Tag(
                followers_count: object["followers_count"] as! Int,
                icon_url: object["icon_url"] as? String,
                id: object["id"] as! String,
                items_count: object["items_count"] as! Int
            )
        }
        return (tags, LinkMeta<ListUserFollowingTags>(dict: response!.allHeaderFields))
    }
}
