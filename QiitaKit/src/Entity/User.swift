//
//  User.swift
//  QiitaKit
//
//  Created on 2015/06/08.
//  Copyright (c) 2015年 林達也. All rights reserved.
//

import Foundation

/**
*  Qiita上のユーザを表します。
*/
public struct User {
    public typealias Identifier = String
    
    /// 自己紹介文
    /// example: Hello, world.
    public let description: String?

    /// Facebook ID
    /// example: yaotti
    public let facebook_id: String?

    /// このユーザがフォローしているユーザの数
    /// example: 100
    public let followees_count: Int

    /// このユーザをフォローしているユーザの数
    /// example: 200
    public let followers_count: Int

    /// GitHub ID
    /// example: yaotti
    public let github_login_name: String?

    /// ユーザID
    /// example: yaotti
    public let id: Identifier

    /// このユーザが qiita.com 上で公開している投稿の数 (Qiita:Teamでの投稿数は含まれません)
    /// example: 300
    public let items_count: Int

    /// LinkedIn ID
    /// example: yaotti
    public let linkedin_id: String?

    /// 居住地
    /// example: Tokyo, Japan
    public let location: String?

    /// 設定している名前
    /// example: Hiroshige Umino
    public let name: String?

    /// 所属している組織
    /// example: Increments Inc
    public let organization: String?

    /// ユーザごとに割り当てられる整数のID
    /// example: 1
    public let permanent_id: Int

    /// 設定しているプロフィール画像のURL
    /// example: https://si0.twimg.com/profile_images/2309761038/1ijg13pfs0dg84sk2y0h_normal.jpeg
    public let profile_image_url: String

    /// Twitterのスクリーンネーム
    /// example: yaotti
    public let twitter_screen_name: String?

    /// 設定しているWebサイトのURL
    /// example: http://yaotti.hatenablog.com
    public let website_url: String?

}
