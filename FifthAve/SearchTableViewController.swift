//
//  SearchTableViewController.swift
//  5thAve
//
//  Created by Emagid Corp on 4/21/15.
//  Copyright (c) 2015 Beyond 2021. All rights reserved.
//

import Foundation
import UIKit

class SearchTableViewController: UIViewController, UITableViewDelegate, UITableViewDataSource, CenterVCProtocol, navaction, UISearchBarDelegate{
    
    @IBOutlet weak var searchBar: UISearchBar!
    @IBOutlet weak var searchTableView: UITableView!
    var ContainerVC: ContainerProtocol?
    var delegate: Main5THViewController?
    var data: [PFUser] = []
    var followuser: [String] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationItem.leftBarButtonItem = NavButtonGenerator.sharedInstance.createmenubutton(self)
        self.navigationItem.titleView = NavButtonGenerator.sharedInstance.createnavtitle("SEARCH")
        self.navigationItem.titleView?.sizeToFit()
        
        searchBar.delegate = self
        
        getMyFollower()
    }

    func menuaction()
    {
        self.ContainerVC?.menuAction()
    }

    func enableInteraction(enable:Bool)
    {
        self.view.userInteractionEnabled = enable
    }
    

    //MARK:  TableView Delegate and DataSource

    func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let cell = tableView.dequeueReusableCellWithIdentifier(HeaderSearchCellID) as! UITableViewCell
        cell.textLabel?.text = "User"
        return cell
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return data.count
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell: SearchCell = tableView.dequeueReusableCellWithIdentifier(SearchCellID, forIndexPath: indexPath) as! SearchCell
        
        cell.Name.text = ParseQuery.sharedInstance.getName(data[indexPath.row])
        cell.ProfilPicture.image = nil
        cell.ProfilPicture.file = data[indexPath.row]["profileImage"] as? PFFile
        cell.ProfilPicture.loadInBackground { (image: UIImage?, error: NSError?) -> Void in
            if error == nil {
                cell.ProfilPicture.image = image
            }
        }
        Tools.sharedInstance.roundImageView(cell.ProfilPicture, borderWitdh: 0.7)
        
        if contains(self.followuser, (data[indexPath.row] as PFUser).objectId!) {
            cell.FollowButton.setTitle("FOLLOWING", forState: UIControlState.Normal)
        }
        else {
            cell.FollowButton.setTitle("+   FOLLOW", forState: UIControlState.Normal)
        }
        
        return cell
    }
    
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        //DO NOTHING
        searchTableView.deselectRowAtIndexPath(indexPath, animated: false)
        
        let vc = UIStoryboard(name: "Main", bundle: nil).instantiateViewControllerWithIdentifier(ProfilViewControllerID) as! ProfilViewController
        (vc as ProfilViewController).pushed = true
        (vc as ProfilViewController).isMyAccount = false
        (vc as ProfilViewController).user = data[indexPath.row]
        self.navigationController?.pushViewController(vc, animated: true)
    }
    
    func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
        return 58.0
    }
    
    
    
    //MARK:  Search Delegate
    
    func searchBarTextDidBeginEditing(searchBar: UISearchBar) {
        searchBar.showsCancelButton = (searchBar.text != "")
    }
    
    func searchBarTextDidEndEditing(searchBar: UISearchBar) {
        searchBar.showsCancelButton = (searchBar.text != "")
    }
    
    func searchBarCancelButtonClicked(searchBar: UISearchBar) {
        searchBar.text = ""
        searchBar.showsCancelButton = (searchBar.text != "")
        data = []
        searchTableView.reloadData()
        searchBar.resignFirstResponder()
    }
    
    func searchBarSearchButtonClicked(searchBar: UISearchBar) {
        
        searchBar.showsCancelButton = (searchBar.text != "")
        searchBar.resignFirstResponder()

        if searchBar.text != "" {
            var queryusername = PFQuery(className: "_User")
            queryusername.whereKeyDoesNotExist("facebookName")
            queryusername.whereKey("username", matchesRegex: searchBar.text, modifiers: "i")
            
            var queryfacebookname = PFQuery(className: "_User")
            queryfacebookname.whereKey("facebookName", matchesRegex: searchBar.text, modifiers: "i")
            
            
            var query = PFQuery.orQueryWithSubqueries([queryusername, queryfacebookname])
            query.fromPinWithName("User")
            query.orderByAscending("updatedAt")
            query.whereKey("objectId", notEqualTo: (PFUser.currentUser()!.objectId)!)
            query.findObjectsInBackgroundWithBlock { (objects: [AnyObject]?, error: NSError?) -> Void in
                if error == nil {
                    self.data = []
                    if let objects = objects as? [PFUser] {
                        self.data = objects
                    }
                    self.searchTableView.reloadData()
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
                query.whereKey("objectId", notEqualTo: (PFUser.currentUser()!.objectId)!)
                query.findObjectsInBackgroundWithBlock { (objects: [AnyObject]?, error: NSError?) -> Void in
                    if error == nil {
                        self.data = []
                        if let objects = objects as? [PFUser] {
                            self.data = objects
                            self.searchTableView.reloadData()
                            
                            PFObject.pinAllInBackground(objects, withName: "User", block: nil)
                        }
                    }
                    else {
                        println(error?.description)
                    }
                }
            }
        }
        else {
            data = []
            searchTableView.reloadData()
        }
    }
    
    func searchBar(searchBar: UISearchBar, textDidChange searchText: String) {
        searchBar.showsCancelButton = (searchBar.text != "")
    }
    
    //MARK: Parse function 
    
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
}
