//
//  DeleteTagging.swift
//  QiitaKit
//
//  Created on 2015/06/08.
//  Copyright (c) 2015年 林達也. All rights reserved.
//

import Foundation
import APIKit
import Result

/**
*  投稿から指定されたタグを取り除きます。Qiita:Teamでのみ有効です。
*/
public struct DeleteTagging {
    
    public let id: String
    
    public let tagging_id: String
    
    
    public init(id: String, tagging_id: String) {
        self.id = id
        self.tagging_id = tagging_id
    }
}

extension DeleteTagging: RequestToken {
    
    public typealias Response = ()
    public typealias SerializedType = Any

    public var method: HTTPMethod {
        return .DELETE
    }

    public var URL: String {
        return "/api/v2/items/\(id)/taggings/\(tagging_id)"
    }
}
