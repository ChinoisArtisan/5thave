//
//  SettingsViewController.swift
//  5thAve
//
//  Created by Emagid Corp on 4/15/15.
//  Copyright (c) 2015 Beyond 2021. All rights reserved.
//

import Foundation
import UIKit


class SettingsViewController: UITableViewController, CenterVCProtocol{
    
    
    var ContainerVC: ContainerProtocol?
    
    @IBOutlet var table: UITableView!
    
    override func viewDidLoad() {
        
        super.viewDidLoad()
        self.setNavBarTitle("SETTINGS")
    }
    
    @IBAction func signOutTapped(sender: AnyObject) {
        
        PFUser.logOut()
        let loginVC = storyboard?.instantiateViewControllerWithIdentifier("welcome") as! FifthWelcomeVC
        presentViewController(loginVC, animated: true, completion: nil)
    }
    
    func enableInteraction(enable:Bool)
    {
        self.table.userInteractionEnabled = enable
    }
    
    
    @IBAction func menuClicked(sender: AnyObject)
    {
        self.ContainerVC?.menuAction()
    }
    
    func setNavBarTitle(title:String)
    {
        let tmplabel = UILabel()
        tmplabel.text = title
        tmplabel.font = UIFont(name: "Montserrat-Bold", size: 20)
        tmplabel.textColor = UIColor.whiteColor()
        tmplabel.backgroundColor = UIColor.clearColor()
        
        self.navigationItem.titleView = tmplabel
        tmplabel.sizeToFit()
    }
}