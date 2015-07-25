//
//  CreateAccessToken.swift
//  QiitaKit
//
//  Created on 2015/06/08.
//  Copyright (c) 2015年 林達也. All rights reserved.
//

import Foundation
import APIKit
import Result

/**
*  与えられた認証情報をもとに新しいアクセストークンを発行します。
*/
public struct CreateAccessToken {
    /// 登録されたAPIクライアントを特定するためのID
    /// example: a91f0396a0968ff593eafdd194e3d17d32c41b1da7b25e873b42e9058058cd9d
    /// ^[0-9a-f]{40}$
    public let client_id: String

    /// 登録されたAPIクライアントを認証するための秘密鍵
    /// example: 01fc259c31fe39e72c8ef911c3432a33d51e9337ff34c4fac86c491a0d37251f
    /// ^[0-9a-f]{40}$
    public let client_secret: String

    /// リダイレクト用のURLに付与された、アクセストークンと交換するための文字列
    /// example: fefef5f067171f247fb415e38cb0631797b82f4141dcdee66db846c3ade57a03
    /// ^[0-9a-f]{40}$
    public let code: String

    public init(client_id: String, client_secret: String, code: String) {
        self.client_id = client_id
        self.client_secret = client_secret
        self.code = code
    }
}

extension CreateAccessToken: RequestToken {

    public typealias Response = AccessToken
    public typealias SerializedType = [String: AnyObject]

    public var method: HTTPMethod {
        return .POST
    }

    public var URL: String {
        return "/api/v2/access_tokens"
    }

    public var parameters: [String: AnyObject]? {
        return [
            "client_id": client_id,
            "client_secret": client_secret,
            "code": code
        ]
    }

    public var encoding: RequestEncoding {
        return .JSON
    }

    public var resonseEncoding: ResponseEncoding {
        return .JSON(.AllowFragments)
    }
}

extension CreateAccessToken {
    
    public static func transform(request: NSURLRequest, response: NSHTTPURLResponse?, object: SerializedType) -> Response {
        
        let accessToken = AccessToken(
            client_id: object["client_id"] as! String,
            scopes: object["scopes"] as! Array<String>,
            token: object["token"] as! String
        )
        return accessToken
    }
}
