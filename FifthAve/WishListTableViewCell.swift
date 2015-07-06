//
//  WishListTableViewCell.swift
//  5thAve
//
//  Created by Johnny Heusser  on 4/30/15.
//  Copyright (c) 2015 Beyond 2021. All rights reserved.
//

import UIKit

class WishListTableViewCell: UITableViewCell {
    
    var wishImageView: UIImageView = UIImageView()
    var wishItemLabel: UILabel = UILabel()
    var wishButton: UIButton = UIButton()
    
    override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
        
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setUpCell()
    }
    
    required init(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    func setUpCell () {
        
        self.contentView.backgroundColor = AppColor.fifthGrayColor()
        //self.contentView.backgroundColor = UIColor.clearColor()
       // self.backgroundView?.backgroundColor = UIColor.clearColor()
        
        
        wishImageView.setTranslatesAutoresizingMaskIntoConstraints(false)
        wishImageView.contentMode = .ScaleAspectFit
        
        wishItemLabel.setTranslatesAutoresizingMaskIntoConstraints(false)
        wishItemLabel.textAlignment = .Left
        wishItemLabel.backgroundColor = UIColor.clearColor()
        wishItemLabel.font = UIFont(name: "Montserrat-Regular", size: 12)
        wishItemLabel.textColor = UIColor.whiteColor()
        
        wishButton.setTranslatesAutoresizingMaskIntoConstraints(false)
        wishButton.setTitle("Wish", forState: .Normal)
        wishButton.setTitleColor(UIColor.whiteColor(), forState: .Normal)
        wishButton.titleLabel?.font = UIFont(name: "Montserrat-Bold", size: 16)
        wishButton.backgroundColor = AppColor.lightBlueColorApp()
        
        let views = ["image": wishImageView, "item": wishItemLabel, "button": wishButton]
        
        self.contentView.addSubview(wishImageView)
        self.contentView.addSubview(wishItemLabel)
        self.contentView.addSubview(wishButton)
        
        self.contentView.addConstraints(NSLayoutConstraint.constraintsWithVisualFormat("V:[image(==40)]", options: NSLayoutFormatOptions(0), metrics: nil, views: views))
        self.contentView.addConstraints(NSLayoutConstraint.constraintsWithVisualFormat("H:|-2-[image(==40)][item]", options: NSLayoutFormatOptions(0), metrics: nil, views: views))
        self.contentView.addConstraint(NSLayoutConstraint(item: wishImageView, attribute: .CenterY, relatedBy: .Equal, toItem: self.contentView, attribute: .CenterY, multiplier: 1, constant: 0))
        self.contentView.addConstraints(NSLayoutConstraint.constraintsWithVisualFormat("H:[button(==60)]-10-|", options: NSLayoutFormatOptions(0), metrics: nil, views: views))
        self.contentView.addConstraint(NSLayoutConstraint(item: wishItemLabel, attribute: .CenterY, relatedBy: .Equal, toItem: self.contentView, attribute: .CenterY, multiplier: 1, constant: 0))
        self.contentView.addConstraint(NSLayoutConstraint(item: wishButton, attribute: .CenterY, relatedBy: .Equal, toItem: self.contentView, attribute: .CenterY, multiplier: 1, constant: 0))
    }
}
