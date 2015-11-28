//
//  ListTags.swift
//  QiitaKit
//
//  Created on 2015/06/08.
//  Copyright (c) 2015年 林達也. All rights reserved.
//

import Foundation
import APIKit
import Result

/**
*  タグ一覧を作成日時の降順で返します。
*/
public struct ListTags {
    /// ページ番号 (1から100まで)
    /// example: 1
    /// ^[0-9]+$
    public let page: Int

    /// 1ページあたりに含まれる要素数 (1から100まで)
    /// example: 20
    /// ^[0-9]+$
    public let per_page: Int

    public init(page: Int, per_page: Int) {
        self.page = page
        self.per_page = per_page
    }
}

extension ListTags: QiitaRequestToken {
    
    public typealias Response = ([Tag], LinkMeta<ListTags>)
    public typealias SerializedObject = [[String: AnyObject]]

    public var method: HTTPMethod {
        return .GET
    }

    public var path: String {
        return "/api/v2/tags"
    }

    public var parameters: [String: AnyObject]? {
        return [
            "page": page,
            "per_page": per_page
        ]
    }
}

extension ListTags: LinkProtocol {
    
    public init(url: NSURL!) {
        
        let comps = NSURLComponents(URL: url, resolvingAgainstBaseURL: false)
        self.page = Int(find(comps?.queryItems ?? [], name: "page")!.value!)!
        
        if let value = find(comps?.queryItems ?? [], name: "per_page")?.value,
            let per_page = Int(value)
        {
            self.per_page = per_page
        } else {
            self.per_page = 20
        }
    }
}

public extension ListTags {
    
    func transform(request: NSURLRequest?, response: NSHTTPURLResponse?, object: SerializedObject) throws -> Response {
        
        let tags = object.map { object in
            Tag(
                followers_count: object["followers_count"] as! Int,
                icon_url: object["icon_url"] as? String,
                id: object["id"] as! String,
                items_count: object["items_count"] as! Int
            )
        }
        return (tags, LinkMeta<ListTags>(dict: response!.allHeaderFields))
    }
}
