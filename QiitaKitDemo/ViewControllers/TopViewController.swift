//
//  TopViewController.swift
//  QiitaKit
//
//  Created by 林達也 on 2015/06/13.
//  Copyright (c) 2015年 林達也. All rights reserved.
//

import UIKit

class TopViewController: UIViewController {
    
    @IBOutlet weak var tableView: UITableView! {
        didSet {
            tableView.controller = TableController(responder: self)
        }
    }

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        
        let categories = [
            "AccessToken",
            "AuthenticatedUser",
            "Comment",
            "ExpandedTemplate",
            "ListItem",
            "Project",
            "Tag",
            "Tagging",
            "Team",
            "Template",
            "User",
        ]
        
        if let section = tableView.controller.sections.first {
            section.extend(
                categories.map { c in
                    let row = UITableView.StyleDefaultRow(text: c)
                    row.didSelectAction = { [weak self] _ in
                        self?.segue(c)
                    }
                    return row
                }
            )
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    private func segue(name: String) {
        let f = self.storyboard?.instantiateViewControllerWithIdentifier
        let vc = f?("\(name)ViewController") as! UIViewController
        self.navigationController?.pushViewController(vc, animated: true)
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
