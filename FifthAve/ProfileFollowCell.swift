//
//  ProfileFollowCell.swift
//  FifthAve
//
//  Created by WANG Michael on 02/06/2015.
//  Copyright (c) 2015 emagid. All rights reserved.
//

import Foundation
import UIKit

@objc protocol FollowUserProtocol {
    optional func removeFollower(id: PFObject)
    optional func followUser(user: PFUser)
}

class ProfileFollowCell: UITableViewCell {
    
    var userFollowImage: PFImageView = PFImageView()
    var userFollowLabel: UILabel = UILabel()
    var userFollowButton: UIButton = UIButton()
    var id: PFObject?
    var delegate: FollowUserProtocol?
    var deleted: Bool = false

    
    override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
        
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setUpCell()
    }
    
    required init(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    func setUpCell () {
        
        self.contentView.backgroundColor = AppColor.blackColor()
        
        userFollowImage.setTranslatesAutoresizingMaskIntoConstraints(false)
        userFollowImage.contentMode = .ScaleAspectFit
        
        userFollowLabel.setTranslatesAutoresizingMaskIntoConstraints(false)
        userFollowLabel.textAlignment = .Left
        userFollowLabel.backgroundColor = UIColor.clearColor()
        userFollowLabel.font = UIFont(name: "Montserrat-Regular", size: 15)
        userFollowLabel.textColor = UIColor.whiteColor()
        userFollowLabel.adjustsFontSizeToFitWidth = true
        
        userFollowButton.setTranslatesAutoresizingMaskIntoConstraints(false)
        userFollowButton.setTitleColor(UIColor.whiteColor(), forState: .Normal)
        userFollowButton.setTitle("Unfollow", forState: .Normal)
        userFollowButton.titleLabel?.font = UIFont(name: "Montserrat-Bold", size: 13)
        userFollowButton.backgroundColor = AppColor.lightBlueColorApp()
        userFollowButton.addTarget(self, action: "remove", forControlEvents: UIControlEvents.TouchUpInside)
        
        let views = ["image": userFollowImage, "item": userFollowLabel, "button": userFollowButton]
        
        self.contentView.addSubview(userFollowImage)
        self.contentView.addSubview(userFollowLabel)
        self.contentView.addSubview(userFollowButton)
        
        self.contentView.addConstraints(NSLayoutConstraint.constraintsWithVisualFormat("V:[image(==40)]", options: NSLayoutFormatOptions(0), metrics: nil, views: views))
        self.contentView.addConstraints(NSLayoutConstraint.constraintsWithVisualFormat("H:|-8-[image(==40)]-10-[item]-10-[button(==100)]-10-|", options: NSLayoutFormatOptions(0), metrics: nil, views: views))
        //self.contentView.addConstraints(NSLayoutConstraint.constraintsWithVisualFormat("H:[button(==100)]-10-|", options: NSLayoutFormatOptions(0), metrics: nil, views: views))
        
        self.contentView.addConstraint(NSLayoutConstraint(item: userFollowImage, attribute: .CenterY, relatedBy: .Equal, toItem: self.contentView, attribute: .CenterY, multiplier: 1, constant: 0))
        self.contentView.addConstraint(NSLayoutConstraint(item: userFollowLabel, attribute: .CenterY, relatedBy: .Equal, toItem: self.contentView, attribute: .CenterY, multiplier: 1, constant: 0))
        self.contentView.addConstraint(NSLayoutConstraint(item: userFollowButton, attribute: .CenterY, relatedBy: .Equal, toItem: self.contentView, attribute: .CenterY, multiplier: 1, constant: 0))
    }
        
    func remove() {
        self.delegate?.removeFollower!(self.id!)
    }
}