//
//  ListTagsViewController.swift
//  QiitaKit
//
//  Created by 林達也 on 2015/06/17.
//  Copyright (c) 2015年 林達也. All rights reserved.
//

import UIKit

class ListTagsViewController: UIViewController {
    
    @IBOutlet private weak var tableView: UITableView! {
        didSet {
            tableView.controller = TableController(responder: self)
        }
    }

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        let listTags = ListTags(page: "1", per_page: "100")
        Qiita.request(listTags).onSuccess { [weak self] tags, meta in
            self?.refreshListTags(tags)
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    private func refreshListTags(tags: [Tag]) {
        
        let rows = tags.map { tag -> TableRowBase in
            let row = UITableView.StyleDefaultRow(text: tag.id)
            row.didSelectAction = { [weak self] in
                let vc = from_storyboard(TagViewController.self)
                vc.tag_id = tag.id
                self?.navigationController?.pushViewController(vc, animated: true)
            }
            return row
        }
        
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
