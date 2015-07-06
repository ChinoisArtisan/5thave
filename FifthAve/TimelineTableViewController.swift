//
//  TimelineTableViewController.swift
//  5thAve
//
//  Created by WANG Michael on 23/04/2015.
//  Copyright (c) 2015 Beyond 2021. All rights reserved.
//

import Foundation
import UIKit



class TimelineTableViewController: PFQueryTableViewController {
    
    //Data must be changed by real one
        
    var data: [Bool] = Array(count: 0, repeatedValue: false)
    var comments: [[PFObject]] = Array(count: 0, repeatedValue: [])
    
    var delegate: TimelineProtocol?
    var followuser: [PFUser] = []
    
    var tablequery: PFQuery?
    
    var alertView: UIView = UIView()
    var checkLocalStore: Bool = false
    var firstrequest: Bool = false
    
    //MARK: Initialise
    override init(style: UITableViewStyle, className: String!) {
        super.init(style: style, className: className)
    }

    required init!(coder aDecoder: NSCoder!) {
        super.init(coder: aDecoder)
        
        // Configure the PFQueryTableView
        self.parseClassName = "Post"
        
        self.pullToRefreshEnabled = true
        self.paginationEnabled = false
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        getMyFollower()
        
        NSNotificationCenter.defaultCenter().addObserver(self, selector:"reloadLikes",  name:"GetLikes", object:nil);
    }
    
    //MARK: - PFQueryTableViewController
    
    
    override func queryForTable() -> PFQuery {
        var query = localRequestPost()
        
        return query
    }
    
    override func objectsWillLoad() {
        super.objectsWillLoad()
        
    }
    
    override func loadObjects(page: Int, clear: Bool) {
        if followuser.count != 0 {
            super.loadObjects(page, clear: true)
            getPostFromFollower()
        }
        else {
            self.createAlertNoFollower()
        }
    }
    
    override func objectsDidLoad(error: NSError?) {
        super.objectsDidLoad(error)
        
        data = Array(count: self.objects!.count, repeatedValue: false)
        comments = Array(count: self.objects!.count, repeatedValue: [])
        
        for object in self.objects as! [PFObject] {
            getComments(object)
        }
        
        if self.objects!.count == 0 && self.checkLocalStore && self.firstrequest{
            self.createAlertNoFollower()
        }
        else {
            self.alertView.removeFromSuperview()
        }
        
    }
    
    override func objectAtIndexPath(indexPath: NSIndexPath?) -> PFObject? {
        let object: AnyObject = self.objects![indexPath!.section]

        return object as? PFObject
    }
    
    
    
