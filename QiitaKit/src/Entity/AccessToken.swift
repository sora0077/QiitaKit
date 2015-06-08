//
//  AccessToken.swift
//  QiitaKit
//
//  Created on 2015/06/08.
//  Copyright (c) 2015年 林達也. All rights reserved.
//

import Foundation

/**
*  Qiita API v2で認証・認可を行うためのアクセストークンを表します。
*/
public struct AccessToken {
    /// 登録されたAPIクライアントを特定するためのID
    /// example: a91f0396a0968ff593eafdd194e3d17d32c41b1da7b25e873b42e9058058cd9d
    public let client_id: String

    /// アクセストークンに許された操作の一覧
    /// example: read_qiita
    public let scopes: Array<String>

    /// アクセストークンを表現する文字列
    /// example: ea5d0a593b2655e9568f144fb1826342292f5c6b7d406fda00577b8d1530d8a5
    public let token: String

}
