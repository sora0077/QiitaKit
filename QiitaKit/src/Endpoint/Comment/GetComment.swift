//
//  GetComment.swift
//  QiitaKit
//
//  Created on 2015/06/08.
//  Copyright (c) 2015年 林達也. All rights reserved.
//

import Foundation
import APIKit
import Result

/**
*  コメントを取得します。
*/
public struct GetComment {
    
    public let comment_id: String
    
    public init(comment_id: String) {
        self.comment_id = comment_id
    }
}

extension GetComment: RequestToken {
    
    public typealias Response = Comment
    public typealias SerializedType = [String: AnyObject]

    public var method: HTTPMethod {
        return .GET
    }

    public var URL: String {
        return "/api/v2/comments/\(comment_id)"
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

extension GetComment {
    
    public static func transform(request: NSURLRequest, response: NSHTTPURLResponse?, object: SerializedType) -> Result<Response, NSError> {
        
        return Result(_Comment(object))
    }
}
