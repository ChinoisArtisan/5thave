//
//  CollectionsTableViewCell.swift
//  5thAve
//
//  Created by Johnny Heusser  on 4/30/15.
//  Copyright (c) 2015 Beyond 2021. All rights reserved.
//

import UIKit

class CollectionsTableViewCell: UITableViewCell {
    
    var collectionsImageView: UIImageView = UIImageView()
    var collectionsItemLabel: UILabel = UILabel()
    var collectionsButton: UIButton = UIButton()
    
    override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
        
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setUpCell()
    }
    
    required init(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    func setUpCell () {
        
        self.contentView.backgroundColor = AppColor.fifthGrayColor()
        
        collectionsImageView.setTranslatesAutoresizingMaskIntoConstraints(false)
        collectionsImageView.contentMode = .ScaleAspectFit
        
        collectionsItemLabel.setTranslatesAutoresizingMaskIntoConstraints(false)
        collectionsItemLabel.textAlignment = .Left
        collectionsItemLabel.backgroundColor = UIColor.clearColor()
        collectionsItemLabel.font = UIFont(name: "Montserrat-Regular", size: 12)
        collectionsItemLabel.textColor = UIColor.whiteColor()
        
        collectionsButton.setTranslatesAutoresizingMaskIntoConstraints(false)
        collectionsButton.setTitle("Wish", forState: .Normal)
        collectionsButton.setTitleColor(UIColor.whiteColor(), forState: .Normal)
        collectionsButton.titleLabel?.font = UIFont(name: "Montserrat-Bold", size: 16)
        collectionsButton.backgroundColor = AppColor.lightBlueColorApp()
        
        let views = ["image": collectionsImageView, "item": collectionsItemLabel, "button": collectionsButton]
        
        self.contentView.addSubview(collectionsImageView)
        self.contentView.addSubview(collectionsItemLabel)
        self.contentView.addSubview(collectionsButton)
        
        self.contentView.addConstraints(NSLayoutConstraint.constraintsWithVisualFormat("V:[image(==40)]", options: NSLayoutFormatOptions(0), metrics: nil, views: views))
        self.contentView.addConstraints(NSLayoutConstraint.constraintsWithVisualFormat("H:|-2-[image(==40)][item]", options: NSLayoutFormatOptions(0), metrics: nil, views: views))
        self.contentView.addConstraint(NSLayoutConstraint(item: collectionsImageView, attribute: .CenterY, relatedBy: .Equal, toItem: self.contentView, attribute: .CenterY, multiplier: 1, constant: 0))
        self.contentView.addConstraints(NSLayoutConstraint.constraintsWithVisualFormat("H:[button(==100)]-10-|", options: NSLayoutFormatOptions(0), metrics: nil, views: views))
        self.contentView.addConstraint(NSLayoutConstraint(item: collectionsItemLabel, attribute: .CenterY, relatedBy: .Equal, toItem: self.contentView, attribute: .CenterY, multiplier: 1, constant: 0))
        self.contentView.addConstraint(NSLayoutConstraint(item: collectionsButton, attribute: .CenterY, relatedBy: .Equal, toItem: self.contentView, attribute: .CenterY, multiplier: 1, constant: 0))
    }
}

