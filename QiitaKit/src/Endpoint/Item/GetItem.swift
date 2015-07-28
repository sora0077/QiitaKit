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
    
    public let id: Item.Identifier
    
    public init(id: Item.Identifier) {
        self.id = id
    }
}

extension GetItem: RequestToken {
    
    public typealias Response = Item
    public typealias SerializedType = [String: AnyObject]

    public var method: HTTPMethod {
        return .GET
    }

    public var URL: String {
        return "/api/v2/items/\(id)"
    }
}
