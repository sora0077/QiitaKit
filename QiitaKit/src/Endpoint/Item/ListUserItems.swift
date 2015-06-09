//
//  ListUserItems.swift
//  QiitaKit
//
//  Created on 2015/06/08.
//  Copyright (c) 2015年 林達也. All rights reserved.
//

import Foundation
import APIKit

/**
*  指定されたユーザの投稿一覧を、作成日時の降順で返します。
*/
public class ListUserItems {
    
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

extension ListUserItems: RequestToken {
    
    public typealias Response = [Item]
    public typealias SerializedType = [[String: AnyObject]]

    public var method: HTTPMethod {
        return .GET
    }

    public var URL: String {
        return "/api/v2/users/\(user_id)/items"
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
        return .JSON
    }

    public var resonseEncoding: ResponseEncoding {
        return .JSON(.AllowFragments)
    }
}

extension ListUserItems {
    
    public static func transform(request: NSURLRequest, response: NSHTTPURLResponse?, object: SerializedType) -> Result<Response> {
        
        let items = object.map { object -> Item in
            
            let user = User(
                description: object["description"] as? String,
                facebook_id: object["facebook_id"] as? String,
                followees_count: object["followees_count"] as! Int,
                followers_count: object["followers_count"] as! Int,
                github_login_name: object["github_login_name"] as? String,
                id: object["id"] as! String,
                items_count: object["items_count"] as! Int,
                linkedin_id: object["linkedin_id"] as? String,
                location: object["location"] as? String,
                name: object["name"] as? String,
                organization: object["organization"] as? String,
                permanent_id: object["permanent_id"] as! Int,
                profile_image_url: object["profile_image_url"] as! String,
                twitter_screen_name: object["twitter_screen_name"] as? String,
                website_url: object["website_url"] as? String
            )
            
            let tags = object["tags"] as! [[String: AnyObject]]
            let item = Item(
                rendered_body: object["rendered_body"] as! String,
                body: object["body"] as! String,
                coediting: object["coediting"] as! Bool,
                created_at: object["created_at"] as! String,
                id: object["id"] as! String,
                `private`: object["private"] as! Bool,
                tags: tags.map({ Tagging(name: $0["name"] as! String, versions: $0["versions"] as! [String]) }),
                title: object["title"] as! String,
                updated_at: object["updated_at"] as! String,
                url: object["url"] as! String,
                user: user
            )
            return item
        }
        return Result(items)
    }
}
