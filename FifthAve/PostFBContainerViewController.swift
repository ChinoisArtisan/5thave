//
//  PostFBContainerViewController.swift
//  5thAve
//
//  Created by Johnny on 5/4/15.
//  Copyright (c) 2015 emagid. All rights reserved.
//

import UIKit

class PostFBContainerViewController: UIViewController {
    
    var headerContainerView: UIView = UIView()
    var containerView: UIView = UIView()
    var footerContainerView: UIView = UIView()
    var titleLabel: UILabel = UILabel()
    var cancelButton: UIButton = UIButton()
    var postButton: UIButton = UIButton()
    var contentTextView: UITextView = UITextView()
    var contentImageView: UIImageView = UIImageView()
    
    
    override func viewDidLoad() {
        
        self.view.backgroundColor = AppColor.fifthGrayColor()
        setUpContainerViews()
        setUpHeaderViews()
        setUpContentViews()
    }
    
    func setUpContainerViews () {
        
        headerContainerView.backgroundColor = AppColor.fifthGrayColor()
        headerContainerView.setTranslatesAutoresizingMaskIntoConstraints(false)
        
        containerView.backgroundColor = AppColor.fifthGrayColor()
        containerView.setTranslatesAutoresizingMaskIntoConstraints(false)
        
        footerContainerView.backgroundColor = AppColor.fifthGrayColor()
        footerContainerView.setTranslatesAutoresizingMaskIntoConstraints(false)
        
        let views: [String: AnyObject] = ["background": containerView, "header": headerContainerView, "footer": footerContainerView]
        
        self.view.addSubview(headerContainerView)
        self.view.addSubview(containerView)
        self.view.addSubview(footerContainerView)
        
       // self.view.addConstraints(NSLayoutConstraint.constraintsWithVisualFormat("V:|-60-[header(==40)][background(==200)][footer(==40)]", options: NSLayoutFormatOptions(0), metrics: nil, views: views))
        self.view.addConstraints(NSLayoutConstraint.constraintsWithVisualFormat("V:|-60-[header(==40)][background(==200)]", options: NSLayoutFormatOptions(0), metrics: nil, views: views))
        self.view.addConstraints(NSLayoutConstraint.constraintsWithVisualFormat("H:|-25-[background]-25-|", options: NSLayoutFormatOptions(0), metrics: nil, views: views))
        self.view.addConstraint(NSLayoutConstraint(item: containerView, attribute: .CenterX, relatedBy: .Equal, toItem: self.view, attribute: .CenterX, multiplier: 1, constant: 0))
        self.view.addConstraints(NSLayoutConstraint.constraintsWithVisualFormat("H:|-25-[header]-25-|", options: NSLayoutFormatOptions(0), metrics: nil, views: views))
       // self.view.addConstraints(NSLayoutConstraint.constraintsWithVisualFormat("H:|-25-[footer]-25-|", options: NSLayoutFormatOptions(0), metrics: nil, views: views))
    }
    
