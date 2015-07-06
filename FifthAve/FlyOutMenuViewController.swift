//
//  FlyOutMenuView Controller.swift
//  5thAve
//
//  Created by KEEVIN MITCHELL on 3/25/15.
//  Copyright (c) 2015 Beyond 2021. All rights reserved.
//

import UIKit




class FlyOutMenuViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    
    @IBOutlet weak var BackgroundMenu: UIImageView!
    
    @IBOutlet weak var Content: UITableView!
    
    var state: [CenterContainerState] = [.Search, .Main, .Profile, .Cart, .DiscoverUsers, .Notification, .Settings]
    var labels: [String] = ["SEARCH", "HOME", "MY PROFILE", "SHOPPING CART", "DISCOVER", "NOTIFICATIONS", "ACCOUNT SETTINGS", "SIGN OUT"]
    var images: [String] = ["flyoutmenu_search@x2.png", "home.png", "avatar@x2.png", "flyoutmenu_cart@x2.png", "flyoutmenu_discover@x2.png", "flyoutmenu_notification@x2.png", "flyoutmenu_settings@x2.png"]
    var delegate: MenuProtocol?
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        NSNotificationCenter.defaultCenter().addObserver(self, selector:"reloadCell",  name:"ImageChangedNotification", object:nil);

    }
    
    func reloadCell()
    {
        self.Content.reloadRowsAtIndexPaths([NSIndexPath(forRow: 2, inSection: 0)], withRowAnimation: UITableViewRowAnimation.Right)
    }
    
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        if (indexPath.row == labels.count - 1)
        {
            PFUser.logOut()
            let loginVC = storyboard?.instantiateViewControllerWithIdentifier("welcome") as! FifthWelcomeVC
            presentViewController(loginVC, animated: true, completion: nil)
        }
        else
        {
            self.delegate?.clickOnMenu(state[indexPath.row])
        }
    }
    
    
    func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
        return 69.0
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        
        
        if (indexPath.row == 2)
        {
            let cell: MenuCellParse = tableView.dequeueReusableCellWithIdentifier("MenuCellParse", forIndexPath: indexPath) as! MenuCellParse
            cell.cellImage.image = nil
            if let userImageFile = PFUser.currentUser()?["profileImage"] as? PFFile {
                cell.cellImage.file = userImageFile
                cell.cellImage.loadInBackground({ (image: UIImage?, error: NSError?) -> Void in
                    if error == nil {
                        cell.cellImage.image = image
                    }
                    else {
                        println(error?.description)
                    }
                })
            }
            
            Tools.sharedInstance.roundImageView(cell.cellImage, borderWitdh: 0.5)
            cell.cellLabel.text = labels[indexPath.row]
            return cell
        }
        else
        {
            let cell: MenuCell = tableView.dequeueReusableCellWithIdentifier(MenuCellID, forIndexPath: indexPath) as! MenuCell
            
            cell.cellLabel.text = labels[indexPath.row]
            if indexPath.row < labels.count - 1
            {
                cell.cellImage.image = UIImage(named: images[indexPath.row])
            }
            else
            {
                cell.cellImage.image = nil
            }
            
            return cell
        }
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return labels.count
    }
    
}
