//
//  UnfollowTag.swift
//  QiitaKit
//
//  Created on 2015/06/08.
//  Copyright (c) 2015年 林達也. All rights reserved.
//

import Foundation
import APIKit

/**
*  タグのフォローを外します。
*/
public struct UnfollowTag {
    
    public let tag_id: String
    
    public init(tag_id: String) {
        self.tag_id = tag_id
    }
}

extension UnfollowTag: RequestToken {
    
    public typealias Response = ()
    public typealias SerializedType = NSData

    public var method: HTTPMethod {
        return .DELETE
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

extension UnfollowTag {
    
    public static func transform(request: NSURLRequest, response: NSHTTPURLResponse?, object: SerializedType) -> Result<Response> {
        
        return Result(())
    }
}
