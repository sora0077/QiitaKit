//
//  LikeItem.swift
//  QiitaKit
//
//  Created on 2015/06/08.
//  Copyright (c) 2015年 林達也. All rights reserved.
//

import Foundation
import APIKit
import Result

/**
*  投稿に「いいね！」を付けます。Qiita:Teamでのみ有効です。
*/
public struct LikeItem {
    
    public let id: Item.Identifier
    
    public init(id: Item.Identifier) {
        self.id = id
    }
}

extension LikeItem: QiitaRequestToken {
    
    public typealias Response = ()
    public typealias SerializedObject = Any

    public var method: HTTPMethod {
        return .PUT
    }

    public var path: String {
        return "/api/v2/items/\(id)/like"
    }
}
