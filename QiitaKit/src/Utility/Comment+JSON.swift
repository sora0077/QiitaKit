//
//  Comment+JSON.swift
//  QiitaKit
//
//  Created by 林達也 on 2015/06/24.
//  Copyright (c) 2015年 林達也. All rights reserved.
//

import Foundation

func _Comment(object: AnyObject!) -> Comment {
    let object = object as! GetComment.SerializedType
    return Comment(
        body: object["body"] as! String,
        created_at: object["created_at"] as! String,
        id: object["id"] as! String,
        rendered_body: object["rendered_body"] as! String,
        updated_at: object["updated_at"] as! String,
        user: _User(object["user"])
    )
}

func _Comments(object: AnyObject!) -> [Comment] {
    let object = object as! [GetComment.SerializedType]
    return object.map { _Comment($0) }
}
