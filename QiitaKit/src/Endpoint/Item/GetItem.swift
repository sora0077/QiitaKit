//
//  GetItem.swift
//  QiitaKit
//
//  Created on 2015/06/08.
//  Copyright (c) 2015年 林達也. All rights reserved.
//

import Foundation
import APIKit
import Result

/**
*  投稿を取得します。
*/
public struct GetItem {
    
    public let item_id: String
    
    public init(item_id: String) {
        self.item_id = item_id
    }
}

extension GetItem: RequestToken {
    
    public typealias Response = Item
    public typealias SerializedType = [String: AnyObject]

    public var method: HTTPMethod {
        return .GET
    }

    public var URL: String {
        return "/api/v2/items/\(item_id)"
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

extension GetItem {
    
    public static func transform(request: NSURLRequest, response: NSHTTPURLResponse?, object: SerializedType) -> Result<Response, NSError> {
        
        return Result(_Item(object))
    }
}
