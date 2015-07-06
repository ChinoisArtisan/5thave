//
//  SupportViewController.swift
//  5thAve
//
//  Created by WANG Michael on 01/05/2015.
//  Copyright (c) 2015 Beyond 2021. All rights reserved.
//

import Foundation
import UIKit

class SupportViewController: UITableViewController {
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let tmplabel = UILabel()
        tmplabel.text = "SUPPORT"
        tmplabel.font = UIFont(name: "Montserrat-Bold", size: 20)
        tmplabel.textColor = UIColor.whiteColor()
        tmplabel.backgroundColor = UIColor.clearColor()
        
        self.navigationItem.titleView = tmplabel
        self.navigationController?.navigationBar.backgroundColor = UIColor.blackColor()
        
        tmplabel.sizeToFit()
    }
    
    @IBAction func backbutton(sender: AnyObject) {
        self.navigationController?.popViewControllerAnimated(true)
    }
}