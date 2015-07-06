//
//  BrandStoreViewController.swift
//  5thAve
//
//  Created by WANG Michael on 07/05/2015.
//  Copyright (c) 2015 emagid. All rights reserved.
//

import Foundation
import UIKit

class BrandStoreViewController: UIViewController, UITableViewDelegate, UITableViewDataSource, navaction{
    
    var brandlist: [String] = ["GUCCI", "FENDI", "CHANEL"]
    @IBOutlet weak var searchbar: UISearchBar!
    @IBOutlet weak var brandlisttableview: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.navigationItem.leftBarButtonItem = NavButtonGenerator.sharedInstance.createbackbutton(self)
        self.navigationItem.titleView = NavButtonGenerator.sharedInstance.createnavtitle("BRAND STORES")
        self.navigationItem.titleView?.sizeToFit()
    }
    
    
    //MARK:  Navaction protocol
    
    func backaction() {
        self.navigationController?.popViewControllerAnimated(true)
    }
    
    
    //MARK: Tableview delegate and datasource
    
    func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell: BrandStoreCell = tableView.dequeueReusableCellWithIdentifier(BrandStoreCellID, forIndexPath: indexPath) as! BrandStoreCell
        
        cell.username.text = brandlist[indexPath.row]
        Tools.sharedInstance.roundImageView(cell.userimage, borderWitdh: 0.5)
        
        
        cell.leftimage.image = UIImage(named: "EFM_Launch.jpg")
        cell.centerimage.image = UIImage(named: "EFM_Launch.jpg")
        cell.rightimage.image = UIImage(named: "EFM_Launch.jpg")
        
        return cell
    }
    
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        tableView.deselectRowAtIndexPath(indexPath, animated: true)
        let vc = (UIStoryboard(name: "Main", bundle: nil).instantiateViewControllerWithIdentifier(BrandViewControllerID) as! BrandViewController)
        (vc as BrandViewController).isPosts = false
        (vc as BrandViewController).shopstate = .shoptable
        self.navigationController?.pushViewController(vc, animated: true)
    }
    
    func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
        return 170.0
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return brandlist.count
    }
    
}