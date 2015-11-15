//
//  DeleteAccessToken.swift
//  QiitaKit
//
//  Created on 2015/06/08.
//  Copyright (c) 2015年 林達也. All rights reserved.
//

import Foundation
import APIKit
import Result

/**
*  指定されたアクセストークンを失効させ、それ以降利用できないようにします。
*  Response = ()
*/
public struct DeleteAccessToken {
    
    public let access_token: String
    
    public init(access_token: String) {
        self.access_token = access_token
    }
}

extension DeleteAccessToken: RequestToken {

    public typealias Response = ()
    public typealias SerializedObject = Any

    public var method: HTTPMethod {
        return .DELETE
    }

    public var path: String {
        return "/api/v2/access_tokens/\(access_token)"
    }
}

public extension DeleteAccessToken {
    
    public func transform(request: NSURLRequest?, response: NSHTTPURLResponse?, object: SerializedObject) throws -> Response {
        
    }
}
