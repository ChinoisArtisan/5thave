//
//  Notification.swift
//  5thAve
//
//  Created by WANG Michael on 06/05/2015.
//  Copyright (c) 2015 emagid. All rights reserved.
//

import Foundation


enum NotificationType{
    case like
    case comment
    case tag
    case follow
}

class Notification {
    var user: String = ""
    var notificationtype: NotificationType
    var date: String = ""
    
    init(user:String, type: NotificationType, date: String)
    {
        self.user = user
        self.notificationtype = type
        self.date = date
    }
    
}