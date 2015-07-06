//
//  CurrentUser.swift
//  
//
//  Created by Johnny on 5/13/15.
//
//

import Foundation
import CoreData

class CurrentUser: NSManagedObject {

    @NSManaged var followingNumber: NSNumber
    @NSManaged var isLoggedIn: NSNumber
    @NSManaged var numberOfFollowers: NSNumber
    @NSManaged var numberOfPosts: NSNumber
    @NSManaged var profileDescription: String
    @NSManaged var profilePic: String
    @NSManaged var userName: String
    @NSManaged var emailAddress: String

}
