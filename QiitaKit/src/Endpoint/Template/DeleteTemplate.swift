//
//  DeleteTemplate.swift
//  QiitaKit
//
//  Created on 2015/06/08.
//  Copyright (c) 2015年 林達也. All rights reserved.
//

import Foundation
import APIKit
import Result

/**
*  テンプレートを削除します。
*/
public struct DeleteTemplate {
    
    public let id: Template.Identifier
    
    public init(id: Template.Identifier) {
        self.id = id
    }
}

extension DeleteTemplate: RequestToken {
    
    public typealias Response = ()
    public typealias SerializedObject = Any

    public var method: HTTPMethod {
        return .DELETE
    }
    
    public var path: String {
        return "/api/v2/templates/\(id)"
    }
}
