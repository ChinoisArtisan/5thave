//
//  UserListViewController.swift
//  FifthAve
//
//  Created by WANG Michael on 02/06/2015.
//  Copyright (c) 2015 emagid. All rights reserved.
//

import Foundation
import UIKit

enum UserListState {
    case Followers
    case Following
}

class UserListViewController: UIViewController, UITableViewDelegate, UITableViewDataSource, FollowUserProtocol{
    
    var tableView: UITableView = UITableView()
    var userlist: [PFObject] = []
    var deleted: [Bool] = []
    var user: PFUser?
    var state: UserListState = .Following
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        createtableview()
        createnavbarbutton()
        createnavtitle()
        
        tableView.tableFooterView = UIView()
        tableView.estimatedRowHeight = 100
        tableView.rowHeight = UITableViewAutomaticDimension
        
        tableView.registerClass(ProfileFollowCell.self, forCellReuseIdentifier: "ProfileFollowCell")
        
        if state == .Following {
            getFollowing()
        }
        else {
            getFollower()
        }
    }
    
    func createnavbarbutton() {
        let barbutton = NavButtonGenerator.sharedInstance.createdeletebutton()
        (barbutton.customView as! UIButton).addTarget(self, action: "dismissVC", forControlEvents: UIControlEvents.TouchUpInside)
        
        self.navigationItem.leftBarButtonItem = barbutton
    }
    
    func createnavtitle() {
        self.navigationItem.titleView = NavButtonGenerator.sharedInstance.createnavtitle("FOLLOWING")
        self.navigationItem.titleView?.sizeToFit()
    }
    
    func createtableview() {
        tableView.backgroundColor = AppColor.fifthGrayColor()
        tableView.delegate = self
        tableView.dataSource = self
        tableView.allowsSelection = false
        tableView.setTranslatesAutoresizingMaskIntoConstraints(false)
        tableView.separatorStyle = UITableViewCellSeparatorStyle.SingleLine
        
        let views = ["tableView": tableView]
        
        self.view.addSubview(tableView)
        self.view.addConstraints(NSLayoutConstraint.constraintsWithVisualFormat("V:|[tableView]|", options: NSLayoutFormatOptions(0), metrics: nil, views: views))
        self.view.addConstraints(NSLayoutConstraint.constraintsWithVisualFormat("H:|[tableView]|", options: NSLayoutFormatOptions(0), metrics: nil, views: views))
    }
    
    
    func dismissVC() {
        dismissViewControllerAnimated(true, completion: nil)
    }
    
    
    //MARK: Parse Query
    
    func getFollowing()
    {
        var query = PFQuery(className: "FollowUser")
        query.fromPinWithName("LinkFollowUser")
        query.includeKey("to")
        query.whereKey("from", equalTo: self.user!)
        query.findObjectsInBackgroundWithBlock { (objects: [AnyObject]?, error: NSError?) -> Void in
            if error == nil {
                if let objects = objects as? [PFObject] {
                    self.userlist = objects
                    self.deleted = Array(count: objects.count, repeatedValue: false)
                    self.tableView.reloadData()
                }
            }
            
            //Then check the data on network
            var query = PFQuery(className: "FollowUser")
            query.includeKey("to")
            query.whereKey("from", equalTo: self.user!)
            query.findObjectsInBackgroundWithBlock { (objects: [AnyObject]?, error: NSError?) -> Void in
                if error == nil {
                    if let objects = objects as? [PFObject] {
                        self.userlist = objects
                        self.deleted = Array(count: objects.count, repeatedValue: false)
                        self.tableView.reloadData()
                    }
                    
                    PFObject.unpinAllObjectsInBackgroundWithName("LinkFollowUser", block: { (done: Bool, error:NSError?) -> Void in
                        if error == nil {
                            PFObject.pinAllInBackground(objects, withName: "LinkFollowUser", block: nil)
                        }
                    })
                }
            }
        }
    }
    
    func getFollower()
    {
        var query = PFQuery(className: "FollowUser")
        query.fromPinWithName("FollowerUser")
        query.includeKey("from")
        query.whereKey("to", equalTo: self.user!)
        query.findObjectsInBackgroundWithBlock { (objects: [AnyObject]?, error: NSError?) -> Void in
            if error == nil {
                if let objects = objects as? [PFObject] {
                    self.userlist = objects
                    self.deleted = Array(count: objects.count, repeatedValue: false)
                    self.tableView.reloadData()
                }
            }
            
            //Then check the data on network
            var query = PFQuery(className: "FollowUser")
            query.includeKey("from")
            query.whereKey("to", equalTo: self.user!)
            query.findObjectsInBackgroundWithBlock { (objects: [AnyObject]?, error: NSError?) -> Void in
                if error == nil {
                    if let objects = objects as? [PFObject] {
                        self.userlist = objects
                        self.deleted = Array(count: objects.count, repeatedValue: false)
                        self.tableView.reloadData()
                    }
                    
                    PFObject.unpinAllObjectsInBackgroundWithName("FollowerUser", block: { (done: Bool, error:NSError?) -> Void in
                        if error == nil {
                            PFObject.pinAllInBackground(objects, withName: "FollowerUser", block: nil)
                        }
                    })
                }
            }
        }
    }
    
    
    
    //MARK: UITableViewDelegate and DataSource
    
    func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        var cell = tableView.dequeueReusableCellWithIdentifier("ProfileFollowCell") as! ProfileFollowCell
        
        cell.backgroundColor = UIColor.clearColor()
        Tools.sharedInstance.roundImageView(cell.userFollowImage, borderWitdh: 0.5, cornerRadius: 40.0 / 2.0)
        cell.userFollowImage.image = nil

        
        if state == .Following {
            cell.userFollowLabel.text = ParseQuery.sharedInstance.getName(userlist[indexPath.row]["to"] as! PFUser)
            if let profilimage = (userlist[indexPath.row]["to"] as! PFUser)["profileImage"] as? PFFile
            {
                cell.userFollowImage.file = profilimage
                cell.userFollowImage.loadInBackground { (image: UIImage?, error: NSError?) -> Void in
                    cell.userFollowImage.image = image
                }
            }
            cell.userFollowButton.hidden = false
        }
        else {
            cell.userFollowLabel.text = ParseQuery.sharedInstance.getName(userlist[indexPath.row]["from"] as! PFUser)
            if let profilimage = (userlist[indexPath.row]["from"] as! PFUser)["profileImage"] as? PFFile
            {
                cell.userFollowImage.file = profilimage
                cell.userFollowImage.loadInBackground { (image: UIImage?, error: NSError?) -> Void in
                    cell.userFollowImage.image = image
                }
            }
            cell.userFollowButton.hidden = (self.user != PFUser.currentUser())

        }
        

        cell.id = userlist[indexPath.row]
        cell.delegate = self
        
        return cell
    }
    
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection
        section: Int) -> Int {
        return userlist.count
    }
    
    func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
        return 75
    }
    
    
    func removeFollower(id: PFObject) {
        if self.user == PFUser.currentUser() {
            if let index = find(userlist, id) {
                if !deleted[index] {
                    deleted[index] = true
                    self.userlist[index].deleteInBackgroundWithBlock { (done: Bool, error: NSError?) -> Void in
                        if error == nil {
                            if let index = find(self.userlist, id) {
//                                var link: PFObject = self.userlist[index]
//                                var to: PFUser = link["to"] as! PFUser
//                                if let number = to["numberOfFollowers"] as? Int {
//                                    to["numberOfFollowers"] = number - 1
//                                }
                                
//                                ParseQuery.sharedInstance.saveUser((self.userlist[index]["to"] as! PFUser))
                                
                                self.deleted.removeAtIndex(index)
                                self.userlist.removeAtIndex(index)
                                self.tableView.deleteRowsAtIndexPaths([NSIndexPath(forRow: index, inSection: 0)] as [AnyObject], withRowAnimation: UITableViewRowAnimation.Left)
                                self.tableView.reloadData()
                            }
                            
//                            var from: PFUser = self.user!
//                            if let number = from["numberFollowing"] as? Int {
//                                from["numberFollowing"] = number - 1
//                            }
//                            ParseQuery.sharedInstance.saveUser(self.user!)
                        }
                        else
                        {
                            self.deleted[index] = false
                            self.tableView.reloadData()
                        }
                    }
                }
            }
        }
    }
    
}