//
//  Tag.swift
//  5thAve
//
//  Created by WANG Michael on 30/04/2015.
//  Copyright (c) 2015 Beyond 2021. All rights reserved.
//

import Foundation
import UIKit


class Tag{
    
    var position: CGPoint
    var name: String
    
    init (position: CGPoint, name: String)
    {
        self.position = position
        self.name = name
    }
}