//
//  BrandListCategorie.swift
//  5thAve
//
//  Created by WANG Michael on 07/05/2015.
//  Copyright (c) 2015 emagid. All rights reserved.
//

import Foundation
import UIKit

class BrandListCategorie: UIViewController, UITableViewDelegate, UITableViewDataSource, navaction{
    
    @IBOutlet weak var searchbar: UISearchBar!
    @IBOutlet weak var listcategories: UITableView!
    
    var name: String = ""
    var list: [String] = ["SHIRTS", "PANTS", "SHORTS", "SHOES"]
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.listcategories.tableFooterView = UIView()
        
        self.navigationItem.leftBarButtonItem = NavButtonGenerator.sharedInstance.createbackbutton(self)
        self.navigationItem.titleView = NavButtonGenerator.sharedInstance.createnavtitle(name)
        self.navigationItem.titleView?.sizeToFit()
    }
    
    func backaction() {
        self.navigationController?.popViewControllerAnimated(true)
    }
    
    override func viewWillDisappear(animated: Bool) {
        super.viewWillDisappear(animated)
    }
    
    func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell: UITableViewCell = tableView.dequeueReusableCellWithIdentifier(BrandCategorieCellID, forIndexPath: indexPath) as! UITableViewCell
        cell.textLabel?.text = list[indexPath.row]
        
        return cell
    }
    
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        tableView.deselectRowAtIndexPath(indexPath, animated: true)
        let vc = (storyboard!.instantiateViewControllerWithIdentifier(BrandViewControllerID) as! BrandViewController)
        (vc as BrandViewController).isPosts = false
        (vc as BrandViewController).shopstate = .shopcollection
        self.navigationController?.pushViewController(vc, animated: true)
    }
    
    func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
        return 44.0
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return list.count
    }
    
}