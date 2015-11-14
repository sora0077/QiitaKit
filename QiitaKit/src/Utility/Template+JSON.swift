//
//  Template+JSON.swift
//  QiitaKit
//
//  Created by 林達也 on 2015/06/25.
//  Copyright (c) 2015年 林達也. All rights reserved.
//

import Foundation

func _Template(object: AnyObject!) -> Template {
    let object = object as! GetTemplate.SerializedObject
    return Template(
        body: object["body"] as! String,
        id: object["id"] as! Int,
        name: object["name"] as! String,
        expanded_body: object["expanded_body"] as! String,
        expanded_tags: _Taggings(object["expanded_tags"]),
        expanded_title: object["expanded_title"] as! String,
        tags: _Taggings(object["tags"]),
        title: object["title"] as! String
    )
}

func _Templates(object: AnyObject!) -> [Template] {
    let object = object as! [GetTemplate.SerializedObject]
    return object.map { _Template($0) }
}
