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
    
    @IBOutlet private weak var stockButton: UIBarButtonItem!

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        
        self.navigationItem.rightBarButtonItem = self.stockButton
        
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
        
        Qiita.request(GetItemStock(item_id: item.id))
            .onSuccess { [weak self] _ in
                self?.refreshGetItemStock(true)
            }
            .onFailure { [weak self] _ in
                self?.refreshGetItemStock(false)
            }
        
        
//        Qiita
//            .flatMap(item) {
//                Qiita.request(CreateItemComment(item_id: $0.id, body: "a"))
//            }
//            .flatMap {
//                Qiita.request(UpdateComment(comment_id: $0.id, body: "b"))
//            }
//            .flatMap {
//                Qiita.request(DeleteComment(comment_id: $0.id))
//            }
//            .onSuccess {
//                Logging.d("")
//            }
    }
    
    private func refreshGetItemStock(b: Bool) {
        
        if b {
            self.stockButton.title = "Unstock"
        } else {
            self.stockButton.title = "Stock"
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

extension ItemViewController {

    @IBAction func toggleStockAction(sender: AnyObject) {
        
        switch self.stockButton.title! {
        case "Stock":
            Qiita.request(StockItem(item_id: item_id)).onSuccess { [weak self] _ in
                self?.refreshGetItemStock(true)
            }
        case "Unstock":
            Qiita.request(UnstockItem(item_id: item_id)).onSuccess { [weak self] in
                self?.refreshGetItemStock(false)
            }
        default:
            break
        }
        
    }
    
}


extension ItemViewController: Storyboardable {
    
    static var storyboardIdentifier: String {
        return "ItemViewController"
    }
    static var storyboardName: String {
        return "Main"
    }
}
