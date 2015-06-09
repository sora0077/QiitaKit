//
//  UpdateComment.swift
//  QiitaKit
//
//  Created on 2015/06/08.
//  Copyright (c) 2015年 林達也. All rights reserved.
//

import Foundation
import APIKit

/**
*  コメントを更新します。
*/
public class UpdateComment {
    /// コメントの内容を表すMarkdown形式の文字列
    /// example: # Example
    /// 
    public let body: String

    public init(body: String) {
        self.body = body
    }
}
