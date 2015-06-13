//
//  GetAuthenticatedUser.swift
//  QiitaKit
//
//  Created on 2015/06/08.
//  Copyright (c) 2015年 林達也. All rights reserved.
//

import Foundation
import APIKit

/**
*  アクセストークンに紐付いたユーザを返します。
*/
public struct GetAuthenticatedUser {
    public init() {
    }
}

extension GetAuthenticatedUser: RequestToken {

    public typealias Response = AuthenticatedUser
    public typealias SerializedType = [String: AnyObject]

    public var method: HTTPMethod {
        return .GET
    }

    public var URL: String {
        return "/api/v2/authenticated_user"
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

extension GetAuthenticatedUser {
    
    public static func transform(request: NSURLRequest, response: NSHTTPURLResponse?, object: SerializedType) -> Result<Response> {
        
        let authenticatedUser = AuthenticatedUser(
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
            website_url: object["website_url"] as? String,
            image_monthly_upload_limit: object["image_monthly_upload_limit"] as! Int,
            image_monthly_upload_remaining: object["image_monthly_upload_remaining"] as! Int,
            team_only: object["team_only"] as! Bool
        )
        return Result(authenticatedUser)
    }
}
