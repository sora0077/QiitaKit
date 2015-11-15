//
//  ThankComment.swift
//  QiitaKit
//
//  Created on 2015/06/08.
//  Copyright (c) 2015年 林達也. All rights reserved.
//

import Foundation
import APIKit
import Result

/**
*  コメントにThankを付けます。
*/
public struct ThankComment {
    
    public let id: Comment.Identifier
    
    public init(id: Comment.Identifier) {
        self.id = id
    }
}

extension ThankComment: RequestToken {
    
    public typealias Response = ()
    public typealias SerializedObject = Any

    public var method: HTTPMethod {
        return .PUT
    }

    public var path: String {
        return "/api/v2/comments/\(id)/thank"
    }
}

public extension ThankComment {
    
    func transform(request: NSURLRequest?, response: NSHTTPURLResponse?, object: SerializedObject) throws -> Response {
        
    }
}
