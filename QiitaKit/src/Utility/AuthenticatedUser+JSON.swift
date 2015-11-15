//
//  AuthenticatedUser+JSON.swift
//  QiitaKit
//
//  Created by 林達也 on 2015/06/24.
//  Copyright (c) 2015年 林達也. All rights reserved.
//

import Foundation

func _AuthenticatedUser(object: AnyObject!) -> AuthenticatedUser {
    let object = object as! GetAuthenticatedUser.SerializedObject
    return AuthenticatedUser(
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
}