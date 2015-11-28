//
//  ListUserItems.swift
//  QiitaKit
//
//  Created on 2015/06/08.
//  Copyright (c) 2015年 林達也. All rights reserved.
//

import Foundation
import APIKit
import Result

/**
*  指定されたユーザの投稿一覧を、作成日時の降順で返します。
*/
public struct ListUserItems {
    
    public let id: User.Identifier
    /// ページ番号 (1から100まで)
    /// example: 1
    /// ^[0-9]+$
    public let page: Int

    /// 1ページあたりに含まれる要素数 (1から100まで)
    /// example: 20
    /// ^[0-9]+$
    public let per_page: Int

    public init(id: User.Identifier, page: Int, per_page: Int = 20) {
        self.id = id
        self.page = page
        self.per_page = per_page
    }
}

extension ListUserItems: QiitaRequestToken {
    
    public typealias Response = ([Item], LinkMeta<ListUserItems>)
    public typealias SerializedObject = [[String: AnyObject]]

    public var method: HTTPMethod {
        return .GET
    }

    public var path: String {
        return "/api/v2/users/\(id)/items"
    }

    public var parameters: [String: AnyObject]? {
        return [
            "page": page,
            "per_page": per_page
        ]
    }
}

extension ListUserItems: LinkProtocol {
    
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
        
        self.id = url.pathComponents![url.pathComponents!.count - 2]
    }
}

public extension ListUserItems {
    
    func transform(request: NSURLRequest?, response: NSHTTPURLResponse?, object: SerializedObject) throws -> Response {
        
        return (try _Items(object), LinkMeta<ListUserItems>(dict: response!.allHeaderFields))
    }
}
