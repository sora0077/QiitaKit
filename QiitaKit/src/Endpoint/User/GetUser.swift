//
//  GetUser.swift
//  QiitaKit
//
//  Created on 2015/06/08.
//  Copyright (c) 2015年 林達也. All rights reserved.
//

import Foundation
import APIKit

/**
*  ユーザを取得します。
*/
public class GetUser {
    public init() {
    }
}

extension GetUser: RequestToken {
    
    public typealias Response = User
    public typealias SerializedType = [String: AnyObject]

    public var method: HTTPMethod {
        return .GET
    }

    public var URL: String {
        return "/api/v2/users/:user_id"
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

extension GetUser {
    
    public static func transform(request: NSURLRequest, response: NSHTTPURLResponse?, object: SerializedType) -> Result<Response> {
        
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
        return Result(user)
    }
}
