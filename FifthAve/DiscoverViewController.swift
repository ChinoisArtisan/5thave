//
//  DiscoverViewController.swift
//  5thAve
//
//  Created by Emagid Corp on 4/22/15.
//  Copyright (c) 2015 Beyond 2021. All rights reserved.
//

import Foundation

class DiscoverViewController: UIViewController, navaction, CenterVCProtocol, UITableViewDelegate, UITableViewDataSource, UISearchBarDelegate{
    
    @IBOutlet weak var searchbar: UISearchBar!
    @IBOutlet weak var discovertableview: UITableView!
    
    @IBOutlet weak var userbutton: UIButton!
    @IBOutlet weak var brandbutton: UIButton!
    var ContainerVC: ContainerProtocol?
    
    var isUserState: Bool = true
    var isPushed: Bool = true
    var users: [String] = ["mika", "bryan", "Toto", "CJ"]
    var brands: [String] = ["No brand", "GUCCI", "Fake brand"]
    
    var userArray: [UserData] = []
    var followuser: [String] = []
    var tmpUserArray: [PFUser] = []
    var query: [PFQuery] = []
    
    var searchMode: Bool = false
    var searchResult: [PFUser] = []
    
    override func viewDidLoad() {
        
        super.viewDidLoad()
        
        searchbar.delegate = self
        buttonClicked()
        getMyFollower()
        
        self.discovertableview.tableFooterView = UIView()
        discovertableview.estimatedRowHeight = 100
        discovertableview.rowHeight = UITableViewAutomaticDimension
        
        userbutton.addTarget(self, action: "clickonbutton:", forControlEvents: UIControlEvents.TouchUpInside)
        brandbutton.addTarget(self, action: "clickonbutton:", forControlEvents: UIControlEvents.TouchUpInside)
        
        if isPushed{
            self.navigationItem.leftBarButtonItem = NavButtonGenerator.sharedInstance.createbackbutton(self)
        }
        else
        {
            self.navigationItem.leftBarButtonItem = NavButtonGenerator.sharedInstance.createmenubutton(self)
        }
        self.navigationItem.titleView = NavButtonGenerator.sharedInstance.createnavtitle("DISCOVER")
        self.navigationItem.titleView?.sizeToFit()
        if isUserState
        {
            self.searchbar.placeholder = "Search Users"
        }
        else
        {
            self.searchbar.placeholder = "Search Brands"
        }
        
    }
    
    
    
    //MARK: navaction protocol
    
    func enableInteraction(enable:Bool)
    {
        self.view.userInteractionEnabled = enable
    }
    
    func menuaction()
    {
        self.ContainerVC?.menuAction()
    }
    
    func backaction() {
        self.navigationController?.popViewControllerAnimated(true)
    }
    
    //MARK: UISearchBar Delegate
    
    func searchBarTextDidBeginEditing(searchBar: UISearchBar) {
        searchMode = true;
    }
    
    func searchBarTextDidEndEditing(searchBar: UISearchBar) {
        searchMode = false;
    }
    
    func searchBarCancelButtonClicked(searchBar: UISearchBar) {
        searchMode = false;
    }
    
    func searchBarSearchButtonClicked(searchBar: UISearchBar) {
        searchMode = false;
        searchbar.resignFirstResponder()
    }
    
