//
//  Comment+JSON.swift
//  QiitaKit
//
//  Created by 林達也 on 2015/06/24.
//  Copyright (c) 2015年 林達也. All rights reserved.
//

import Foundation
import APIKit

func _Comment(object: AnyObject!) throws -> Comment {
    
    try validation(object)
    
    let object = object as! GetComment.SerializedObject
    return Comment(
        body: object["body"] as! String,
        created_at: object["created_at"] as! String,
        id: object["id"] as! String,
        rendered_body: object["rendered_body"] as! String,
        updated_at: object["updated_at"] as! String,
        user: try _User(object["user"])
    )
}

func _Comments(object: AnyObject!) throws -> [Comment] {
    
    try validation(object)
    
    let object = object as! [GetComment.SerializedObject]
    return try object.map { try _Comment($0) }
}

extension QiitaRequestToken where Response == Comment, SerializedObject == [String: AnyObject] {
    
    public func transform(request: NSURLRequest?, response: NSHTTPURLResponse?, object: SerializedObject) throws -> Response {
        
        return try _Comment(object)
    }
}
