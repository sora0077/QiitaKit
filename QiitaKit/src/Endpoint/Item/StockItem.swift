
//
//  StockItem.swift
//  QiitaKit
//
//  Created on 2015/06/08.
//  Copyright (c) 2015年 林達也. All rights reserved.
//

import Foundation
import APIKit
import Result

/**
*  投稿をストックします。
*/
public struct StockItem {
    
    public let id: Item.Identifier
    
    public init(id: Item.Identifier) {
        self.id = id
    }
}

extension StockItem: RequestToken {
    
    public typealias Response = ()
    public typealias SerializedType = Any

    public var method: HTTPMethod {
        return .PUT
    }

    public var URL: String {
        return "/api/v2/items/\(id)/stock"
    }
}
