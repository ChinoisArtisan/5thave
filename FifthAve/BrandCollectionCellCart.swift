//
//  BrandCollectionCellCart.swift
//  5thAve
//
//  Created by WANG Michael on 07/05/2015.
//  Copyright (c) 2015 emagid. All rights reserved.
//

import Foundation
import UIKit

class BrandCollectionCellCart: UICollectionViewCell {
    
    @IBOutlet weak var itemimage: PFImageView!
    
    @IBOutlet weak var itemname: UILabel!
    
    @IBOutlet weak var itemprice: UILabel!
    
    @IBOutlet weak var cartbutton: UIButton!
    
    @IBOutlet weak var message: UILabel!
    var id: Int = 0
    var delegate: BrandProfilCollectionView?
    
    @IBAction func addToCart(sender: AnyObject) {
        self.delegate?.selected[id] = true
        self.delegate?.collection.reloadData()
    }
    
    @IBAction func zoomIn(sender: AnyObject) {
        self.delegate?.showDetail()
    }
    
    
}