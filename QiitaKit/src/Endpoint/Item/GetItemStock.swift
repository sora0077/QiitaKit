//
//  GetItemStock.swift
//  QiitaKit
//
//  Created on 2015/06/08.
//  Copyright (c) 2015年 林達也. All rights reserved.
//

import Foundation
import APIKit

/**
*  投稿をストックしているかどうかを調べます。
*/
public struct GetItemStock {
    
    public let item_id: String
    
    public init(item_id: String) {
        self.item_id = item_id
    }
}

extension GetItemStock: RequestToken {
    
    public typealias Response = Bool
    public typealias SerializedType = Any

    public var method: HTTPMethod {
        return .GET
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

extension GetItemStock {
    
    public static func transform(request: NSURLRequest, response: NSHTTPURLResponse?, object: SerializedType) -> Result<Response> {
        
        if let statusCode = response?.statusCode {
            switch statusCode {
            case 200..<300:
                return Result(true)
            default:
                return Result(false)
            }
        }
        return Result(false)
    }
}
