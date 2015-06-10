//
//  QiitaKit.swift
//  QiitaKit
//
//  Created by 林達也 on 2015/06/08.
//  Copyright (c) 2015年 林達也. All rights reserved.
//

import Foundation
import APIKit
import BrightFutures

/**
*  <#Description#>
*/
public class QiitaKit {
    
    /// aaa
    /// bbb
    let api: API
    
    public init(baseURL: String) {
        self.api = API(baseURL: baseURL)
    }
    
    public func request<T : RequestToken>(token: T) -> Future<T.Response> {
        return self.api.request(token)
    }
    
    public func cancel<T : RequestToken>(clazz: T.Type) {
        return self.api.cancel(clazz)
    }
    
    public func cancel<T : RequestToken>(clazz: T.Type, f: T -> Bool) {
        return self.api.cancel(clazz, f: f)
    }
    
}
