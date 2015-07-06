//
//  ItemCart.swift
//  5thAve
//
//  Created by WANG Michael on 04/05/2015.
//  Copyright (c) 2015 emagid. All rights reserved.
//

import Foundation


class ItemCart
{
    var image: String
    var name: String
    var ref: String
    var size: String
    var color: String
    var price: Double
    var quantity: Int
    
    
    
    init(itemimage: String, itemname: String, itemref:String)
    {
        self.image = itemimage
        self.name = itemname
        self.ref = itemref
        self.size = ""
        self.color = ""
        self.price = 10.0
        self.quantity = 1
    }
    
    
}