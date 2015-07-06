//
//  SocialTools.swift
//  FifthAve
//
//  Created by WANG Michael on 26/05/2015.
//  Copyright (c) 2015 emagid. All rights reserved.
//

import Foundation
import UIKit
import Social

class SocialTools {
    class var sharedInstance: SocialTools {
        struct Static {
            static var instance: SocialTools?
            static var token: dispatch_once_t = 0
        }
        
        dispatch_once(&Static.token) {
            Static.instance = SocialTools()
        }
        
        return Static.instance!
    }
    
    func setFacebookProfileImage(userProfileImageView: PFImageView)
    {
        let user = PFUser.currentUser()
        
        //Check if the user is connected throught Facebook
        if PFFacebookUtils.isLinkedWithUser(PFUser.currentUser()!) {
            FBRequest.requestForMe()?.startWithCompletionHandler({(connection:FBRequestConnection!, result:AnyObject!, error:NSError!) in
                
                if(error != nil) {
                    println("Error Getting ME: \(error)")
                }
                else {
                    var URLString : String = String(format:"https://graph.facebook.com/%@/picture?type=large&return_ssl_resources=1", arguments:[result["id"] as! String])
                    var request: NSURLRequest = NSURLRequest(URL: NSURL(string: URLString)!)
                    NSURLConnection.sendAsynchronousRequest(request, queue: NSOperationQueue.mainQueue(), completionHandler: { (response: NSURLResponse!, data: NSData!, error: NSError!) -> Void in
                        if (error == nil && data != nil) {
                            userProfileImageView.image = UIImage(data: data)
                            
                            let imageFile = PFFile(name: "profile.jpg", data: data)
                            user?["profileImage"] = imageFile
                            user?.saveInBackgroundWithBlock({ (success: Bool, error:NSError?) -> Void in
                                if success {
                                    //   it worked
                                    println("profile image posted")
                                    NSNotificationCenter.defaultCenter().postNotificationName("ImageChangedNotification", object:nil, userInfo:nil)
                                }
                                else {
                                    println(error?.description)
                                }
                            })
                        }
                    })
                }
            });
        }
    }
    
    func postOnFacebook() {
        
        let name = "Hello World"
        let link = "https://itunes.apple.com/us/app/purple-square/id942125866?ls=1&mt=8"
        let description = String(format: "Fifth ave is coming")
        let caption = "Here is the caption."
        
        // Add variables to dictionary
        var dict = NSMutableDictionary()
        dict.setValue(name, forKey: "name")
        dict.setValue(caption, forKey: "caption")
        dict.setValue(description, forKey: "description")
        dict.setValue(link, forKey: "link")
        
        //let photo : FBSDKSharePhoto = FBSDKSharePhoto()
        
        //dict.setValue(picture, forKey: "picture")
        
        FBRequestConnection.startWithGraphPath("me/feed", parameters: dict as [NSObject : AnyObject], HTTPMethod: "POST", completionHandler: {(connection:FBRequestConnection!, result:AnyObject!, error:NSError!) in
            
            if (error != nil) {
                println("Post facebook error: \(error)")
            }
            else {
                println(result)
            }
            
        })
    }
}