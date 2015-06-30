//
//  GetUserFollowing.swift
//  QiitaKit
//
//  Created on 2015/06/08.
//  Copyright (c) 2015年 林達也. All rights reserved.
//

import Foundation
import APIKit

/**
*  ユーザをフォローしている場合に204を返します。
*/
public struct GetUserFollowing {
    
    public let user_id: String
    
    public init(user_id: String) {
        self.user_id = user_id
    }
}

extension GetUserFollowing: RequestToken, RequestTokenValidatorStatusCode {
    
    public typealias Response = Bool
    public typealias SerializedType = NSData

    public var method: HTTPMethod {
        return .GET
    }
    
    public var statusCode: Set<Int> {
        return 200..<500
    }

    public var URL: String {
        return "/api/v2/users/\(user_id)/following"
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

extension GetUserFollowing {
    
    public static func transform(request: NSURLRequest, response: NSHTTPURLResponse?, object: SerializedType) -> Result<Response> {
        
        if let statusCode = response?.statusCode {
            switch statusCode {
            case 200..<300:
                return Result(true)
            default:
                break
            }
        }
        return Result(false)
    }
}
