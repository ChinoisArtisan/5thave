//
//  NotificationTableCellAction.swift
//  5thAve
//
//  Created by WANG Michael on 06/05/2015.
//  Copyright (c) 2015 emagid. All rights reserved.
//

import Foundation
import UIKit

class NotificationTableCellAction: UITableViewCell {
    
    @IBOutlet weak var profilimage: PFImageView!
    @IBOutlet weak var profilname: UILabel!
    @IBOutlet weak var profilaction: UILabel!
    
    @IBOutlet weak var notificationimage: UIImageView!
    @IBOutlet weak var notificationdate: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }
}