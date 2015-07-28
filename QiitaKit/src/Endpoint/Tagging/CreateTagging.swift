//
//  CreateTagging.swift
//  QiitaKit
//
//  Created on 2015/06/08.
//  Copyright (c) 2015年 林達也. All rights reserved.
//

import Foundation
import APIKit
import Result

/**
*  投稿にタグを追加します。Qiita:Teamでのみ有効です。
*/
public struct CreateTagging {
    
    public let id: Item.Identifier
    /// タグを特定するための一意な名前
    /// example: qiita
    /// 
    public let name: String

    /// 
    /// example: ["0.0.1"]
    /// 
    public let versions: Array<String>

    public init(id: Item.Identifier, name: String, versions: Array<String>) {
        self.id = id
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
        return "/api/v2/items/\(id)/taggings"
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
}

extension CreateTagging {
    
    public static func transform(request: NSURLRequest, response: NSHTTPURLResponse?, object: SerializedType) -> Response {
        
        return _Tagging(object)
    }
}
