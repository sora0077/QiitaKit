//
//  Team.swift
//  QiitaKit
//
//  Created on 2015/06/08.
//  Copyright (c) 2015年 林達也. All rights reserved.
//

import Foundation

/**
*  Qiita:Team上で所属しているチームを表します。Qiita:Teamでのみ有効です。
*/
public struct Team {
    /// チームが利用可能な状態かどうか
    /// example: true
    public let active: Bool

    /// チームの一意なID
    /// example: increments
    public let id: String

    /// チームに設定されている名前を表します。
    /// example: Increments Inc.
    public let name: String

}
