//
//  CreateCollectionController.swift
//  FifthAve
//
//  Created by WANG Michael on 18/05/2015.
//  Copyright (c) 2015 emagid. All rights reserved.
//

import Foundation
import UIKit

class CreateCollectionController: UIViewController, UITextFieldDelegate{
    
    var popupview = UIView()
    
    var popuplabel = UILabel()
    var popuptextfield = UITextField()
    var popupline = UIView()
    
    var popupcancel = UIButton()
    var popupsave = UIButton()

    override func viewDidLoad() {
        super.viewDidLoad()
        popupcreatecollection()
        self.view.backgroundColor = AppColor.fifthGrayColor()
    }
    
    
    
    
    //MARK Create new list view
    
    func popupcreatecollection()
    {
        popupview.backgroundColor = UIColor.blackColor()
        popupview.setTranslatesAutoresizingMaskIntoConstraints(false)
        
        popuplabel.setTranslatesAutoresizingMaskIntoConstraints(false)
        popuplabel.backgroundColor = UIColor.clearColor()
        popuplabel.textAlignment = .Center
        popuplabel.font = UIFont(name: "Montserrat-Regular", size: 14)
        popuplabel.textColor = UIColor.whiteColor()
        popuplabel.text = "CREATE NEW COLLECTION"
        
        popuptextfield.setTranslatesAutoresizingMaskIntoConstraints(false)
        popuptextfield.backgroundColor = UIColor.clearColor()
        popuptextfield.font = UIFont(name: "Montserrat-Regular", size: 14)
        popuptextfield.textColor = UIColor.whiteColor()
        popuptextfield.delegate = self
        popuptextfield.text = "NAME"
        
        popupline.setTranslatesAutoresizingMaskIntoConstraints(false)
        popupline.backgroundColor = UIColor.whiteColor()
        
        popupcancel.setTranslatesAutoresizingMaskIntoConstraints(false)
        popupcancel.setTitle("CANCEL", forState: UIControlState.Normal)
        popupcancel.titleLabel?.font = UIFont(name: "Montserrat-Regular", size: 14)
        popupcancel.titleLabel?.textColor = AppColor.lightBlueColorApp()
        popupcancel.addTarget(self, action: "cancel", forControlEvents: UIControlEvents.TouchUpInside)
        
        popupsave.setTranslatesAutoresizingMaskIntoConstraints(false)
        popupsave.setTitle("SAVE", forState: UIControlState.Normal)
        popupsave.titleLabel?.font = UIFont(name: "Montserrat-Regular", size: 14)
        popupsave.titleLabel?.textColor = AppColor.lightBlueColorApp()

        
        popupview.addSubview(popuplabel)
        popupview.addSubview(popuptextfield)
        popupview.addSubview(popupline)
        popupview.addSubview(popupcancel)
        popupview.addSubview(popupsave)
        
        let views: [String: AnyObject] = ["background": popupview, "title": popuplabel, "textfield": popuptextfield, "underline": popupline, "cancel": popupcancel, "save": popupsave]
        
        self.view.addSubview(popupview)
        
        
        self.view.addConstraint(NSLayoutConstraint(item: popupview, attribute: .CenterX, relatedBy: .Equal, toItem: self.view, attribute: .CenterX, multiplier: 1, constant: 0))
        self.view.addConstraint(NSLayoutConstraint(item: popupview, attribute: .CenterY, relatedBy: .Equal, toItem: self.view, attribute: .CenterY, multiplier: 1, constant: 0))
        self.view.addConstraints(NSLayoutConstraint.constraintsWithVisualFormat("H:|-20-[background]-20-|", options: NSLayoutFormatOptions(0), metrics: nil, views: views))
        self.view.addConstraints(NSLayoutConstraint.constraintsWithVisualFormat("V:[background]", options: NSLayoutFormatOptions(0), metrics: nil, views: views))
        
        
        popupview.addConstraints(NSLayoutConstraint.constraintsWithVisualFormat("H:|-8-[title]-8-|", options: NSLayoutFormatOptions(0), metrics: nil, views: views))
        popupview.addConstraint(NSLayoutConstraint(item: popuplabel, attribute: .Top, relatedBy: .Equal, toItem: popupview, attribute: .Top, multiplier: 1, constant: 10))
        
        popupview.addConstraint(NSLayoutConstraint(item: popuptextfield, attribute: .Left, relatedBy: .Equal, toItem: popuplabel, attribute: .Left, multiplier: 1, constant: 0))
        popupview.addConstraint(NSLayoutConstraint(item: popuptextfield, attribute: .Right, relatedBy: .Equal, toItem: popuplabel, attribute: .Right, multiplier: 1, constant: 0))
        
        popupview.addConstraint(NSLayoutConstraint(item: popupline, attribute: .Left, relatedBy: .Equal, toItem: popuplabel, attribute: .Left, multiplier: 1, constant: 0))
        popupview.addConstraint(NSLayoutConstraint(item: popupline, attribute: .Right, relatedBy: .Equal, toItem: popuplabel, attribute: .Right, multiplier: 1, constant: 0))
        
        popupview.addConstraints(NSLayoutConstraint.constraintsWithVisualFormat("H:[cancel]", options: NSLayoutFormatOptions(0), metrics: nil, views: views))
        popupview.addConstraint(NSLayoutConstraint(item: popupcancel, attribute: .Left, relatedBy: .Equal, toItem: popuplabel, attribute: .Left, multiplier: 1, constant: 0))
        popupview.addConstraint(NSLayoutConstraint(item: popupsave, attribute: .Right, relatedBy: .Equal, toItem: popuplabel, attribute: .Right, multiplier: 1, constant: 0))
        popupview.addConstraint(NSLayoutConstraint(item: popupcancel, attribute: .Top, relatedBy: .Equal, toItem: popupsave, attribute: .Top, multiplier: 1, constant: 0))
        popupview.addConstraint(NSLayoutConstraint(item: popupcancel, attribute: .Bottom, relatedBy: .Equal, toItem: popupsave, attribute: .Bottom, multiplier: 1, constant: 0))
        
        
        popupview.addConstraints(NSLayoutConstraint.constraintsWithVisualFormat("V:|-10-[title]-15-[textfield][underline(==1)]-20-[cancel]-10-|", options: NSLayoutFormatOptions(0), metrics: nil, views: views))
        
    }
    
    func cancel()
    {
        println("cancel")
        self.removeFromParentViewController()
        self.view.removeFromSuperview()
    }
    
    override func touchesBegan(touches: Set<NSObject>, withEvent event: UIEvent) {
        popuplabel.resignFirstResponder()
    }
    
    // MARK UITextField Delegate
    
    func textFieldShouldBeginEditing(textField: UITextField) -> Bool {
        textField.text = (textField.text == "NAME") ? "" : textField.text
        return true
    }
    
    func textFieldDidBeginEditing(textField: UITextField) {
        textField.becomeFirstResponder()
    }
    
    func textFieldShouldReturn(textField: UITextField) -> Bool {
        
        textField.resignFirstResponder()
        return true
    }
    
    func textFieldDidEndEditing (textField: UITextField) {
        textField.resignFirstResponder()
        textField.text = (textField.text == "") ? "NAME" : textField.text
    }

}