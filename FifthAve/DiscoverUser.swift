//
//  DiscoverUser.swift
//  5thAve
//
//  Created by WANG Michael on 06/05/2015.
//  Copyright (c) 2015 emagid. All rights reserved.
//

import Foundation
import UIKit

class DiscoverUser: UITableViewCell {
    
    var id: Int?
    var table: DiscoverViewController?
    
    @IBOutlet weak var username: UILabel!
    @IBOutlet weak var userimage: PFImageView!
    @IBOutlet weak var useraddbutton: UIButton!
    
    @IBOutlet weak var leftimage: PFImageView!
    @IBOutlet weak var centerimage: PFImageView!
    @IBOutlet weak var rightimage: PFImageView!
    
    
    @IBOutlet weak var followbutton: UIButton!

    override func awakeFromNib() {
        super.awakeFromNib()
    }
    
    @IBAction func followAction(sender: AnyObject) {
                
        table?.addUserToFollower(id!)
    }
}