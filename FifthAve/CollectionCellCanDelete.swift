//
//  CollectionCellCanDelete.swift
//  5thAve
//
//  Created by WANG Michael on 05/05/2015.
//  Copyright (c) 2015 emagid. All rights reserved.
//

import Foundation
import UIKit

class CollectionCellCanDelete: UICollectionViewCell {
    
    @IBOutlet weak var cellimage: PFImageView!
    @IBOutlet weak var cellname: UILabel!
    @IBOutlet weak var cellprice: UILabel!
    
    @IBOutlet weak var deleteButton: UIButton!
    
    var cellid:Int = 0
    var delegate: listprotocol?
    
    
    
    @IBAction func deleteCell(sender: AnyObject) {
        self.delegate?.deletecellwithid(self.cellid)
    }
    
}