//
//  ListItemComments.swift
//  QiitaKit
//
//  Created on 2015/06/08.
//  Copyright (c) 2015年 林達也. All rights reserved.
//

import Foundation
import APIKit

/**
*  投稿に付けられたコメント一覧を投稿日時の降順で取得します。
*/
public struct ListItemComments {
    
    public let item_id: String
    
    public init(item_id: String) {
        self.item_id = item_id
    }
}

extension ListItemComments: RequestToken {

    public typealias Response = [Comment]
    public typealias SerializedType = [[String: AnyObject]]

    public var method: HTTPMethod {
        return .GET
    }

    public var URL: String {
        return "/api/v2/items/\(item_id)/comments"
    }

    public var headers: [String: AnyObject]? {
        return nil
    }

    public var parameters: [String: AnyObject]? {
        return nil
    }

    public var encoding: RequestEncoding {
        return .URL
    }

    public var resonseEncoding: ResponseEncoding {
        return .JSON(.AllowFragments)
    }
}

extension ListItemComments {
    
    public static func transform(request: NSURLRequest, response: NSHTTPURLResponse?, object: SerializedType) -> Result<Response> {
        
        func _User(object: GetUser.SerializedType) -> User {
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
        
        
        let comments = object.map { object -> Comment in
            
            let user = _User(object["user"] as! GetUser.SerializedType)
            let comment = Comment(
                body: object["body"] as! String,
                created_at: object["created_at"] as! String,
                id: object["id"] as! String,
                rendered_body: object["rendered_body"] as! String,
                updated_at: object["updated_at"] as! String,
                user: user
            )
            return comment
        }
        
        return Result(comments)
    }
}
