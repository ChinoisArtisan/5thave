//
//  NavButtonGenerator.swift
//  FifthAve
//
//  Created by WANG Michael on 19/05/2015.
//  Copyright (c) 2015 emagid. All rights reserved.
//

import Foundation
import UIKit

@objc protocol navaction {
    
    optional func backaction()
    optional func showActionSheet()
    optional func menuaction()
    
}


class NavButtonGenerator {
    class var sharedInstance: NavButtonGenerator {
        struct Static {
            static var instance: NavButtonGenerator?
            static var token: dispatch_once_t = 0
        }
        
        dispatch_once(&Static.token) {
            Static.instance = NavButtonGenerator()
        }
        
        return Static.instance!
    }
    
    func createbackbutton(view: navaction) -> UIBarButtonItem
    {
        var back: UIButton = UIButton()
        back.setImage(UIImage(named: "navbar_back_arrow@x2.png"), forState: .Normal)
        back.frame = CGRectMake(16, 0, 12, 20)
        back.addTarget(view, action: "backaction", forControlEvents: UIControlEvents.TouchUpInside)
        
        var barbutton: UIBarButtonItem = UIBarButtonItem()
        barbutton.customView = back
        
        return barbutton
    }
    
    func createextra(view: navaction) -> UIBarButtonItem
    {
        var back: UIButton = UIButton()
        back.setImage(UIImage(named: "navbar_extend@x3.png"), forState: .Normal)
        back.frame = CGRectMake(0, 0, 10, 20)
        back.addTarget(view, action: "showActionSheet", forControlEvents: UIControlEvents.TouchUpInside)
        
        var barbutton: UIBarButtonItem = UIBarButtonItem()
        barbutton.customView = back
        
        return barbutton
    }
    
    func createnavtitle (title: String) -> UILabel
    {
        let tmplabel = UILabel()
        tmplabel.text = title
        
        tmplabel.font = UIFont(name: "Montserrat-Bold", size: 20)
        tmplabel.textColor = UIColor.whiteColor()
        tmplabel.backgroundColor = UIColor.clearColor()
        
        return tmplabel
    }
    
    
    func createmenubutton(view: navaction) -> UIBarButtonItem
    {
        var back: UIButton = UIButton()
        back.setImage(UIImage(named: "menubutton.png"), forState: .Normal)
        back.frame = CGRectMake(0, 0, 25, 25)
        back.addTarget(view, action: "menuaction", forControlEvents: UIControlEvents.TouchUpInside)
        
        var barbutton: UIBarButtonItem = UIBarButtonItem()
        barbutton.customView = back
        
        return barbutton
        
    }
    
    func createdeletebutton() -> UIBarButtonItem {
        var delete: UIButton = UIButton()
        delete.setTitle("X", forState: .Normal)
        delete.titleLabel?.font = UIFont(name: "Montserrat-Bold", size: 20)
        delete.frame = CGRectMake(0, 0, 25, 25)
        
        var barbutton: UIBarButtonItem = UIBarButtonItem()
        barbutton.customView = delete
        
        return barbutton
    }
    
}