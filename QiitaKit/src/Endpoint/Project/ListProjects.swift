//
//  ListProjects.swift
//  QiitaKit
//
//  Created on 2015/06/08.
//  Copyright (c) 2015年 林達也. All rights reserved.
//

import Foundation
import APIKit

/**
*  チーム内に存在するプロジェクト一覧をプロジェクト作成日時の降順で返します。
*/
public struct ListProjects {
    /// ページ番号 (1から100まで)
    /// example: 1
    /// ^[0-9]+$
    public let page: String

    /// 1ページあたりに含まれる要素数 (1から100まで)
    /// example: 20
    /// ^[0-9]+$
    public let per_page: String

    public init(page: String, per_page: String) {
        self.page = page
        self.per_page = per_page
    }
}

extension ListProjects: RequestToken {
    
    public typealias Response = [Project]
    public typealias SerializedType = [[String: AnyObject]]

    public var method: HTTPMethod {
        return .GET
    }

    public var URL: String {
        return "/api/v2/projects"
    }

    public var headers: [String: AnyObject]? {
        return nil
    }

    public var parameters: [String: AnyObject]? {
        return [
            "page": page,
            "per_page": per_page
        ]
    }

    public var encoding: RequestEncoding {
        return .URL
    }

    public var resonseEncoding: ResponseEncoding {
        return .JSON(.AllowFragments)
    }
}

extension ListProjects {
    
    public static func transform(request: NSURLRequest, response: NSHTTPURLResponse?, object: SerializedType) -> Result<Response> {
        
        let projects = object.map { object -> Project in
            
            let project = Project(
                rendered_body: object["rendered_body"] as! String,
                archived: object["archived"] as! Bool,
                body: object["body"] as! String,
                created_at: object["created_at"] as! String,
                id: object["id"] as! Int,
                name: object["name"] as! String,
                updated_at: object["updated_at"] as! String
                
            )
            return project
        }
        return Result(projects)
    }
}
