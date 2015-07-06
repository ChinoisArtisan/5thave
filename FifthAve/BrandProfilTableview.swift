//
//  BrandProfilTableview.swift
//  5thAve
//
//  Created by WANG Michael on 07/05/2015.
//  Copyright (c) 2015 emagid. All rights reserved.
//

import Foundation
import UIKit

class BrandProfilTableview: UITableViewController{
    
    var data: [String] = ["NEW ARRIVALS", "SUMMER CLOTHES", "WINTER CLOTHES"]
    var delegate: BrandViewController?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.tableView.tableFooterView = UIView()
        
    }
    
    override func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 1
    }
    
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell: BrandProfilTablecell = tableView.dequeueReusableCellWithIdentifier(BrandProfilTablecellID, forIndexPath: indexPath) as! BrandProfilTablecell
        
        cell.collectionname.text = data[indexPath.row]
        cell.collectionimage.image = UIImage(named: "EFM_Launch.jpg")
        
        return cell
    }
    
    override func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        // BrandViewController change view to the tableview with the collection
        self.delegate?.pushList(data[indexPath.row])
    }
    
    override func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
        return 135.0
    }
    
    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return data.count
    }
    
    
}