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
    
    public let item_id: String
    
    public let tagging_id: String
    
    
    public init(item_id: String, tagging_id: String) {
        self.item_id = item_id
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
        return "/api/v2/items/\(item_id)/taggings/\(tagging_id)"
    }

    public var resonseEncoding: ResponseEncoding {
        return .JSON(.AllowFragments)
    }
}
