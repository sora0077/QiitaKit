//
//  PatchProject.swift
//  QiitaKit
//
//  Created on 2015/06/08.
//  Copyright (c) 2015年 林達也. All rights reserved.
//

import Foundation
import APIKit
import Result

/**
*  プロジェクトを更新します。
*/
public struct PatchProject {
    
    public let id: Project.Identifier
    
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
    public let tags: Array<Tagging>

    public init(id: Project.Identifier, archived: Bool, body: String, name: String, tags: Array<Tagging>) {
        self.id = id
        self.archived = archived
        self.body = body
        self.name = name
        self.tags = tags
    }
}

extension PatchProject: QiitaRequestToken {
    
    public typealias Response = Project
    public typealias SerializedObject = [String: AnyObject]

    public var method: HTTPMethod {
        return .PATCH
    }

    public var path: String {
        return "/api/v2/projects/\(id)"
    }

    public var parameters: [String: AnyObject]? {
        return [
            "archived": archived,
            "body": body,
            "name": name,
            "tags": tags.map({ ["name": $0.name, "versions": $0.versions] }),
        ]
    }

    public var encoding: RequestEncoding {
        return .JSON
    }
}

public extension PatchProject {
    
    func transform(request: NSURLRequest?, response: NSHTTPURLResponse?, object: SerializedObject) throws -> Response {
        
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
}
