//
//  FollowTag.swift
//  QiitaKit
//
//  Created on 2015/06/08.
//  Copyright (c) 2015年 林達也. All rights reserved.
//

import Foundation
import APIKit

/**
*  タグをフォローします。
*/
public struct FollowTag {
    
    public let tag_id: String
    
    public init(tag_id: String) {
        self.tag_id = tag_id
    }
}

extension FollowTag: RequestToken, RequestTokenValidatorStatusCode {

    public typealias Response = ()
    public typealias SerializedType = NSData

    public var method: HTTPMethod {
        return .PUT
    }
    
    public var statusCode: Set<Int> {
        return 200..<400
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
        return .Data
    }
}

extension FollowTag {
    
    public static func transform(request: NSURLRequest, response: NSHTTPURLResponse?, object: SerializedType) -> Result<Response> {
        
        return Result(())
    }
}
