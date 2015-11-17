 //
//  Utility.swift
//  QiitaKit
//
//  Created by 林達也 on 2015/06/26.
//  Copyright (c) 2015年 林達也. All rights reserved.
//

import Foundation
import APIKit

infix operator ..< { associativity left precedence 140 }
func ..<(left: Int, right: Int) -> Set<Int> {
    return Set(Range(start: left, end: right))
}

public extension RequestToken where Response == () {
    
    func transform(request: NSURLRequest?, response: NSHTTPURLResponse?, object: SerializedObject) throws -> Response {
        
    }
}

func validation(object: AnyObject?) throws {
    
    guard let object = object as? [String: AnyObject] else {
        return
    }
    
    if  let message = object["message"] as? String,
        let type = object["type"] as? String
    {
        throw QiitaKitError.QiitaAPIError(message: message, type: type)
    }
}

