//
//  UnstockItem.swift
//  QiitaKit
//
//  Created on 2015/06/08.
//  Copyright (c) 2015年 林達也. All rights reserved.
//

import Foundation
import APIKit

/**
*  投稿をストックから取り除きます。
*/
public struct UnstockItem {
    
    public let item_id: String
    
    public init(item_id: String) {
        self.item_id = item_id
    }
}

extension UnstockItem: RequestToken, RequestTokenValidatorStatusCode {
    
    public typealias Response = ()
    public typealias SerializedType = NSData

    public var method: HTTPMethod {
        return .DELETE
    }
    
    public var statusCode: Set<Int> {
        return 200..<400
    }

    public var URL: String {
        return "/api/v2/items/\(item_id)/stock"
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

extension UnstockItem {
    
    public static func transform(request: NSURLRequest, response: NSHTTPURLResponse?, object: SerializedType) -> Result<Response> {
        
        return Result(())
    }
}
