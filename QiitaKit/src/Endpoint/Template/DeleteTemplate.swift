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
    
    public let id: String
    
    public init(id: String) {
        self.id = id
    }
}

extension DeleteTemplate: RequestToken {
    
    public typealias Response = ()
    public typealias SerializedType = Any

    public var method: HTTPMethod {
        return .DELETE
    }
    
    public var URL: String {
        return "/api/v2/templates/\(id)"
    }

    public var responseEncoding: ResponseEncoding {
        return .JSON(.AllowFragments)
    }
}
