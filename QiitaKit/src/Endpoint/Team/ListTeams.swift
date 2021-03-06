//
//  ListTeams.swift
//  QiitaKit
//
//  Created on 2015/06/08.
//  Copyright (c) 2015年 林達也. All rights reserved.
//

import Foundation
import APIKit
import Result

/**
*  ユーザが所属している全てのチームを、チーム作成日時の降順で返します。
*/
public struct ListTeams {
    
    public let page: Int = 0
    public let per_page: Int = 0
    
    public init() {
    }
}

extension ListTeams: QiitaRequestToken {

    public typealias Response = ([Team], LinkMeta<ListTeams>)
    public typealias SerializedObject = [[String: AnyObject]]

    public var method: HTTPMethod {
        return .GET
    }

    public var path: String {
        return "/api/v2/teams"
    }
}

extension ListTeams: LinkProtocol {
    
    public init(url: NSURL!) {
    }
}

public extension ListTeams {
    
    func transform(request: NSURLRequest?, response: NSHTTPURLResponse?, object: SerializedObject) throws -> Response {
        
        let teams = object.map { object in
            Team(
                active: object["active"] as! Bool,
                id: object["id"] as! String,
                name: object["name"] as! String
            )
        }
        return (teams, LinkMeta<ListTeams>(dict: response!.allHeaderFields))
    }
}
