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
    
    public let id: Tag.Identifier
    
    /// ページ番号 (1から100まで)
    /// example: 1
    /// ^[0-9]+$
    public let page: Int

    /// 1ページあたりに含まれる要素数 (1から100まで)
    /// example: 20
    /// ^[0-9]+$
    public let per_page: Int

    public init(id: Tag.Identifier, page: Int, per_page: Int = 20) {
        self.id = id
        self.page = page
        self.per_page = per_page
    }
}

extension ListUserFollowingTags: QiitaRequestToken {
    
    public typealias Response = ([Tag], LinkMeta<ListUserFollowingTags>)
    public typealias SerializedObject = [[String: AnyObject]]

    public var method: HTTPMethod {
        return .GET
    }

    public var path: String {
        return "/api/v2/users/\(id)/following_tags"
    }

    public var parameters: [String: AnyObject]? {
        return [
            "page": page,
            "per_page": per_page
        ]
    }
}

extension ListUserFollowingTags: LinkProtocol {
    
    public init(url: NSURL!) {
        
        let comps = NSURLComponents(URL: url, resolvingAgainstBaseURL: false)
        self.page = Int(find(comps?.queryItems ?? [], name: "page")!.value!)!
        
        if let value = find(comps?.queryItems ?? [], name: "per_page")?.value,
            let per_page = Int(value)
        {
            self.per_page = per_page
        } else {
            self.per_page = 20
        }
        
        self.id = url.pathComponents![url.pathComponents!.count - 2]
    }
}

public extension ListUserFollowingTags {
    
    public func transform(request: NSURLRequest?, response: NSHTTPURLResponse?, object: SerializedObject) throws -> Response {
        
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
