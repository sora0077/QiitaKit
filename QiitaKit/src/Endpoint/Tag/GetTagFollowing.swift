//
//  GetTagFollowing.swift
//  QiitaKit
//
//  Created on 2015/06/08.
//  Copyright (c) 2015年 林達也. All rights reserved.
//

import Foundation
import APIKit
import Result

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
    
    public typealias Response = ()
    public typealias SerializedType = Any

    public var method: HTTPMethod {
        return .GET
    }

    public var URL: String {
        return "/api/v2/tags/\(tag_id)/following"
    }

    public var resonseEncoding: ResponseEncoding {
        return .JSON(.AllowFragments)
    }
}
