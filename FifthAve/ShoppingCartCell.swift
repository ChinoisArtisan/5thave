//
//  ShoppingCartCell.swift
//  5thAve
//
//  Created by WANG Michael on 04/05/2015.
//  Copyright (c) 2015 emagid. All rights reserved.
//

import Foundation
import UIKit

class ShoppingCartCell: UITableViewCell{
    
    
    @IBOutlet weak var ItemImage: PFImageView!
    @IBOutlet weak var ItemName: UILabel!
    @IBOutlet weak var ItemRef: UILabel!
    @IBOutlet weak var ItemSize: UILabel!
    @IBOutlet weak var ItemColor: UILabel!
    @IBOutlet weak var ItemPrice: UILabel!
    @IBOutlet weak var ItemQuantity: UIButton!
    
    @IBOutlet weak var deleteButton: UIButton!
    var id: Int = 0
    
    var delegate: ShoppingCartProtocol?
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }
    
    
    @IBAction func deleteItem(sender: AnyObject) {
        self.delegate?.deleteItem(self.id)
    }
    
    
    @IBAction func ChangeQuantity(sender: AnyObject) {
        self.delegate?.ChangeNumber(id)
    }
    
    
}