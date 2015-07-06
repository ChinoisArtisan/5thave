//
//  ShopDashboardViewController.swift
//  5thAve
//
//  Created by Emagid Corp on 4/20/15.
//  Copyright (c) 2015 Beyond 2021. All rights reserved.
//

import Foundation
import UIKit

class ShopDashboardViewController: UIViewController, UITableViewDataSource, UITableViewDelegate{
    
    var token:[MainScreenState] = [.DiscoverUsers, .Favorites, .BrandStores, .Profile]
    
    var data: [String] = ["DISCOVER", "FAVORITES", "BRAND STORES", "MY CLOSET"]
    var delegate: ShopDashProtocol?
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
    }
    
    
    //MARK: Tableview delegate and datasource
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell: UITableViewCell = tableView.dequeueReusableCellWithIdentifier(ShopDashCellID, forIndexPath: indexPath) as! UITableViewCell
        
        cell.textLabel!.text = data[indexPath.row]
        
        return cell
    }
    
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        switch indexPath.row
        {
        case 0:
            var vc: DiscoverViewController  = (storyboard!.instantiateViewControllerWithIdentifier(DiscoverViewControllerID) as! DiscoverViewController)
            (vc as DiscoverViewController).isUserState = true
            self.navigationController?.pushViewController(vc, animated: true)
        case 1:
            var vc = UIStoryboard(name: "Main", bundle: nil).instantiateViewControllerWithIdentifier(ProfilViewControllerID) as! ProfilViewController
            (vc as ProfilViewController).pushed = true
            (vc as ProfilViewController).isMyAccount = true
            (vc as ProfilViewController).state = .Favorite
            (vc as ProfilViewController).user = PFUser.currentUser()
            self.navigationController?.pushViewController(vc, animated: true)
        case 2:
            var vc = (storyboard!.instantiateViewControllerWithIdentifier(BrandStoreViewControllerID) as! BrandStoreViewController)
            self.navigationController?.pushViewController(vc, animated: true)
        default:
            let vc = UIStoryboard(name: "Main", bundle: nil).instantiateViewControllerWithIdentifier(ProfilViewControllerID) as! ProfilViewController
            (vc as ProfilViewController).pushed = true
            (vc as ProfilViewController).isMyAccount = true
            (vc as ProfilViewController).user = PFUser.currentUser()
            self.navigationController?.pushViewController(vc, animated: true)
        }
        tableView.deselectRowAtIndexPath(indexPath, animated: true)
        
    }
    
    func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
        return 44.0
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return data.count
    }
    
    
}