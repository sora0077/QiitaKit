//
//  Tagging+JSON.swift
//  QiitaKit
//
//  Created by 林達也 on 2015/06/24.
//  Copyright (c) 2015年 林達也. All rights reserved.
//

import Foundation


func _Tagging(object: AnyObject!) -> Tagging {
    let object = object as! CreateTagging.SerializedObject
    return Tagging(
        name: object["name"] as! String,
        versions: object["versions"] as! Array<String>
    )
}

func _Taggings(object: AnyObject!) -> [Tagging] {
    let object = object as! [CreateTagging.SerializedObject]
    return object.map { _Tagging($0) }
}
