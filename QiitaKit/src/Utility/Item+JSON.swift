//
//  Item+JSON.swift
//  QiitaKit
//
//  Created by 林達也 on 2015/06/24.
//  Copyright (c) 2015年 林達也. All rights reserved.
//

import Foundation
import APIKit

func _Item(object: AnyObject!) -> Item {
    let object = object as! GetItem.SerializedType
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
        user: _User(object["user"])
    )
}

func _Items(object: AnyObject!) -> [Item] {
    let object = object as! [GetItem.SerializedType]
    return object.map { _Item($0) }
}


extension RequestToken where Response == Item, SerializedType == [String: AnyObject] {
    
    public static func transform(request: NSURLRequest, response: NSHTTPURLResponse?, object: SerializedType) -> Response {
        
        return _Item(object)
    }
}
