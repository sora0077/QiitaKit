//
//  GetItemStock.swift
//  QiitaKit
//
//  Created on 2015/06/08.
//  Copyright (c) 2015年 林達也. All rights reserved.
//

import Foundation
import APIKit
import Result

/**
*  投稿をストックしているかどうかを調べます。
*/
public struct GetItemStock {
    
    public let id: Item.Identifier
    
    public init(id: Item.Identifier) {
        self.id = id
    }
}

extension GetItemStock: QiitaRequestToken {
    
    public typealias Response = ()
    public typealias SerializedObject = Any

    public var method: HTTPMethod {
        return .GET
    }

    public var path: String {
        return "/api/v2/items/\(id)/stock"
    }
}
