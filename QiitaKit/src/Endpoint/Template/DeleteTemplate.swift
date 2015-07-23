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
    
    public let template_id: String
    
    public init(template_id: String) {
        self.template_id = template_id
    }
}

extension DeleteTemplate: RequestToken {
    
    public typealias Response = ()
    public typealias SerializedType = Any

    public var method: HTTPMethod {
        return .DELETE
    }
    
    public var URL: String {
        return "/api/v2/templates/\(template_id)"
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

extension DeleteTemplate {
    
    public static func transform(request: NSURLRequest, response: NSHTTPURLResponse?, object: SerializedType) -> Result<Response, NSError> {
        
        return Result(())
    }
}
