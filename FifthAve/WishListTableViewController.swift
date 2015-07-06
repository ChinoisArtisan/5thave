//
//  WishListTableViewController.swift
//  5thAve
//
//  Created by Johnny Heusser  on 4/30/15.
//  Copyright (c) 2015 Beyond 2021. All rights reserved.
//

import UIKit

class WishListTableViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {
    
    var tableView: UITableView = UITableView()
    var cellInfo: String = String()
    
    override func viewDidLoad() {
        
        super.viewDidLoad()
        setUpTableView()
        tableView.registerClass(WishListTableViewCell.self, forCellReuseIdentifier: "wishCell")
        tableView.registerClass(CollectionsTableViewCell.self, forCellReuseIdentifier: "collectionsCell")
        NSNotificationCenter.defaultCenter().addObserver(self, selector: "setWishCellInfo", name: wishListNotifKey, object: nil)
        NSNotificationCenter.defaultCenter().addObserver(self, selector: "setCollectionsCellInfo", name: collectionsNotifKey, object: nil)
    }
    
    func setUpTableView () {
        
        tableView.backgroundColor = AppColor.fifthGrayColor()
        tableView.delegate = self
        tableView.dataSource = self
        tableView.setTranslatesAutoresizingMaskIntoConstraints(false)
        tableView.separatorStyle = .None

        let views = ["tableView": tableView]
        
        self.view.addSubview(tableView)
        self.view.addConstraints(NSLayoutConstraint.constraintsWithVisualFormat("V:|[tableView]|", options: NSLayoutFormatOptions(0), metrics: nil, views: views))
        self.view.addConstraints(NSLayoutConstraint.constraintsWithVisualFormat("H:|[tableView]|", options: NSLayoutFormatOptions(0), metrics: nil, views: views))
    }
    
    func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
        
        return 60
    }
    
    
    func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        
        return 1
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return 10
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        
        
    if cellInfo == "wishCell" {
        var cell = tableView.dequeueReusableCellWithIdentifier("wishCell") as! WishListTableViewCell
        
        cell.backgroundColor = UIColor.clearColor()
        cell.wishImageView.image = UIImage(named: "Looks_Cell")
        cell.wishItemLabel.text = "Gucci Dress"
        
        return cell
    }
    else if cellInfo == collectionsNotifKey {
        
        var cell = tableView.dequeueReusableCellWithIdentifier("collectionsCell") as! CollectionsTableViewCell
        cell.backgroundColor = UIColor.clearColor()
        cell.collectionsImageView.image = UIImage(named: "Looks_Cell")
        cell.collectionsItemLabel.text = "Gucci Dress"
        
        return cell
    }
    else {
        
        //  default cell will go here
        var cell = tableView.dequeueReusableCellWithIdentifier("wishCell") as! WishListTableViewCell
        
        cell.backgroundColor = UIColor.clearColor()
        cell.wishImageView.image = UIImage(named: "Looks_Cell")
        cell.wishItemLabel.text = "Gucci Dress"
        
        return cell
        }
    }

    
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        
     
    }
    
    func setWishCellInfo () {
        cellInfo = wishListNotifKey
    }
    
    func setCollectionsCellInfo () {
        cellInfo = collectionsNotifKey
    }

}
