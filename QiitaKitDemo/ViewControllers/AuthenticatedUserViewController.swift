//
//  AuthenticatedUserViewController.swift
//  QiitaKit
//
//  Created by 林達也 on 2015/06/14.
//  Copyright (c) 2015年 林達也. All rights reserved.
//

import UIKit

extension AuthenticatedUser {
    
    var _dict: [String: AnyObject?] {
        return [
            "github_login_name": github_login_name,
            "id": id,
            "description": description,
            "facebook_id": facebook_id,
            "followees_count": followees_count,
            "followers_count": followers_count,
            "items_count": items_count,
            "linkedin_id": linkedin_id,
            "location": location,
            "name": name,
            "organization": organization,
            "permanent_id": permanent_id,
            "profile_image_url": profile_image_url,
            "twitter_screen_name": twitter_screen_name,
            "website_url": website_url,
            "image_monthly_upload_limit": image_monthly_upload_limit,
            "image_monthly_upload_remaining": image_monthly_upload_remaining,
            "team_only": team_only,
        ]
    }
}

class AuthenticatedUserViewController: UIViewController {
    
    
    @IBOutlet var headerView: UIView!
    
    @IBOutlet weak var getAuthenticatedUserButton: MKButton! {
        didSet {
            let b = getAuthenticatedUserButton
            b.layer.shadowRadius = 5.0
            b.layer.shadowColor = UIColor(red:0.14, green:0.46, blue:0.69, alpha:1).CGColor
            b.layer.shadowOffset = CGSize(width: 0, height: 2.5)
        }
    }
    
    @IBOutlet weak var tableView: UITableView! {
        didSet {
            tableView.controller = TableController(responder: self)
        }
    }

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        
        if Qiita.accessToken == nil {
            getAuthenticatedUserButton.hidden = true
        } else {
            tableView.tableHeaderView = headerView
        }
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    @IBAction
    private func getAuthenticatedUserAction(sender: AnyObject) {
        
        
        let getAuthenticatedUser = GetAuthenticatedUser()
        Qiita.request(getAuthenticatedUser)
            .onSuccess { [weak self] in
                self?.refreshAuthenticatedUser($0)
            }
    }
    
    private func refreshAuthenticatedUser(user: AuthenticatedUser) {
        
        let rows = user._dict.map({
            UITableView.StyleSubtitleRow(text: $0, detailText: $1.map({ "\($0)" }) ?? "nil")
        })
        if let section = tableView.controller.sections.first {
            section.removeAll()
            section.extend(rows)
        }
    }
    
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
