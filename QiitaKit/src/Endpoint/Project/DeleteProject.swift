//
//  DeleteProject.swift
//  QiitaKit
//
//  Created on 2015/06/08.
//  Copyright (c) 2015年 林達也. All rights reserved.
//

import Foundation
import APIKit

/**
*  プロジェクトを削除します。
*/
public class DeleteProject {
    public init() {
    }
}

extension DeleteProject: RequestToken {
    
    public typealias Response = Project
    public typealias SerializedType = [String: AnyObject]

    public var method: HTTPMethod {
        return .DELETE
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

extension DeleteProject {
    
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
