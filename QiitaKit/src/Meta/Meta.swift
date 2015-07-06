//
//  Meta.swift
//  QiitaKit
//
//  Created by 林達也 on 2015/07/05.
//  Copyright (c) 2015年 林達也. All rights reserved.
//

import Foundation

private func toInt(key: String, dict: [NSObject: AnyObject]) -> Int {
    let s = dict["Rate-Limit"] as! String
    return s.toInt()!
}

public class Meta {
    
    public let rateLimit: Int
    
    public let rateRemaining: Int
    
    public let rateReset: Int
    
    init(dict: [NSObject: AnyObject]) {
        
        self.rateLimit = toInt("Rate-Limit", dict)
        self.rateRemaining = toInt("Rate-Remaining", dict)
        self.rateReset = toInt("Rate-Reset", dict)
    }
}

public protocol LinkProtocol {
    
    init!(url: NSURL!)
}

public class LinkMeta<T: LinkProtocol>: Meta {
    
    public let first: T
    public let last: T
    public let prev: T?
    public let next: T?
    
    public let totalCount: Int
    
    override init(dict: [NSObject : AnyObject]) {
        
        self.totalCount = toInt("Total-Count", dict)
        
        let link = split(dict["Link"] as! String) { $0 == "," }
        var links: [String: String] = [:]
        let regex = NSRegularExpression(pattern: "^.?<(.+)>; rel=\"(.*)\".?$", options: .allZeros, error: nil)
        for l in link as [NSString] {
            if let result = regex?.firstMatchInString(l as String, options: .allZeros, range: NSRange(location: 0, length: l.length)) {
                
                let key = l.substringWithRange(result.rangeAtIndex(2))
                let url = l.substringWithRange(result.rangeAtIndex(1))
                links[key] = url
            }
        }
        
        self.first = T(url: NSURL(string: links["first"]!))
        self.last = T(url: NSURL(string: links["last"]!))
        
        self.prev = flatMap(links["prev"]) { T(url: NSURL(string: $0)) }
        self.next = flatMap(links["next"]) { T(url: NSURL(string: $0)) }
        
        super.init(dict: dict)
    }
}
