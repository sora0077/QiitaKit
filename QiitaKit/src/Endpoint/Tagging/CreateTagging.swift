//
//  CreateTagging.swift
//  QiitaKit
//
//  Created on 2015/06/08.
//  Copyright (c) 2015年 林達也. All rights reserved.
//

import Foundation
import APIKit

/**
*  投稿にタグを追加します。Qiita:Teamでのみ有効です。
*/
public struct CreateTagging {
    
    public let item_id: String
    /// タグを特定するための一意な名前
    /// example: qiita
    /// 
    public let name: String

    /// 
    /// example: ["0.0.1"]
    /// 
    public let versions: Array<String>

    public init(item_id: String, name: String, versions: Array<String>) {
        self.item_id = item_id
        self.name = name
        self.versions = versions
    }
}

extension CreateTagging: RequestToken {

    public typealias Response = Tagging
    public typealias SerializedType = [String: AnyObject]

    public var method: HTTPMethod {
        return .POST
    }

    public var URL: String {
        return "/api/v2/items/\(item_id)/taggings"
    }

    public var headers: [String: AnyObject]? {
        return nil
    }

    public var parameters: [String: AnyObject]? {
        return [
            "name": name,
            "versions": versions
        ]
    }

    public var encoding: RequestEncoding {
        return .JSON
    }

    public var resonseEncoding: ResponseEncoding {
        return .JSON(.AllowFragments)
    }
}

extension CreateTagging {
    
    public static func transform(request: NSURLRequest, response: NSHTTPURLResponse?, object: SerializedType) -> Result<Response> {
        
        return Result(_Tagging(object))
    }
}
