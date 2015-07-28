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
    
    public let comment_id: String
    
    public init(comment_id: String) {
        self.comment_id = comment_id
    }
}

extension ThankComment: RequestToken {
    
    public typealias Response = ()
    public typealias SerializedType = Any

    public var method: HTTPMethod {
        return .PUT
    }

    public var URL: String {
        return "/api/v2/comments/\(comment_id)/thank"
    }
}
