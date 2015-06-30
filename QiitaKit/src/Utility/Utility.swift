//
//  Utility.swift
//  QiitaKit
//
//  Created by 林達也 on 2015/06/26.
//  Copyright (c) 2015年 林達也. All rights reserved.
//

import Foundation

infix operator ..< { associativity left precedence 140 }
func ..<(left: Int, right: Int) -> Set<Int> {
    return Set(Range(start: left, end: right))
}
