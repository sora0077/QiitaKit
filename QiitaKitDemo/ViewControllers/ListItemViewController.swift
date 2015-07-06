//
//  ListItemViewController.swift
//  QiitaKit
//
//  Created by 林達也 on 2015/06/14.
//  Copyright (c) 2015年 林達也. All rights reserved.
//

import UIKit

class ListItemViewController: UIViewController {
    
    
    @IBOutlet weak var tableView: UITableView! {
        didSet {
            tableView.controller = TableController(responder: self)
        }
    }

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        let listAuthenticatedUserItems = ListAuthenticatedUserItems(page: "1", per_page: "100")
        Qiita.request(listAuthenticatedUserItems).onSuccess { [weak self] items, meta in
            self?.refreshListAuthenticatedUserItems(items)
            println(meta.first)
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    private func refreshListAuthenticatedUserItems(items: [Item]) {
        
        let rows = items.map { item -> TableRowBase in
            let row = UITableView.StyleSubtitleRow(text: item.title, detailText: item.body)
            row.didSelectAction = { [weak self] in
                let vc = from_storyboard(ItemViewController.self)
                vc.item_id = item.id
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