    func setUpHeaderViews () {
        
        cancelButton.backgroundColor = UIColor.clearColor()
        cancelButton.setTranslatesAutoresizingMaskIntoConstraints(false)
        cancelButton.setTitle("CANCEL", forState: .Normal)
        cancelButton.setTitleColor(AppColor.lightBlueColorApp(), forState: .Normal)
        cancelButton.titleLabel?.font = UIFont(name: "Montserrat-Regular", size: 14)
        
        titleLabel.setTranslatesAutoresizingMaskIntoConstraints(false)
        titleLabel.backgroundColor = UIColor.clearColor()
        titleLabel.textAlignment = .Center
        titleLabel.font = UIFont(name: "Montserrat-Regular", size: 14)
        titleLabel.textColor = UIColor.whiteColor()
        
        postButton.backgroundColor = UIColor.clearColor()
        postButton.setTranslatesAutoresizingMaskIntoConstraints(false)
        postButton.setTitle("POST", forState: .Normal)
        postButton.setTitleColor(AppColor.lightBlueColorApp(), forState: .Normal)
        postButton.titleLabel?.font = UIFont(name: "Montserrat-Regular", size: 14)
        
        let views = ["cancel": cancelButton, "title": titleLabel, "post": postButton]
        
        headerContainerView.addSubview(cancelButton)
        headerContainerView.addSubview(titleLabel)
        headerContainerView.addSubview(postButton)
        
        headerContainerView.addConstraints(NSLayoutConstraint.constraintsWithVisualFormat("V:[cancel(==30)]", options: NSLayoutFormatOptions(0), metrics: nil, views: views))
        headerContainerView.addConstraint(NSLayoutConstraint(item: cancelButton, attribute: .CenterY, relatedBy: .Equal, toItem: headerContainerView, attribute: .CenterY, multiplier: 1, constant: 0))
        headerContainerView.addConstraints(NSLayoutConstraint.constraintsWithVisualFormat("V:[title(==30)]", options: NSLayoutFormatOptions(0), metrics: nil, views: views))
        headerContainerView.addConstraint(NSLayoutConstraint(item: titleLabel, attribute: .CenterY, relatedBy: .Equal, toItem: headerContainerView, attribute: .CenterY, multiplier: 1, constant: 0))
        headerContainerView.addConstraints(NSLayoutConstraint.constraintsWithVisualFormat("V:[post(==30)]", options: NSLayoutFormatOptions(0), metrics: nil, views: views))
        headerContainerView.addConstraint(NSLayoutConstraint(item: postButton, attribute: .CenterY, relatedBy: .Equal, toItem: headerContainerView, attribute: .CenterY, multiplier: 1, constant: 0))
        
        
        headerContainerView.addConstraint(NSLayoutConstraint(item: titleLabel, attribute: .CenterX, relatedBy: .Equal, toItem: headerContainerView, attribute: .CenterX, multiplier: 1, constant: 0))
        
        headerContainerView.addConstraints(NSLayoutConstraint.constraintsWithVisualFormat("H:[title(==100)]", options: NSLayoutFormatOptions(0), metrics: nil, views: views))
        headerContainerView.addConstraints(NSLayoutConstraint.constraintsWithVisualFormat("H:|-8-[cancel]", options: NSLayoutFormatOptions(0), metrics: nil, views: views))
        headerContainerView.addConstraints(NSLayoutConstraint.constraintsWithVisualFormat("H:[post]-8-|", options: NSLayoutFormatOptions(0), metrics: nil, views: views))
    }
    
    func setUpContentViews () {
        
        contentTextView.setTranslatesAutoresizingMaskIntoConstraints(false)
        contentTextView.backgroundColor = UIColor.clearColor()
        contentTextView.font = UIFont(name: "Montserrat-Regular", size: 10)
        contentTextView.textColor = UIColor.whiteColor()
        contentTextView.editable = false
        //  dummy text
        contentTextView.text = "Long dress in lace with a wrap-front bodice, elasticized waist, longer back section, and short sleeves. Lined with short jersey liner dress. White 78% nylon, 22% cotton"
        
        contentImageView.setTranslatesAutoresizingMaskIntoConstraints(false)
        contentImageView.backgroundColor = UIColor.clearColor()
        contentImageView.contentMode = .ScaleAspectFit
        
        
        let views = ["text":contentTextView, "image": contentImageView]
        
        containerView.addSubview(contentTextView)
        containerView.addSubview(contentImageView)
        
        containerView.addConstraints(NSLayoutConstraint.constraintsWithVisualFormat("V:|-5-[text]-5-|", options: NSLayoutFormatOptions(0), metrics: nil, views: views))
        containerView.addConstraints(NSLayoutConstraint.constraintsWithVisualFormat("H:|-5-[text(==160)]", options: NSLayoutFormatOptions(0), metrics: nil, views: views))
        
        containerView.addConstraints(NSLayoutConstraint.constraintsWithVisualFormat("V:|-5-[image]-5-|", options: NSLayoutFormatOptions(0), metrics: nil, views: views))
        containerView.addConstraints(NSLayoutConstraint.constraintsWithVisualFormat("H:[text]-[image]-5-|", options: NSLayoutFormatOptions(0), metrics: nil, views: views))

    }
    
}














