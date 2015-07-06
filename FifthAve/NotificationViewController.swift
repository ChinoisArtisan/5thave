//
//  NotificationViewController.swift
//  5thAve
//
//  Created by WANG Michael on 06/05/2015.
//  Copyright (c) 2015 emagid. All rights reserved.
//

import Foundation
import UIKit

class NotificationViewController: UITableViewController, CenterVCProtocol, navaction{
    
    @IBOutlet var tableview: UITableView!
    var ContainerVC: ContainerProtocol?
    
    var data: [Notification] = [Notification(user: "Mika", type: .like, date: "Yesterday at 7:20 PM"), Notification(user: "Johnny", type: .comment, date: "Monday at 7:20 PM"), Notification(user: "Julia", type: .tag, date: "Tuesday at 7:20 PM"), Notification(user: "Mika", type: .follow, date: "Yesterday at 7:20 PM")]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.tableview.tableFooterView = UIView()
        self.navigationItem.leftBarButtonItem = NavButtonGenerator.sharedInstance.createmenubutton(self)
        self.navigationItem.titleView = NavButtonGenerator.sharedInstance.createnavtitle("NOTIFICATIONS")
        self.navigationItem.titleView?.sizeToFit()
    }
    
    func menuaction()
    {
        self.ContainerVC?.menuAction()
    }
    func enableInteraction(enable:Bool)
    {
        self.view.userInteractionEnabled = enable
    }
    
    override func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 1
    }
    
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        if (data[indexPath.row].notificationtype == NotificationType.follow)
        {
            
            let cell: NotificationTableCellFollow = tableView.dequeueReusableCellWithIdentifier(NotificationTableCellFollowID, forIndexPath: indexPath) as! NotificationTableCellFollow
            cell.profilname.text = "@" + data[indexPath.row].user + " wanta to following you"
            
            Tools.sharedInstance.roundImageView(cell.profilimage, borderWitdh: 0.5)
            
            
            return cell
            
        }
        else
        {
            let cell: NotificationTableCellAction = tableView.dequeueReusableCellWithIdentifier(NotificationTableCellActionID, forIndexPath: indexPath) as! NotificationTableCellAction
            cell.profilname.text = "@" + data[indexPath.row].user
            Tools.sharedInstance.roundImageView(cell.profilimage, borderWitdh: 0.5)
            
            switch data[indexPath.row].notificationtype
            {
            case .like:
                cell.notificationimage.image = UIImage(named: "notification_heart@x3.png")
                cell.profilaction.text = "Liked Your Post"
            case .comment:
                cell.notificationimage.image = UIImage(named: "notification_comment@x3.png")
                cell.profilaction.text = "left you a comment"
            default:
                cell.notificationimage.image = UIImage(named: "notification_tag@x3.png")
                cell.profilaction.text = "Tagged you in a post"
            }
            
            cell.notificationdate.text = data[indexPath.row].date
            
            return cell
        }
    }
    
    override func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        // DO NOTHING
    }
    
    override func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
        return 55.0
    }
    
    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return data.count
    }
    
    
}