//
//  Item+JSON.swift
//  QiitaKit
//
//  Created by 林達也 on 2015/06/24.
//  Copyright (c) 2015年 林達也. All rights reserved.
//

import Foundation
import APIKit

func _Item(object: AnyObject!) throws -> Item {
    
    try validation(object)
    
    let object = object as! GetItem.SerializedObject
    return Item(
        rendered_body: object["rendered_body"] as! String,
        body: object["body"] as! String,
        coediting: object["coediting"] as! Bool,
        created_at: object["created_at"] as! String,
        id: object["id"] as! String,
        `private`: object["private"] as! Bool,
        tags: _Taggings(object["tags"]),
        title: object["title"] as! String,
        updated_at: object["updated_at"] as! String,
        url: object["url"] as! String,
        user: try _User(object["user"])
    )
}

func _Items(object: AnyObject!) throws -> [Item] {
    
    try validation(object)
    
    let object = object as! [GetItem.SerializedObject]
    return try object.map { try _Item($0) }
}


public extension RequestToken where Response == Item, SerializedObject == [String: AnyObject] {

    func transform(request: NSURLRequest?, response: NSHTTPURLResponse?, object: SerializedObject) throws -> Response {
        
        return try _Item(object)
    }
}
