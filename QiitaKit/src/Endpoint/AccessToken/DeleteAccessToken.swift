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
*/
public struct DeleteAccessToken {
    
    public let access_token: String
    
    public init(access_token: String) {
        self.access_token = access_token
    }
}

extension DeleteAccessToken: RequestToken {

    public typealias Response = ()
    public typealias SerializedType = Any

    public var method: HTTPMethod {
        return .DELETE
    }

    public var URL: String {
        return "/api/v2/access_tokens/\(access_token)"
    }

    public var resonseEncoding: ResponseEncoding {
        return .JSON(.AllowFragments)
    }
}
