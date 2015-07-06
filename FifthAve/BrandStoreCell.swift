//
//   BrandStoreCell.swift
//  5thAve
//
//  Created by WANG Michael on 07/05/2015.
//  Copyright (c) 2015 emagid. All rights reserved.
//

import Foundation
import UIKit

class BrandStoreCell: UITableViewCell {
    
    
    @IBOutlet weak var username: UILabel!
    @IBOutlet weak var userimage: PFImageView!
    @IBOutlet weak var useraddbutton: UIButton!
    
    @IBOutlet weak var leftimage: PFImageView!
    @IBOutlet weak var centerimage: PFImageView!
    @IBOutlet weak var rightimage: PFImageView!
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }
    
}