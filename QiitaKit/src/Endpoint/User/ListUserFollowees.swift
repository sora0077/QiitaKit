//
//  ListUserFollowees.swift
//  QiitaKit
//
//  Created on 2015/06/08.
//  Copyright (c) 2015年 林達也. All rights reserved.
//

import Foundation
import APIKit
import Result

/**
*  ユーザがフォローしているユーザ一覧を取得します。
*/
public struct ListUserFollowees {
    
    public let id: User.Identifier
    /// ページ番号 (1から100まで)
    /// example: 1
    /// ^[0-9]+$
    public let page: Int

    /// 1ページあたりに含まれる要素数 (1から100まで)
    /// example: 20
    /// ^[0-9]+$
    public let per_page: Int

    public init(id: User.Identifier, page: Int, per_page: Int) {
        self.id = id
        self.page = page
        self.per_page = per_page
    }
}

extension ListUserFollowees: QiitaRequestToken {
    
    public typealias Response = ([User], LinkMeta<ListUserFollowees>)
    public typealias SerializedObject = [[String: AnyObject]]

    public var method: HTTPMethod {
        return .GET
    }

    public var path: String {
        return "/api/v2/users/\(id)/followees"
    }

    public var parameters: [String: AnyObject]? {
        return [
            "page": page,
            "per_page": per_page
        ]
    }
}

extension ListUserFollowees: LinkProtocol {
    
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

public extension ListUserFollowees {
    
    func transform(request: NSURLRequest?, response: NSHTTPURLResponse?, object: SerializedObject) throws -> Response {
        
        return (try _Users(object), LinkMeta<ListUserFollowees>(dict: response!.allHeaderFields))
    }
}
