//
//  WishListContainerView.swift
//  5thAve
//
//  Created by Johnny Heusser  on 4/30/15.
//  Copyright (c) 2015 Beyond 2021. All rights reserved.
//

import UIKit

class WishListContainerView: UIViewController {
    
    var containerView: UIView = UIView()
    var footerContainerView: UIView = UIView()
    var titleLabel: UILabel = UILabel()
    var doneButton: UIButton = UIButton()
    
    override func viewDidLoad() {
        
        self.view.backgroundColor = AppColor.fifthGrayColor()
        setUpContainerViews()
        setUpDoneButon()
        addTableViewToContainerView()
    }
    
    func setUpContainerViews () {
        
        containerView.backgroundColor = AppColor.fifthGrayColor()
        containerView.setTranslatesAutoresizingMaskIntoConstraints(false)
        
        footerContainerView.backgroundColor = AppColor.fifthGrayColor()
        footerContainerView.setTranslatesAutoresizingMaskIntoConstraints(false)
        
        titleLabel.setTranslatesAutoresizingMaskIntoConstraints(false)
        titleLabel.backgroundColor = AppColor.fifthGrayColor()
        titleLabel.textAlignment = .Center
        titleLabel.font = UIFont(name: "Montserrat-Regular", size: 14)
        titleLabel.textColor = UIColor.whiteColor()
    
        let views: [String: AnyObject] = ["background": containerView, "title": titleLabel, "footer": footerContainerView]
        
        self.view.addSubview(containerView)
        self.view.addSubview(titleLabel)
        self.view.addSubview(footerContainerView)
        
        self.view.addConstraints(NSLayoutConstraint.constraintsWithVisualFormat("V:|-60-[title(==40)][background(==200)][footer(==40)]", options: NSLayoutFormatOptions(0), metrics: nil, views: views))
        self.view.addConstraints(NSLayoutConstraint.constraintsWithVisualFormat("H:|-25-[background]-25-|", options: NSLayoutFormatOptions(0), metrics: nil, views: views))
        self.view.addConstraint(NSLayoutConstraint(item: containerView, attribute: .CenterX, relatedBy: .Equal, toItem: self.view, attribute: .CenterX, multiplier: 1, constant: 0))
        self.view.addConstraints(NSLayoutConstraint.constraintsWithVisualFormat("H:|-25-[title]-25-|", options: NSLayoutFormatOptions(0), metrics: nil, views: views))
        self.view.addConstraints(NSLayoutConstraint.constraintsWithVisualFormat("H:|-25-[footer]-25-|", options: NSLayoutFormatOptions(0), metrics: nil, views: views))
    }
    
    func setUpDoneButon () {
        
        doneButton.setTranslatesAutoresizingMaskIntoConstraints(false)
        doneButton.backgroundColor = UIColor.clearColor()
        doneButton.setTitle("Done", forState: .Normal)
        doneButton.setTitleColor(UIColor.whiteColor(), forState: .Normal)
        doneButton.titleLabel?.font = UIFont(name: "Montserrat-Regular", size: 14)
     
        let views: [String: AnyObject] = ["done": doneButton]
        
        footerContainerView.addSubview(doneButton)
        footerContainerView.bringSubviewToFront(doneButton)
        footerContainerView.addConstraint(NSLayoutConstraint(item: doneButton, attribute: .CenterY, relatedBy: .Equal, toItem: footerContainerView, attribute: .CenterY, multiplier: 1, constant: 0))
        footerContainerView.addConstraints(NSLayoutConstraint.constraintsWithVisualFormat("H:[done(==80)]-10-|", options: NSLayoutFormatOptions(0), metrics: nil, views: views))
        footerContainerView.addConstraints(NSLayoutConstraint.constraintsWithVisualFormat("V:[done(==20)]", options: NSLayoutFormatOptions(0), metrics: nil, views: views))
    }
    
    func addTableViewToContainerView () {
        
        let wishTableVC = storyboard?.instantiateViewControllerWithIdentifier("wishListTableViewController") as! WishListTableViewController
        addChildViewController(wishTableVC)
        containerView.addSubview(wishTableVC.view)
        wishTableVC.view.setTranslatesAutoresizingMaskIntoConstraints(false)
      //  wishTableVC.view.backgroundColor = AppColor.fifthGrayColor()
        let views = ["tableview": wishTableVC.view]
        
        containerView.addConstraints(NSLayoutConstraint.constraintsWithVisualFormat("V:|[tableview]|", options: NSLayoutFormatOptions(0), metrics: nil, views: views))
        containerView.addConstraints(NSLayoutConstraint.constraintsWithVisualFormat("H:|[tableview]|", options: NSLayoutFormatOptions(0), metrics: nil, views: views))
        wishTableVC.didMoveToParentViewController(self)

    }
    
    
}
