//
//  ExpandedTemplate+JSON.swift
//  QiitaKit
//
//  Created by 林達也 on 2015/06/25.
//  Copyright (c) 2015年 林達也. All rights reserved.
//

import Foundation

func _ExpandedTemplate(object: AnyObject!) -> ExpandedTemplate {
    let object = object as! CreateExpandedTemplate.SerializedType
    return ExpandedTemplate(
        expanded_body: object["expanded_body"] as! String,
        expanded_tags: _Taggings(object["expanded_tags"]),
        expanded_title: object["expanded_title"] as! String
    )
}

