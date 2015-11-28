//
//  User+JSON.swift
//  QiitaKit
//
//  Created by 林達也 on 2015/06/24.
//  Copyright (c) 2015年 林達也. All rights reserved.
//

import Foundation

func _User(object: AnyObject!) throws -> User {
    let object = object as! GetUser.SerializedObject
    
    try validation(object)
    
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

func _Users(object: AnyObject!) throws -> [User] {
    
    try validation(object)
    
    let object = object as! [GetUser.SerializedObject]
    return try object.map { try _User($0) }
}