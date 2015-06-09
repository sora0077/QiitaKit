//
//  DeleteTagging.swift
//  QiitaKit
//
//  Created on 2015/06/08.
//  Copyright (c) 2015年 林達也. All rights reserved.
//

import Foundation
import APIKit

/**
*  投稿から指定されたタグを取り除きます。Qiita:Teamでのみ有効です。
*/
public class DeleteTagging {
    public init() {
    }
}

extension DeleteTagging: RequestToken {
    
    public typealias Response = Tagging
    public typealias SerializedType = [String: AnyObject]

    public var method: HTTPMethod {
        return .DELETE
    }

    public var URL: String {
        return "/api/v2/items/:item_id/taggings/:tagging_id"
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

extension DeleteTagging {
    
    public static func transform(request: NSURLRequest, response: NSHTTPURLResponse?, object: SerializedType) -> Result<Response> {
        
        let tagging = Tagging(
            name: object["name"] as! String,
            versions: object["versions"] as! Array<String>
        )
        return Result(tagging)
    }
}
