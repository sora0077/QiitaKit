//
//  ItemViewController.swift
//  QiitaKit
//
//  Created by 林達也 on 2015/06/14.
//  Copyright (c) 2015年 林達也. All rights reserved.
//

import UIKit

extension Item {
    
    var _dict: [String: AnyObject?] {
        return [
            "rendered_body": rendered_body,
            "body": body,
            "coediting": coediting,
            "created_at": created_at,
            "id": id,
            "private": `private`,
            "title": title,
            "updated_at": updated_at,
            "url": url,
        ]
    }
    
}


class ItemViewController: UIViewController {
    
    var item_id: String!
    
    @IBOutlet private weak var tableView: UITableView! {
        didSet {
            tableView.controller = TableController(responder: self)
        }
    }

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        
        let getItem = GetItem(item_id: item_id)
        Qiita.request(getItem).onSuccess { [weak self] in
            self?.refreshGetItem($0)
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    private func refreshGetItem(item: Item) {
        
        if let section = tableView.controller.sections.first {
            section.removeAll()
            let rows = item._dict.map {
                UITableView.StyleValue2Row(text: $0, detailText: $1.map({ "\($0)" }) ?? "nil")
            }
            section.extend(rows)
            section.extend(item.tags.map { tag in
                let row = UITableView.StyleValue2Row(text: "tags", detailText: tag.name)
                row.didSelectAction = { [weak self] in
                    self?.segueTagView(tag)
                }
                return row
            })
        }
    }
    
    private func segueTagView(tagging: Tagging) {
        
        let vc = from_storyboard(TagViewController.self)
        vc.tag_id = tagging.name
        
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

extension ItemViewController: Storyboardable {
    
    static var storyboardIdentifier: String {
        return "ItemViewController"
    }
    static var storyboardName: String {
        return "Main"
    }
}
