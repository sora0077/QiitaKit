//
//  TagViewController.swift
//  QiitaKit
//
//  Created by 林達也 on 2015/06/17.
//  Copyright (c) 2015年 林達也. All rights reserved.
//

import UIKit

extension Tag {
    
    var _dict: [String: AnyObject?] {
        return [
            "followers_count": followers_count,
            "icon_url": icon_url,
            "id": id,
            "items_count": items_count
        ]
    }
}

class TagViewController: UIViewController {
    
    var tag_id: String!
    
    @IBOutlet private weak var followBarButton: UIBarButtonItem!
    @IBOutlet private weak var tableView: UITableView! {
        didSet {
            tableView.controller = TableController(responder: self)
        }
    }

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        
        let getTag = GetTag(tag_id: tag_id)
        Qiita.request(getTag).onSuccess { [weak self] in
            self?.refreshGetTag($0)
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    private func refreshGetTag(tag: Tag) {
        
        let rows = tag._dict.map {
            UITableView.StyleValue2Row(text: $0, detailText: $1.map({ "\($0)" }) ?? "nil")
        }
        
        if let section = tableView.controller.sections.first {
            section.removeAll()
            section.extend(rows)
        }
        
        let getTagFollowing = GetTagFollowing(tag_id: tag.id)
        Qiita.request(getTagFollowing).onSuccess { [weak self] in
            self?.refreshGetTagFollowing($0)
        }
    }
    
    private func refreshGetTagFollowing(b: Bool) {
        
        followBarButton.title = b ? "unfollow" : "follow"
        
    }
    
    private func refreshUnfollowTag() {
        
        followBarButton.title = "follow"
    }
    
    private func refreshFollowTag() {
        
        followBarButton.title = "unfollow"
    }
    
    @IBAction func toggleFollowAction(sender: AnyObject) {
        
        if let title = followBarButton.title {
            switch title {
            case "unfollow":
                let unfollowTag = UnfollowTag(tag_id: tag_id)
                Qiita.request(unfollowTag).onSuccess { [weak self] _ in
                    self?.refreshUnfollowTag()
                }
            case "follow":
                let followTag = FollowTag(tag_id: tag_id)
                Qiita.request(followTag).onSuccess { [weak self] _ in
                    self?.refreshFollowTag()
                }
            default:
                break
            }
        }
    }

}

extension TagViewController: Storyboardable {
    
    static var storyboardIdentifier: String {
        return "TagViewController"
    }
    static var storyboardName: String {
        return "Main"
    }
}
