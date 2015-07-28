//
//  UnlikeItem.swift
//  QiitaKit
//
//  Created on 2015/06/08.
//  Copyright (c) 2015年 林達也. All rights reserved.
//

import Foundation
import APIKit
import Result

/**
*  投稿への「いいね！」を取り消します。Qiita:Teamでのみ有効です。
*/
public struct UnlikeItem {
    
    public let id: String
    
    public init(id: String) {
        self.id = id
    }
}

extension UnlikeItem: RequestToken {
    
    public typealias Response = ()
    public typealias SerializedType = Any

    public var method: HTTPMethod {
        return .DELETE
    }

    public var URL: String {
        return "/api/v2/items/\(id)/like"
    }
}
