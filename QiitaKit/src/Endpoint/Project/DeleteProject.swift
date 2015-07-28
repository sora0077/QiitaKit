//
//  DeleteProject.swift
//  QiitaKit
//
//  Created on 2015/06/08.
//  Copyright (c) 2015年 林達也. All rights reserved.
//

import Foundation
import APIKit
import Result

/**
*  プロジェクトを削除します。
*/
public struct DeleteProject {
    
    public let id: Project.Identifier
    
    public init(id: Project.Identifier) {
        self.id = id
    }
}

extension DeleteProject: RequestToken {
    
    public typealias Response = ()
    public typealias SerializedType = Any

    public var method: HTTPMethod {
        return .DELETE
    }

    public var URL: String {
        return "/api/v2/projects/\(id)"
    }
}
