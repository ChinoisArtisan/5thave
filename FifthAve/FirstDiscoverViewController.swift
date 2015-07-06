//
//  FirstDiscoverViewController.swift
//  FifthAve
//
//  Created by WANG Michael on 03/06/2015.
//  Copyright (c) 2015 emagid. All rights reserved.
//

import Foundation
import UIKit

class FirstDiscoverViewController: UIViewController, UITableViewDelegate, UITableViewDataSource, FollowUserProtocol{
    
    var titleLabel: UILabel = UILabel()
    var tableView: UITableView = UITableView()
    var continueButton: UIButton = UIButton()
    var skipButton: UIButton = UIButton()
    
    var userlist: [PFUser] = []
    var following: [Bool] = []
    var delegate: UIViewController?
    var isFollowBrand: Bool = false
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.view.backgroundColor = UIColor.blackColor()
        
        setUpNavigationBar()
        setUptitleLabel()
        setUpTableView()
        setUpContinueButton()
        setUpSkipButton()
        
        setUpContraints()
        getMyFollower()
    }
    
    
    //MARK: Initialisation view
    
    func setUpNavigationBar() {
        self.navigationItem.titleView = NavButtonGenerator.sharedInstance.createnavtitle("FOLLOW PEOPLE")
        self.navigationItem.titleView?.sizeToFit()
    }
    
    func setUptitleLabel() {
        titleLabel.setTranslatesAutoresizingMaskIntoConstraints(false)
        titleLabel.textAlignment = .Center
        titleLabel.backgroundColor = UIColor.grayColor()
        titleLabel.font = UIFont(name: "Montserrat-Regular", size: 15)
        titleLabel.textColor = UIColor.whiteColor()
        titleLabel.text = "FOLLOW YOUR FRIENDS"
        
        self.view.addSubview(titleLabel)
    }
    
    func setUpTableView() {
        
        tableView.backgroundColor = UIColor.clearColor()
        tableView.delegate = self
        tableView.dataSource = self
        tableView.allowsSelection = false
        tableView.setTranslatesAutoresizingMaskIntoConstraints(false)
        tableView.separatorStyle = UITableViewCellSeparatorStyle.SingleLine
        
        tableView.tableFooterView = UIView()
        tableView.estimatedRowHeight = 100
        tableView.rowHeight = UITableViewAutomaticDimension
        
        tableView.registerClass(ProfileFollowCell.self, forCellReuseIdentifier: "ProfileFollowCell")
        
        self.view.addSubview(tableView)
    }
    
    func setUpContinueButton() {
        continueButton.setTranslatesAutoresizingMaskIntoConstraints(false)
        continueButton.backgroundColor = UIColor.whiteColor()
        continueButton.setTitle("CONTINUE", forState: UIControlState.Normal)
        continueButton.setTitleColor(UIColor.blackColor(), forState: UIControlState.Normal)
        continueButton.titleLabel?.font = UIFont(name: "Montserrat-Bold", size: 16)
        
        continueButton.addTarget(self, action: "continueStep", forControlEvents: UIControlEvents.TouchUpInside)
        self.view.addSubview(continueButton)
    }
    
    func setUpSkipButton() {
        skipButton.setTranslatesAutoresizingMaskIntoConstraints(false)
        skipButton.backgroundColor = UIColor.clearColor()
        skipButton.setTitle("SKIP THIS STEP", forState: UIControlState.Normal)
        skipButton.setTitleColor(UIColor.whiteColor(), forState: UIControlState.Normal)
        skipButton.titleLabel?.font = UIFont(name: "Montserrat-Regular", size: 16)
        
        skipButton.addTarget(self, action: "skipStep", forControlEvents: UIControlEvents.TouchUpInside)
        self.view.addSubview(skipButton)
    }
    
    func setUpContraints() {
        let views = ["title": titleLabel, "table": tableView, "continue": continueButton, "skip": skipButton]
        
        self.view.addConstraints(NSLayoutConstraint.constraintsWithVisualFormat("V:|-10-[title(==30)]-20-[table]-20-[continue(==40)]-10-[skip(==30)]-20-|", options: NSLayoutFormatOptions(0), metrics: nil, views: views))
        
        self.view.addConstraints(NSLayoutConstraint.constraintsWithVisualFormat("H:|[title]|", options: NSLayoutFormatOptions(0), metrics: nil, views: views))
        self.view.addConstraints(NSLayoutConstraint.constraintsWithVisualFormat("H:|-20-[table]-20-|", options: NSLayoutFormatOptions(0), metrics: nil, views: views))
        self.view.addConstraint(NSLayoutConstraint(item: tableView, attribute: .Left, relatedBy: .Equal, toItem: continueButton, attribute: .Left, multiplier: 1, constant: -15))
        self.view.addConstraint(NSLayoutConstraint(item: tableView, attribute: .Right, relatedBy: .Equal, toItem: continueButton, attribute: .Right, multiplier: 1, constant: 15))

        self.view.addConstraint(NSLayoutConstraint(item: skipButton, attribute: .Right, relatedBy: .Equal, toItem: continueButton, attribute: .Right, multiplier: 1, constant: 0))
    }
    
    //MARK: Button action
    
    func continueStep() {
        if !isFollowBrand {
            self.dismissViewControllerAnimated(true, completion: { () -> Void in
                let vc = FirstDiscoverViewController()
                vc.isFollowBrand = true
                let nav = UINavigationController(rootViewController: vc)
                nav.navigationBar.translucent = false
                self.delegate!.presentViewController(nav, animated: true, completion: nil)
            })
        }
        else {
            self.dismissViewControllerAnimated(true, completion: nil)
        }
    }
    
    func skipStep() {
        self.dismissViewControllerAnimated(true, completion: nil)
    }
    
    
    //MARK: UITableView Delegate and Datasource

    
    func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        var cell = tableView.dequeueReusableCellWithIdentifier("ProfileFollowCell") as! ProfileFollowCell
        
        cell.backgroundColor = UIColor.clearColor()
        Tools.sharedInstance.roundImageView(cell.userFollowImage, borderWitdh: 0.5, cornerRadius: 40.0 / 2.0)
        
        if let facebookName: AnyObject = userlist[indexPath.row]["facebookName"] {
            cell.userFollowLabel.text = facebookName as? String
        }
        else {
            if let username: AnyObject = userlist[indexPath.row]["username"] {
                cell.userFollowLabel.text = username as? String
            }
        }
        
        cell.userFollowImage.image = nil
        if let profilimage = userlist[indexPath.row]["profileImage"] as? PFFile
        {
            cell.userFollowImage.file = profilimage
            cell.userFollowImage.loadInBackground { (image: UIImage?, error: NSError?) -> Void in
                cell.userFollowImage.image = image
            }
        }
        cell.id = userlist[indexPath.row]
        cell.delegate = self
        
        if following[indexPath.row] {
            cell.userFollowButton.setTitle("FOLLOWING", forState: UIControlState.Normal)
        }
        else {
            cell.userFollowButton.setTitle("+   FOLLOW", forState: UIControlState.Normal)
        }
        
        return cell
    }
    
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        //DO NOTHING
    }
    
    func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
        return 70
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return userlist.count
    }

    
    
    //MARK: Parse Query
    
    func getMyFollower() {
        var query = PFQuery(className: "_User")
        query.fromPinWithName("User")
        query.findObjectsInBackgroundWithBlock { (objects: [AnyObject]?, error: NSError?) -> Void in
            if error == nil {
                if let objects = objects as? [PFUser] {
                    self.userlist = []
                    for object in objects {
                        if object != PFUser.currentUser() {
                            self.userlist.append(object)
                        }
                    }
                    self.following = Array(count: objects.count, repeatedValue: false)
                    self.tableView.reloadData()
                }
            }
            
            //Then check the data on network
            var query = PFQuery(className: "_User")
            query.findObjectsInBackgroundWithBlock { (objects: [AnyObject]?, error: NSError?) -> Void in
                if error == nil {
                    if let objects = objects as? [PFUser] {
                        self.userlist = []
                        for object in objects {
                            if object != PFUser.currentUser() {
                                self.userlist.append(object)
                            }
                        }
                        self.following = Array(count: objects.count, repeatedValue: false)
                        self.tableView.reloadData()
                    }
                    
                    PFObject.unpinAllObjectsInBackgroundWithName("User", block: { (done: Bool, error:NSError?) -> Void in
                        if error == nil {
                            PFObject.pinAllInBackground(objects, withName: "User", block: nil)
                        }
                    })
                }
            }
        }
    }
    
    func removeFollower(id: PFObject) {
        if let index = find(userlist, id as! PFUser) {
            if !following[index] {
                following[index] = true
                self.tableView.reloadData()

                var follow = PFObject(className: "FollowUser")
                follow["from"] = PFUser.currentUser()
                follow["to"] = self.userlist[index]
                follow.saveEventually( { (done: Bool, error: NSError?) -> Void in
                    if error != nil {
                        println(error)
                    }
                })
            }
        }
    }
}