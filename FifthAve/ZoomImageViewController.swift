//
//  ZoomImageViewController.swift
//  FifthAve
//
//  Created by WANG Michael on 16/06/2015.
//  Copyright (c) 2015 emagid. All rights reserved.
//

import Foundation
import UIKit

class ZoomImageViewController: UIViewController{
    
    var zoomImage: PFImageView = PFImageView()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        createnavbarbutton()
        createnavtitle()
        createimageview()
        
        self.view.backgroundColor = UIColor.blackColor()
    }
    
    override func viewDidAppear(animated: Bool) {
        super.viewDidAppear(animated)
        zoomImage.loadInBackground { (image: UIImage?, error: NSError?) -> Void in
            if error == nil {
                self.zoomImage.image = image
            }
        }
    }
    
    func createnavbarbutton() {
        let barbutton = NavButtonGenerator.sharedInstance.createdeletebutton()
        (barbutton.customView as! UIButton).addTarget(self, action: "dismissVC", forControlEvents: UIControlEvents.TouchUpInside)
        
        self.navigationItem.leftBarButtonItem = barbutton
    }
    
    func createnavtitle() {
        self.navigationItem.titleView = NavButtonGenerator.sharedInstance.createnavtitle("POSTS")
        self.navigationItem.titleView?.sizeToFit()
    }
    
    
    func createimageview() {
        zoomImage.setTranslatesAutoresizingMaskIntoConstraints(false)
        zoomImage.backgroundColor = UIColor.clearColor()
        zoomImage.contentMode = UIViewContentMode.ScaleAspectFit
        self.view.addSubview(zoomImage)

        
        let views = ["imageView": zoomImage]
        
        self.view.addConstraints(NSLayoutConstraint.constraintsWithVisualFormat("V:|[imageView]|", options: NSLayoutFormatOptions(0), metrics: nil, views: views))
        self.view.addConstraints(NSLayoutConstraint.constraintsWithVisualFormat("H:|[imageView]|", options: NSLayoutFormatOptions(0), metrics: nil, views: views))
    }
    
    
    func dismissVC() {
        dismissViewControllerAnimated(true, completion: nil)
    }
}
