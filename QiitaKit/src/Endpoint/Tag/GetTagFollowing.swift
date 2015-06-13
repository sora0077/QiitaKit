//
//  GetTagFollowing.swift
//  QiitaKit
//
//  Created on 2015/06/08.
//  Copyright (c) 2015年 林達也. All rights reserved.
//

import Foundation
import APIKit

/**
*  タグをフォローしているかどうかを調べます。
*/
public struct GetTagFollowing {
    
    public let tag_id: String
    
    public init(tag_id: String) {
        self.tag_id = tag_id
    }
}

extension GetTagFollowing: RequestToken {
    
    public typealias Response = Tag
    public typealias SerializedType = [String: AnyObject]

    public var method: HTTPMethod {
        return .GET
    }

    public var URL: String {
        return "/api/v2/tags/\(tag_id)/following"
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

extension GetTagFollowing {
    
    public static func transform(request: NSURLRequest, response: NSHTTPURLResponse?, object: SerializedType) -> Result<Response> {
        
        let tag = Tag(
            followers_count: object["followers_count"] as! Int,
            icon_url: object["icon_url"] as? String,
            id: object["id"] as! String,
            items_count: object["items_count"] as! Int
        )
        return Result(tag)
    }
}
