//
//  NotificationTableCellFollow.swift
//  5thAve
//
//  Created by WANG Michael on 06/05/2015.
//  Copyright (c) 2015 emagid. All rights reserved.
//

import Foundation
import UIKit

class NotificationTableCellFollow: UITableViewCell {
    
    @IBOutlet weak var profilimage: PFImageView!
    @IBOutlet weak var profilname: UILabel!
    
    @IBOutlet weak var followbutton: UIButton!
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }
}