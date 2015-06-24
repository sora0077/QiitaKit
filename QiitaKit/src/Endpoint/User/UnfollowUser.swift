//
//  UnfollowUser.swift
//  QiitaKit
//
//  Created on 2015/06/08.
//  Copyright (c) 2015年 林達也. All rights reserved.
//

import Foundation
import APIKit

/**
*  ユーザへのフォローを外します。
*/
public struct UnfollowUser {
    
    public let user_id: String
    
    public init(user_id: String) {
        self.user_id = user_id
    }
}

extension UnfollowUser: RequestToken, RequestTokenValidatorStatusCode {
    
    public typealias Response = ()
    public typealias SerializedType = NSData

    public var method: HTTPMethod {
        return .DELETE
    }
    
    public var statusCode: Range<Int> {
        return 200..<400
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

extension UnfollowUser {
    
    public static func transform(request: NSURLRequest, response: NSHTTPURLResponse?, object: SerializedType) -> Result<Response> {
        
        return Result(())
    }
}
