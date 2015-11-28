//
//  AccessTokenViewController.swift
//  QiitaKit
//
//  Created by 林達也 on 2015/06/14.
//  Copyright (c) 2015年 林達也. All rights reserved.
//

import UIKit
import QiitaKit
import ToysBoxKit
import BrightFutures

class AccessTokenViewController: UIViewController {
    
    @IBOutlet weak var getNewAccessTokenButton: UIButton! {
        didSet {
            let b = getNewAccessTokenButton
            b.layer.shadowRadius = 5.0
            b.layer.shadowColor = UIColor(red:0.14, green:0.46, blue:0.69, alpha:1).CGColor
            b.layer.shadowOffset = CGSize(width: 0, height: 2.5)
        }
    }
    
    @IBOutlet weak var deleteAccessTokenButton: UIButton! {
        didSet {
            let b = deleteAccessTokenButton
            b.layer.shadowRadius = 5.0
            b.layer.shadowColor = UIColor(red:0.72, green:0.19, blue:0.15, alpha:1).CGColor
            b.layer.shadowOffset = CGSize(width: 0, height: 2.5)
        }
    }
    
    @IBOutlet weak var accessTokenLabel: UILabel! {
        didSet {
            
        }
    }

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        
        if let accessToken = Qiita.accessToken {
            accessTokenLabel.text = accessToken.token
        } else {
            accessTokenLabel.alpha = 0
            deleteAccessTokenButton.alpha = 0
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction
    private func getNewAccessTokenAction(sender: AnyObject) {
        Qiita.oauthAuthorize([.ReadQiita, .WriteQiita], scheme: ENV.DEMO_QIITA_CALLBACK_URL)
            .onSuccess { [weak self] accessToken in
                self?.accessTokenLabel.text = accessToken.token
                self?.saveAccessToken(accessToken)
                async_after(0.5) {
                    UIView.animateWithDuration(0.3, animations: {
                        self?.accessTokenLabel.alpha = 1
                        self?.deleteAccessTokenButton.alpha = 1
                    })
                }
            }
    }
    
    @IBAction
    private func deleteAccessTokenAction() {
        
        Qiita.oauthDelete().onSuccess(ImmediateOnMainExecutionContext) { [weak self] _ in
            
            UIView.animateWithDuration(0.3, animations: {
                self?.accessTokenLabel.alpha = 0
                self?.deleteAccessTokenButton.alpha = 0
                self?.deleteAccessToken()
            })
        }
    }
    
    private func saveAccessToken(accessToken: AccessToken) {
        let defaults = NSUserDefaults.standardUserDefaults()
        
        defaults.setObject([
            "token": accessToken.token,
            "scopes": accessToken.scopes,
            "client_id": accessToken.client_id
            ], forKey: "AccessToken")
        
        defaults.synchronize()
    }
    
    private func deleteAccessToken() {
        let defaults = NSUserDefaults.standardUserDefaults()
        defaults.removeObjectForKey("AccessToken")
        
        defaults.synchronize()
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

extension AccessTokenViewController: Storyboardable {
    
    static var storyboardName: String {
        return "Main"
    }
}