    //MARK:  TableviewSection
    override func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return self.objects!.count
    }
    
    override func tableView(tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let cell: MainTimelineHeaderCell = tableView.dequeueReusableCellWithIdentifier(MainTimelineHeaderCellID) as! MainTimelineHeaderCell
        let postuser = self.objects![section]["user"] as! PFUser
        
        if let facebookName: AnyObject = postuser["facebookName"] {
            cell.Username.text = facebookName as? String
        }
        else {
            if let username: AnyObject = postuser["username"] {
                cell.Username.text = username as? String
            }
        }
        
        cell.ProfilPicture.image = nil
        if let profilimage = postuser["profileImage"] as? PFFile
        {
            cell.ProfilPicture.file = profilimage
                cell.ProfilPicture.loadInBackground { (image: UIImage?, error: NSError?) -> Void in
                    cell.ProfilPicture.image = image
            }
        }
        
        Tools.sharedInstance.roundImageView(cell.ProfilPicture, borderWitdh: 0.5)
        
        cell.index = section
        cell.delegate = self
        cell.PostTime.text = Tools.sharedInstance.diff(self.objects![section].createdAt!!)
        
        return cell
    }
    
    
    override func tableView(tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 44.0
    }
    
    
    //MARK: TableView Delegate and Datasource
    override func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        // DO NOTHING
    }
    
    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }

    override func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
        return 547.0
    }
    
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath, object: PFObject?) -> PFTableViewCell? {
        var cell = tableView.dequeueReusableCellWithIdentifier(MainTimelineCellID, forIndexPath: indexPath) as! MainTimelineCell
        cell.table = self

        
        if let postImage = object!["postImage"] as? PFFile
        {
            cell.PostImage.file = postImage
        }
        cell.PostImage.image = nil
        cell.PostImage.loadInBackground({ (image: UIImage?, error: NSError?) -> Void in
            if error == nil {
                cell.PostImage.image = image
                cell.imagesize = image!.size
            }
            else {
                println(error?.description)
            }
        })
        
        if let likes = object!["numberOfLikes"] as? Int
        {
            cell.NumberOfLike.text = String(likes)
        }
        else
        {
            cell.NumberOfLike.text = "0"
        }
        
        cell.comments = self.comments[indexPath.section]
        cell.commentTableView.reloadData()
        
        cell.moreButton.addTarget(cell, action: "setUpMoreButton", forControlEvents: UIControlEvents.TouchUpInside)
        cell.cartButton.addTarget(self, action: "showCartView", forControlEvents: UIControlEvents.TouchUpInside)
        
        if let list = object!["postTags"] as? [PFObject] {
            cell.listoftag = list
        }
        else {
            cell.listoftag = []
        }
        
        var query = PFQuery(className: "Likes")
        query.fromPinWithName("Likes")
        query.whereKey("userPost", equalTo: PFUser.currentUser()!)
        query.whereKey("post", equalTo: object!)
        query.getFirstObjectInBackgroundWithBlock { (object: PFObject?, error: NSError?) -> Void in
            if error == nil {
                cell.likeButton.setImage(UIImage(named: "heartfilled.png"), forState: UIControlState.Normal)
                cell.liked = true
            }
            else {
                cell.likeButton.setImage(UIImage(named: "heartoutline.png"), forState: UIControlState.Normal)
                cell.liked = false
            }
        }
        
        cell.post = object
        cell.index = indexPath.section
        cell.showPopover(data[indexPath.section])
        
        return cell
    }
    
    func checkLikedPost (post: PFObject) {
        //Make a resquest to check if I already liked the picture
        var query = PFQuery(className: "Likes")
        query.fromPinWithName("Likes")
        query.whereKey("userPost", equalTo: PFUser.currentUser()!)
        query.whereKey("post", equalTo: post)
        query.getFirstObjectInBackgroundWithBlock { (object: PFObject?, error: NSError?) -> Void in
            if error != nil {
                var query = PFQuery(className: "Likes")
                query.whereKey("userPost", equalTo: PFUser.currentUser()!)
                query.whereKey("post", equalTo: post)
                query.getFirstObjectInBackgroundWithBlock { (object: PFObject?, error: NSError?) -> Void in
                    if error != nil {
                        
                    }
                }
            }
        }
    }
    
    func likePost (post: PFObject) {
        //Make a resquest to check if I already liked the picture
        var query = PFQuery(className: "Likes")
        query.fromPinWithName("Likes")
        query.whereKey("userPost", equalTo: PFUser.currentUser()!)
        query.whereKey("post", equalTo: post)
        query.getFirstObjectInBackgroundWithBlock { (object: PFObject?, error: NSError?) -> Void in
            if error != nil {
                var query = PFQuery(className: "Likes")
                query.whereKey("userPost", equalTo: PFUser.currentUser()!)
                query.whereKey("post", equalTo: post)
                query.getFirstObjectInBackgroundWithBlock { (object: PFObject?, error: NSError?) -> Void in
                    if error != nil {
                        self.addLike(post)
                    }
                }
            }
        }
    }
    
    func addLike (post: PFObject) {
        //Increase the number of likes
        post.fetchInBackgroundWithBlock { (post: PFObject?, error: NSError?) -> Void in
            if let likes = post!["numberOfLikes"] as? Int {
                post!.incrementKey("numberOfLikes")
            }
            else {
                post!["numberOfLikes"] = 1
            }
            post!.saveEventually { (done: Bool, error: NSError?) -> Void in
                if error == nil {
                    self.reloadLikes()
                }
            }
            
            //Add the link between the post and user
            var like = PFObject(className: "Likes")
            like["post"] = post!
            like["userPost"] = PFUser.currentUser()!
            like.saveEventually { (done: Bool, error: NSError?) -> Void in
                PFObject.pinAllInBackground([like], withName: "Likes", block: { (done:Bool, error: NSError?) -> Void in
                    if error == nil {
                        self.reloadLikes()
                    }
                })
            }
        }
    }
    
    
    func showCartView ()
    {
        let vc = (UIStoryboard(name: "Main", bundle: nil).instantiateViewControllerWithIdentifier(AddToCartViewControllerID) as! AddToCartViewController)
        self.navigationController?.pushViewController(vc, animated: true)
    }
    
    func showProfile(index: Int)
    {
        let vc = UIStoryboard(name: "Main", bundle: nil).instantiateViewControllerWithIdentifier(ProfilViewControllerID) as! ProfilViewController
        (vc as ProfilViewController).pushed = true
        (vc as ProfilViewController).isMyAccount = false
        (vc as ProfilViewController).user = self.objects![index]["user"] as? PFUser
        self.navigationController?.pushViewController(vc, animated: true)
    }
    
    func showComment(post: PFObject) {
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let vc: CommentsTableViewController = storyboard.instantiateViewControllerWithIdentifier(CommentTableViewID) as! CommentsTableViewController
        (vc as CommentsTableViewController).Post = post
        self.navigationController?.pushViewController(vc, animated: true)
    }
    
    
    
    //MARK: Parse functions
    
    func getMyFollower()
    {
        var query = PFQuery(className: "FollowUser")
        query.fromPinWithName("LinkFollowUser")
        query.whereKey("from", equalTo: PFUser.currentUser()!)
        query.findObjectsInBackgroundWithBlock { (objects: [AnyObject]?, error: NSError?) -> Void in
            if error == nil {
                if let objects = objects as? [PFObject] {
                    for object in objects {
                        self.followuser.append(object["to"] as! PFUser)
                    }
                    self.followuser.append(PFUser.currentUser()!)
                    self.checkLocalStore = true
                    self.loadObjects(0, clear: true)
                }
            }
            
            
            //Then check the data on network
            var query = PFQuery(className: "FollowUser")
            query.whereKey("from", equalTo: PFUser.currentUser()!)
            query.findObjectsInBackgroundWithBlock { (objects: [AnyObject]?, error: NSError?) -> Void in
                if error == nil {
                    if let objects = objects as? [PFObject] {
                        
                        
                        self.followuser = []
                        for object in objects {
                            self.followuser.append(object["to"] as! PFUser)
                        }
                        self.followuser.append(PFUser.currentUser()!)
                        
                    }
                    
                    PFObject.unpinAllObjectsInBackgroundWithName("LinkFollowUser", block: { (done: Bool, error:NSError?) -> Void in
                        if error == nil {
                            PFObject.pinAllInBackground(objects, withName: "LinkFollowUser", block: { (done: Bool, error:NSError?) -> Void in
                                if error == nil {
                                    self.loadObjects(0, clear: true)
                                }
                            })
                        }
                    })
                    
                    PFObject.unpinAllObjectsInBackgroundWithName("FollowUser", block: { (done: Bool, error:NSError?) -> Void in
                        if error == nil {
                            PFObject.pinAllInBackground(self.followuser, withName: "FollowUser", block: { (done: Bool, error:NSError?) -> Void in
                                if error == nil {
                                    self.loadObjects(0, clear: true)
                                }
                            })
                        }
                    })
                }
            }
        }
    }
    
    
    func localRequestPost() -> PFQuery {
        var query = PFQuery(className: "Post")
        query.fromPinWithName("Post")
        query.includeKey("postTags")
        query.includeKey("user")
        query.includeKey("userCommentsArray")
        query.whereKey("user", containedIn: followuser)
        query.orderByDescending("createdAt")
        
        
        return query
    }
    
    
    func getPostFromFollower() {
        //Get the data from cache first then Network
        
        var query = ParseQuery.sharedInstance.getMainPostQuery()
        query.includeKey("postTags")
        query.includeKey("userCommentsArray")
        query.includeKey("user")
        query.orderByDescending("createdAt")
        query.whereKey("user", containedIn: self.followuser)
        

        
        query.findObjectsInBackgroundWithBlock({ (object: [AnyObject]?, error:NSError?) -> Void in
            if error == nil {
                //SUCCESS
                if let object = object as? [PFObject] {
                    self.getMyLikes(object)
                    PFObject.pinAllInBackground(object, withName: "Post", block: { (done: Bool, error:NSError?) -> Void in
                        if error == nil {
                        }
                    })
                }
            }
            self.firstrequest = true
        })
        

    }
    
    
    func getComments(post: PFObject) {
        
        var query = PFQuery(className: "Comment")
        query.includeKey("user")
        query.fromPinWithName("Comment")
        query.orderByDescending("createdAt")
        query.limit = 3
        query.whereKey("userPost", equalTo: post)
        query.findObjectsInBackgroundWithBlock { (objects: [AnyObject]?, error: NSError?) -> Void in
            if error == nil {
                if let array = objects as? [PFObject] {
                    if let index = find(self.objects as! [PFObject], post) {
                        self.comments[index] = array
                        if let cell: MainTimelineCell = self.tableView.cellForRowAtIndexPath(NSIndexPath(forRow: 0, inSection: index)) as? MainTimelineCell {
                            cell.comments = array
                            cell.commentTableView.reloadData()
                        }
                    }
                }
                
                var query = PFQuery(className: "Comment")
                query.includeKey("user")
                query.limit = 3
                query.orderByDescending("createdAt")
                query.whereKey("userPost", equalTo: post)
                query.findObjectsInBackgroundWithBlock { (objects: [AnyObject]?, error: NSError?) -> Void in
                    if error == nil {
                        if let array = objects as? [PFObject] {
                            if let index = find(self.objects as! [PFObject], post) {
                                self.comments[index] = array
                                if let cell: MainTimelineCell = self.tableView.cellForRowAtIndexPath(NSIndexPath(forRow: 0, inSection: index)) as? MainTimelineCell {
                                    cell.comments = array
                                    cell.commentTableView.reloadData()
                                }
                            }
                            
                            PFObject.pinAllInBackground(array, withName: "Comment", block: nil)
                        }
                    }
                    else {
                        println(error)
                    }
                }
                
            }
            else {
                println(error)
            }
        }
    }
    
    //MARK: Notification likes
    
    func getMyLikes(object : [PFObject]) {
        var query = PFQuery(className: "Likes")
        query.whereKey("post", containedIn: object)
        query.findObjectsInBackgroundWithBlock { (objects: [AnyObject]?, error: NSError?) -> Void in
            if error == nil {
                if let object = objects as? [PFObject] {
                    PFObject.pinAllInBackground(object, withName: "Likes", block: { (done: Bool, error: NSError?) -> Void in
                        NSNotificationCenter.defaultCenter().postNotificationName("GetLikes", object:nil, userInfo:nil)
                        super.loadObjects(0, clear: true)
                    })
                }
            }
        }
    }
    
    func reloadLikes() {
        if let listofCell = self.tableView.indexPathsForVisibleRows() as? [NSIndexPath] {
            for index in listofCell {
                if let cell: MainTimelineCell = self.tableView.cellForRowAtIndexPath(index) as? MainTimelineCell {
                    self.tableView.reloadRowsAtIndexPaths([index], withRowAnimation: UITableViewRowAnimation.None)
                }
            }
        }
    }
    
    func createAlertNoFollower() {
        var alerttextview = UITextView()
        
        alertView.backgroundColor = UIColor.blackColor()
        alertView.setTranslatesAutoresizingMaskIntoConstraints(false)
        
        alerttextview.userInteractionEnabled = false
        
        alerttextview.setTranslatesAutoresizingMaskIntoConstraints(false)
        alerttextview.backgroundColor = UIColor.clearColor()
        alerttextview.textAlignment = .Center
        alerttextview.font = UIFont(name: "Montserrat-Regular", size: 20)
        alerttextview.textColor = UIColor.whiteColor()
        alerttextview.text = "You don't have any follower. Check out the discovery section to start"
        
        alertView.addSubview(alerttextview)
        self.view.addSubview(self.alertView)
        
        let views: [String: AnyObject] = ["label": alerttextview, "background": alertView]
        
        self.view.addConstraint(NSLayoutConstraint(item: alertView, attribute: .CenterX, relatedBy: .Equal, toItem: self.view, attribute: .CenterX, multiplier: 1, constant: 0))
        self.view.addConstraint(NSLayoutConstraint(item: alertView, attribute: .CenterY, relatedBy: .Equal, toItem: self.view, attribute: .CenterY, multiplier: 1, constant: 0))
        self.view.addConstraint(NSLayoutConstraint(item: alertView, attribute: .Width, relatedBy: .Equal, toItem: self.view, attribute: .Width, multiplier: 1, constant: 0))
        self.view.addConstraint(NSLayoutConstraint(item: alertView, attribute: .Height, relatedBy: .Equal, toItem: self.view, attribute: .Height, multiplier: 1, constant: 0))
        
        
        alertView.addConstraint(NSLayoutConstraint(item: alerttextview, attribute: .CenterX, relatedBy: .Equal, toItem: alertView, attribute: .CenterX, multiplier: 1, constant: 0))
        alertView.addConstraint(NSLayoutConstraint(item: alerttextview, attribute: .CenterY, relatedBy: .Equal, toItem: alertView, attribute: .CenterY, multiplier: 1, constant: 80))
        alertView.addConstraint(NSLayoutConstraint(item: alerttextview, attribute: .Width, relatedBy: .Equal, toItem: alertView, attribute: .Width, multiplier: 1, constant: 0))
        alertView.addConstraint(NSLayoutConstraint(item: alerttextview, attribute: .Height, relatedBy: .Equal, toItem: alertView, attribute: .Height, multiplier: 1, constant: 0))
    }
    
    
    
    
    
    
    
    
    
    
}