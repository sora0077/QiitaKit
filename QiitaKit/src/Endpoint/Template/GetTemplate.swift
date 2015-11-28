//
//  GetTemplate.swift
//  QiitaKit
//
//  Created on 2015/06/08.
//  Copyright (c) 2015年 林達也. All rights reserved.
//

import Foundation
import APIKit
import Result

/**
*  テンプレートを取得します。
*/
public struct GetTemplate {
    
    public let id: Template.Identifier
    
    public init(id: Template.Identifier) {
        self.id = id
    }
}

extension GetTemplate: QiitaRequestToken {
    
    public typealias Response = Template
    public typealias SerializedObject = [String: AnyObject]

    public var method: HTTPMethod {
        return .GET
    }

    public var path: String {
        return "/api/v2/templates/\(id)"
    }
}

public extension GetTemplate {
    
    func transform(request: NSURLRequest?, response: NSHTTPURLResponse?, object: SerializedObject) throws -> Response {
        
        return _Template(object)
    }
}
