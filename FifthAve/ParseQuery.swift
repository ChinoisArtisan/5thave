//
//  ParseQuery.swift
//  FifthAve
//
//  Created by WANG Michael on 29/05/2015.
//  Copyright (c) 2015 emagid. All rights reserved.
//

import Foundation
import UIKit

class ParseQuery {
    class var sharedInstance: ParseQuery {
        struct Static {
            static var instance: ParseQuery?
            static var token: dispatch_once_t = 0
        }
        
        dispatch_once(&Static.token) {
            Static.instance = ParseQuery()
        }
        
        return Static.instance!
    }
    
    func getMainPostQuery() -> PFQuery {
        var query = PFQuery(className: "Post")
        query.includeKey("user")
        query.orderByDescending("createdAt")
        
        return query
    }
    
    func getName(user:PFUser) -> String {
        if let facebookName: AnyObject = user["facebookName"] {
            return (facebookName as? String)!
        }
        return (user["username"] as? String)!
    }
    
    func getPostTagObject(xCoordinate: Int, yCoordinate: Int, tagName: String) -> PFObject {
        var object = PFObject(className: "PostTag")
        
        object["xCoordinate"] = xCoordinate
        object["yCoordinate"] = yCoordinate
        //object["post"] = post
        object["tagName"] = tagName
        
        return object
    }
    
    
    func saveUser(user: PFUser) {
        if user != PFUser.currentUser() {
            PFObject.pinAllInBackground([user], withName: "FollowUser", block: nil)
        }
        else {
            user.saveEventually(nil)
        }
    }
    
}
