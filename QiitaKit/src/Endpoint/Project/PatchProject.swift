//
//  PatchProject.swift
//  QiitaKit
//
//  Created on 2015/06/08.
//  Copyright (c) 2015年 林達也. All rights reserved.
//

import Foundation
import APIKit

/**
*  プロジェクトを更新します。
*/
public class PatchProject {
    /// このプロジェクトが進行中かどうか
    /// 
    public let archived: Bool

    /// Markdown形式の本文
    /// example: # Example
    /// 
    public let body: String

    /// プロジェクト名
    /// example: Kobiro Project
    /// 
    public let name: String

    /// 投稿に付いたタグ一覧
    /// example: [{"name"=>"Ruby", "versions"=>["0.0.1"]}]
    /// 
    public let tags: Array<Dictionary<String, AnyObject>>

    public init(archived: Bool, body: String, name: String, tags: Array<Dictionary<String, AnyObject>>) {
        self.archived = archived
        self.body = body
        self.name = name
        self.tags = tags
    }
}

extension PatchProject: RequestToken {
    
    public typealias Response = Project
    public typealias SerializedType = [String: AnyObject]

    public var method: HTTPMethod {
        return .PATCH
    }

    public var URL: String {
        return "/api/v2/projects/:project_id"
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

extension PatchProject {
    
    public static func transform(request: NSURLRequest, response: NSHTTPURLResponse?, object: SerializedType) -> Result<Response> {
        
        let project = Project(
            rendered_body: object["rendered_body"] as! String,
            archived: object["archived"] as! Bool,
            body: object["body"] as! String,
            created_at: object["created_at"] as! String,
            id: object["id"] as! Int,
            name: object["name"] as! String,
            updated_at: object["updated_at"] as! String
            
        )
        return Result(project)
    }
}