    func searchBar(searchBar: UISearchBar, textDidChange searchText: String) {
        
        var queryusername = PFQuery(className: "_User")
        queryusername.whereKeyDoesNotExist("facebookName")
        queryusername.whereKey("username", matchesRegex: searchBar.text, modifiers: "i")
        
        var queryfacebookname = PFQuery(className: "_User")
        queryfacebookname.whereKey("facebookName", matchesRegex: searchBar.text, modifiers: "i")
        
        
        var query = PFQuery.orQueryWithSubqueries([queryusername, queryfacebookname])
        query.fromPinWithName("User")
        query.orderByAscending("updatedAt")
        query.findObjectsInBackgroundWithBlock { (objects: [AnyObject]?, error: NSError?) -> Void in
            if error == nil {
                self.searchResult = []
                if let objects = objects as? [PFUser] {
                    println("SEARCH BAR: CACHE RESULT: ")
                    
                    for object in objects {
                        if !contains(self.followuser, object.objectId!) {
                            self.searchResult.append(object)
                            println(ParseQuery.sharedInstance.getName(object))
                        }
                    }
                }
                self.loadUserArray(self.searchResult)
            }
            else {
                println(error?.description)
            }
            
            var queryusername = PFQuery(className: "_User")
            queryusername.whereKeyDoesNotExist("facebookName")
            queryusername.whereKey("username", matchesRegex: searchBar.text, modifiers: "i")
            
            var queryfacebookname = PFQuery(className: "_User")
            queryfacebookname.whereKey("facebookName", matchesRegex: searchBar.text, modifiers: "i")
            
            
            var query = PFQuery.orQueryWithSubqueries([queryusername, queryfacebookname])
            query.orderByAscending("updatedAt")
            query.findObjectsInBackgroundWithBlock { (objects: [AnyObject]?, error: NSError?) -> Void in
                if error == nil {
                    self.searchResult = []
                    if let objects = objects as? [PFUser] {
                        println("SEARCH BAR: NETWORK RESULT: ")
                        
                        for object in objects {
                            if !contains(self.followuser, object.objectId!) {
                                self.searchResult.append(object)
                                println(ParseQuery.sharedInstance.getName(object))
                                
                            }
                        }
                        PFObject.unpinAllObjectsInBackgroundWithName("User", block: { (done: Bool, error:NSError?) -> Void in
                            if error == nil {
                                PFObject.pinAllInBackground(objects, withName: "User", block: nil)
                            }
                        })
                    }
                    
                    self.loadUserArray(self.searchResult)
                }
                else {
                    println(error?.description)
                }
            }
        }
    }
    
    
    //MARK: tableView Delegate and Datasource
    
    
    func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        
        if isUserState
        {
            
            let cell: DiscoverUser = tableView.dequeueReusableCellWithIdentifier(DiscoverUserID, forIndexPath: indexPath) as! DiscoverUser
        
            cell.username.text = (userArray[indexPath.row] as UserData).username
            cell.id = indexPath.row
            cell.table = self
            
            cell.userimage.image = nil
            if let imageFile = (userArray[indexPath.row] as UserData).profileImageFile {
                
                cell.userimage.file = (userArray[indexPath.row] as UserData).profileImageFile
                cell.userimage.loadInBackground({ (image: UIImage?, error: NSError?) -> Void in
                    if error == nil {
                        cell.userimage.image = image
                    }
                    else {
                        println(error?.description)
                    }
                })
            }
            
            Tools.sharedInstance.roundImageView(cell.userimage, borderWitdh: 0.5)
            cell.leftimage.image = nil
            cell.centerimage.image = nil
            cell.rightimage.image = nil

            if self.userArray[indexPath.row].discoverposts.count > 0 {
                cell.leftimage.file = self.userArray[indexPath.row].discoverposts[0]["postImage"] as? PFFile
                cell.leftimage.loadInBackground({ (image:UIImage?, error: NSError?) -> Void in
                cell.leftimage.image = image
                })
            }
            if self.userArray[indexPath.row].discoverposts.count > 1 {
                cell.centerimage.file = self.userArray[indexPath.row].discoverposts[1]["postImage"] as? PFFile
                cell.centerimage.loadInBackground({ (image:UIImage?, error: NSError?) -> Void in
                cell.centerimage.image = image
                })
            }
            if self.userArray[indexPath.row].discoverposts.count > 2 {
                cell.rightimage.file = self.userArray[indexPath.row].discoverposts[2]["postImage"] as? PFFile
                cell.rightimage.loadInBackground({ (image:UIImage?, error: NSError?) -> Void in
                cell.rightimage.image = image
                })
            }
            
            return cell
        }
        else
        {
            let cell: DiscoverBrand = tableView.dequeueReusableCellWithIdentifier(DiscoverBrandID, forIndexPath: indexPath) as! DiscoverBrand
            
            cell.brandname.text = brands[indexPath.row]
            cell.brandtitle.text = brands[indexPath.row]
            cell.brandimage.image = UIImage(named: "EFM_Launch.jpg")
            
            return cell
        }
    }
    
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        
        if isUserState
        {
            let vc = UIStoryboard(name: "Main", bundle: nil).instantiateViewControllerWithIdentifier(ProfilViewControllerID) as! ProfilViewController
            (vc as ProfilViewController).pushed = true
            (vc as ProfilViewController).isMyAccount = false
            (vc as ProfilViewController).user = tmpUserArray[indexPath.row]
            self.navigationController?.pushViewController(vc, animated: true)
        }
        else
        {
            let vc = (UIStoryboard(name: "Main", bundle: nil).instantiateViewControllerWithIdentifier(BrandViewControllerID) as! BrandViewController)
            (vc as BrandViewController).isPosts = false
            (vc as BrandViewController).shopstate = .shoptable
            self.navigationController?.pushViewController(vc, animated: true)
            
        }
        
        tableView.deselectRowAtIndexPath(indexPath, animated: true)
    }
    
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return (isUserState ? userArray.count : brands.count)
    }
    
    func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
        return 250
    }
    
    //MARK: Button action
    
    func changestate()
    {
        isUserState = !isUserState
        buttonClicked()
        self.discovertableview.reloadData()
    }
    
    func buttonClicked(){
        
        if (isUserState)
        {
            brandbutton.backgroundColor = UIColor.blackColor()
            userbutton.backgroundColor = AppColor.lightBlueColorApp()
        }
        else
        {
            userbutton.backgroundColor = UIColor.blackColor()
            brandbutton.backgroundColor = AppColor.lightBlueColorApp()
        }
    }
    
    func clickonbutton(sender:UIButton)
    {
        if ((sender == userbutton) && (!isUserState))
        {
            println ("User")
            changestate()
            
        }
        else if ((sender == brandbutton) && (isUserState))
        {
            println ("Brand")
            changestate()
        }
    }
    
    
    //MARK:  parse Fetch
    
    func getMyFollower()
    {
        var query = PFQuery(className: "FollowUser")
        query.fromPinWithName("LinkFollowUser")
        query.whereKey("from", equalTo: PFUser.currentUser()!)
        query.findObjectsInBackgroundWithBlock { (objects: [AnyObject]?, error: NSError?) -> Void in
            if error == nil {
                if let objects = objects as? [PFObject] {
                    self.followuser = []
                    for object in objects {
                        self.followuser.append((object["to"] as! PFUser).objectId!)
                    }
                    self.getParseData ()
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
                            self.followuser.append((object["to"] as! PFUser).objectId!)
                        }
                        self.getParseData ()
                    }
                    
                    
                    PFObject.unpinAllObjectsInBackgroundWithName("LinkFollowUser", block: { (done: Bool, error:NSError?) -> Void in
                        if error == nil {
                            PFObject.pinAllInBackground(objects, withName: "LinkFollowUser", block: nil)
                        }
                    })
                    
                    
                    PFObject.unpinAllObjectsInBackgroundWithName("FollowUser", block: { (done: Bool, error:NSError?) -> Void in
                        if error == nil {
                            PFObject.pinAllInBackground(self.followuser, withName: "FollowUser", block: nil)
                        }
                    })
                    
                }
            }
            
            
        }
    }
    
    
    func getParseData () {
        var query = PFQuery(className: "_User")
        query.fromPinWithName("User")
        query.orderByAscending("updatedAt")
        query.whereKey("objectId", notContainedIn: self.followuser)
        query.findObjectsInBackgroundWithBlock { (objects: [AnyObject]?, error: NSError?) -> Void in
            if error == nil {
                var list: [PFUser] = []
                println("DISCOVER: CACHE RESULT: ")

                if let objects = objects as? [PFUser] {
                    for object in objects {
                            list.append(object)
                            println(ParseQuery.sharedInstance.getName(object))
                    }
                }
                self.loadUserArray(list)
            }
            else {
                println(error?.description)
            }
            
            var query = PFQuery(className: "_User")
            query.orderByAscending("updatedAt")
            query.whereKey("objectId", notContainedIn: self.followuser)
            query.findObjectsInBackgroundWithBlock { (objects: [AnyObject]?, error: NSError?) -> Void in
                if error == nil {
                    var list: [PFUser] = []
                    if let objects = objects as? [PFUser] {
                        println("DISCOVER: NETWORK RESULT: ")

                        for object in objects {
                                list.append(object)
                                println(ParseQuery.sharedInstance.getName(object))
                        }
                        
                        
                        PFObject.unpinAllObjectsInBackgroundWithName("User", block: { (done: Bool, error:NSError?) -> Void in
                            if error == nil {
                                PFObject.pinAllInBackground(list, withName: "User", block: nil)
                            }
                        })
                    }
                    
                    self.loadUserArray(list)
                }
                else {
                    println(error?.description)
                }
            }
        }
    }
    
    func getUserPost(user: PFUser) {
        var query = PFQuery(className: "Post")
        query.orderByAscending("createdAt")
        query.fromPinWithName("UserPost")
        query.limit = 3
        query.whereKey("user", equalTo: user)
        query.findObjectsInBackgroundWithBlock { (objects: [AnyObject]?, error: NSError?) -> Void in
            if error == nil {
                if let objects = objects as? [PFObject] {
                    
                    if let index = find(self.tmpUserArray, user) {
                        self.userArray[index].discoverposts = objects
                        self.discovertableview.reloadData()
                    }
                }
            }
            
            var query = PFQuery(className: "Post")
            query.orderByAscending("createdAt")
            query.limit = 3
            query.whereKey("user", equalTo: user)
            query.findObjectsInBackgroundWithBlock { (objects: [AnyObject]?, error: NSError?) -> Void in
                if error == nil {
                    if let objects = objects as? [PFObject] {
                        
                        if let index = find(self.tmpUserArray, user) {
                            self.userArray[index].discoverposts = objects
                            self.discovertableview.reloadData()
                        }
                        
                        PFObject.pinAllInBackground(objects, withName: "UserPost", block: { (done: Bool, error:NSError?) -> Void in
                            if (error != nil) {
                                println(error)
                            }
                        })
                    }
                }
            }
        }
    }
    

    
    func loadUserArray(objects: [AnyObject]?) {
        if let objects = objects as? [PFObject] {
            self.userArray = []
            self.tmpUserArray = []
            var i = 0
            for object in objects {
                if (object as! PFUser) != PFUser.currentUser()
                {
                    let user = UserData()
                    if let facebookName: AnyObject = object["facebookName"] {
                        user.username = facebookName as! String
                    }
                    else {
                        if let username: AnyObject = object["username"] {
                            user.username = username as! String
                        }
                    }
                    if let profileImage: AnyObject = object["profileImage"] {
                        user.profileImageFile = (profileImage as! PFFile)
                    }
                    
                    var data: PFUser = object as! PFUser
                    user.id = data.objectId!
                    
                    self.userArray.append(user)
                    self.tmpUserArray.append(object as! PFUser)
                    

                    getUserPost(object as! PFUser)
                    i += 1
                }
            }
            self.discovertableview.reloadData()
        }
    }
    
    func addUserToFollower(index: Int) {
        var follow = PFObject(className: "FollowUser")
        follow["from"] = PFUser.currentUser()
        follow["to"] = self.tmpUserArray[index]
        
        follow.saveEventually( { (done: Bool, error: NSError?) -> Void in
            if error != nil {
                println(error)
            }
        })
        
        var cell = self.discovertableview.cellForRowAtIndexPath(NSIndexPath(forRow: index, inSection: 0))
        
        
        UIView.animateWithDuration(1, delay: 0, options: UIViewAnimationOptions.CurveEaseOut, animations: { () -> Void in }) { (done: Bool) -> Void in
                self.userArray.removeAtIndex(index)
                self.followuser.append(self.tmpUserArray[index].objectId!)
                self.tmpUserArray.removeAtIndex(index)
            
                self.discovertableview.deleteRowsAtIndexPaths([NSIndexPath(forRow: index, inSection: 0)] as [AnyObject], withRowAnimation: UITableViewRowAnimation.Left)
                self.discovertableview.reloadData()
        }
    }
    
}