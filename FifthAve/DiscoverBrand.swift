//
//  DiscoverBrand.swift
//  5thAve
//
//  Created by WANG Michael on 06/05/2015.
//  Copyright (c) 2015 emagid. All rights reserved.
//

import Foundation
import UIKit

class DiscoverBrand: UITableViewCell {
    
    
    @IBOutlet weak var brandtitle: UILabel!
    @IBOutlet weak var addbrandbutton: UIButton!
    @IBOutlet weak var brandimage: PFImageView!
    
    @IBOutlet weak var brandname: UILabel!
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }
    
}