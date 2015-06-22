//
//  UnthankComment.swift
//  QiitaKit
//
//  Created on 2015/06/08.
//  Copyright (c) 2015年 林達也. All rights reserved.
//

import Foundation
import APIKit

/**
*  コメントからThankを外します。
*/
public struct UnthankComment {
    
    public let comment_id: String
    
    public init(comment_id: String) {
        self.comment_id = comment_id
    }
}

extension UnthankComment: RequestToken, RequestTokenValidatorStatusCode {
    
    public typealias Response = ()
    public typealias SerializedType = NSData

    public var method: HTTPMethod {
        return .DELETE
    }
    
    public var statusCode: Range<Int> {
        return 200..<400
    }

    public var URL: String {
        return "/api/v2/comments/\(comment_id)/thank"
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

extension UnthankComment {
    
    public static func transform(request: NSURLRequest, response: NSHTTPURLResponse?, object: SerializedType) -> Result<Response> {
        
        return Result(())
    }
}
