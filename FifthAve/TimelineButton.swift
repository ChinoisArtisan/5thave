//
//  TimelineButton.swift
//  5thAve
//
//  Created by WANG Michael on 05/05/2015.
//  Copyright (c) 2015 emagid. All rights reserved.
//

import Foundation
import UIKit


class TimelineButton: UIButton {
    
    var hitframe: UIEdgeInsets = UIEdgeInsetsMake(-5, -5, -5, -5)
    
    override internal func pointInside(point: CGPoint, withEvent event: UIEvent?) -> Bool {
        var relativeFrame = self.bounds
        var hitTestEdgeInsets = self.hitframe
        var hitFrame = UIEdgeInsetsInsetRect(relativeFrame, hitTestEdgeInsets)
        return CGRectContainsPoint(hitFrame, point)
    }
    
}