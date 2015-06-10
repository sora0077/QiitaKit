//
//  UpdateItem.swift
//  QiitaKit
//
//  Created on 2015/06/08.
//  Copyright (c) 2015年 林達也. All rights reserved.
//

import Foundation
import APIKit

/**
*  投稿を更新します。
*/
public class UpdateItem {
    
    public let item_id: String
    /// Markdown形式の本文
    /// example: # Example
    /// 
    public let body: String

    /// この投稿が共同更新状態かどうか (Qiita:Teamでのみ有効)
    /// 
    public let coediting: Bool

    /// 限定共有状態かどうかを表すフラグ (Qiita:Teamでは無効)
    /// 
    public let `private`: Bool

    /// 投稿に付いたタグ一覧
    /// example: [{"name"=>"Ruby", "versions"=>["0.0.1"]}]
    /// 
    public let tags: Array<Tagging>

    /// 投稿のタイトル
    /// example: Example title
    /// 
    public let title: String

    public init(item_id: String, body: String, coediting: Bool, `private`: Bool, tags: Array<Tagging>, title: String) {
        self.item_id = item_id
        self.body = body
        self.coediting = coediting
        self.`private` = `private`
        self.tags = tags
        self.title = title
    }
}

extension UpdateItem: RequestToken {
    
    public typealias Response = Item
    public typealias SerializedType = [String: AnyObject]

    public var method: HTTPMethod {
        return .PATCH
    }

    public var URL: String {
        return "/api/v2/items/:item_id"
    }

    public var headers: [String: AnyObject]? {
        return nil
    }

    public var parameters: [String: AnyObject]? {
        return [
            "body": body,
            "coediting": coediting,
            "private": `private`,
            "tags": tags.map({ ["name": $0.name, "versions": $0.versions] }),
            "title": title
        ]
    }

    public var encoding: RequestEncoding {
        return .JSON
    }

    public var resonseEncoding: ResponseEncoding {
        return .JSON(.AllowFragments)
    }
}

extension UpdateItem {
    
    public static func transform(request: NSURLRequest, response: NSHTTPURLResponse?, object: SerializedType) -> Result<Response> {
        
        func _User(object: SerializedType) -> User {
            return User(
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
        }
        
        let user = _User(object["user"] as! SerializedType)
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
        return Result(item)
    }
}
