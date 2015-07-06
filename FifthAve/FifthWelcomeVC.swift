//
//  FifthWelcomeVC.swift
//  5thAve
//
//  Created by Johnny on 5/4/15.
//  Copyright (c) 2015 emagid. All rights reserved.
//

import UIKit
import CoreData

class FifthWelcomeVC: UIViewController {
    
    let permissions = ["public_profile", "user_friends", "email", "user_photos", "publish_actions"]
    
    var backgroundImageView: UIImageView = UIImageView()
    var logoImageView: UIImageView = UIImageView()
    var fbButton: UIButton = UIButton()
    var emailButton: UIButton = UIButton()
    var fbLabel: UILabel = UILabel()
    var fbLogoImageView: UIImageView = UIImageView()
    var emailLabel: UILabel = UILabel()
    var emailLogoImageView: UIImageView = UIImageView()
    var signUpButton: UIButton = UIButton()
    
    override func viewDidLoad() {
        
        super.viewDidLoad()

        setUpBackgroundImageView()
        setUpLogoImageView()
        createButtons()
        setUpFBLogoAndLabel()
        setUpEmailLogoAndLabel()
    }
    
    func tempButtonTapped () {
        
        let main = storyboard?.instantiateViewControllerWithIdentifier("mainContainer") as! ContainerViewController
        presentViewController(main, animated: true, completion: nil)
    }
    
    func setUpBackgroundImageView () {
        
        backgroundImageView.setTranslatesAutoresizingMaskIntoConstraints(false)
        backgroundImageView.image = UIImage(named: "5thavebackground_640x1136.jpg")
        self.view.addSubview(backgroundImageView)
        
        let views = ["background": backgroundImageView]
        
        self.view.addConstraints(NSLayoutConstraint.constraintsWithVisualFormat("H:|[background]|", options: NSLayoutFormatOptions(0), metrics: nil, views: views))
        self.view.addConstraints(NSLayoutConstraint.constraintsWithVisualFormat("V:|[background]|", options: NSLayoutFormatOptions(0), metrics: nil, views: views))
    }
    
    func setUpLogoImageView () {
        
        logoImageView.setTranslatesAutoresizingMaskIntoConstraints(false)
        logoImageView.image = UIImage(named: "5thave_biglogo.png")
        logoImageView.contentMode = .ScaleAspectFit
        self.view.addSubview(logoImageView)
        self.view.bringSubviewToFront(logoImageView)
        
        let views = ["logo": logoImageView]
        
        self.view.addConstraints(NSLayoutConstraint.constraintsWithVisualFormat("H:|-30-[logo]-30-|", options: NSLayoutFormatOptions(0), metrics: nil, views: views))
        self.view.addConstraints(NSLayoutConstraint.constraintsWithVisualFormat("V:|-50-[logo(==260)]", options: NSLayoutFormatOptions(0), metrics: nil, views: views))
        
    }
    
    func createButtons () {
        
        fbButton.setTranslatesAutoresizingMaskIntoConstraints(false)
        fbButton.backgroundColor = AppColor.fbBlueColor()
        fbButton.titleLabel?.textAlignment = .Center
        fbButton.addTarget(self, action: "fbButtonTapped", forControlEvents: UIControlEvents.TouchUpInside)
        fbButton.highlighted = true
        self.view.addSubview(fbButton)
        self.view.bringSubviewToFront(fbButton)
        
        emailButton.setTranslatesAutoresizingMaskIntoConstraints(false)
        emailButton.backgroundColor = AppColor.connectEmailColor()
        emailButton.addTarget(self, action: "emailButtonTapped", forControlEvents: .TouchUpInside)
        self.view.addSubview(emailButton)
        self.view.bringSubviewToFront(emailButton)
        
        signUpButton.setTranslatesAutoresizingMaskIntoConstraints(false)
        signUpButton.backgroundColor = UIColor.clearColor()
        signUpButton.setTitle("SIGN UP", forState: .Normal)
        signUpButton.setTitleColor(UIColor.whiteColor(), forState: .Normal)
        signUpButton.titleLabel?.font = UIFont(name: "Montserrat-Regular", size: 14)
        signUpButton.addTarget(self, action: "signUpButtonTapped", forControlEvents: .TouchUpInside)
        self.view.addSubview(signUpButton)
        self.view.bringSubviewToFront(signUpButton)
        
        let views = ["fb": fbButton, "email": emailButton, "signUp": signUpButton, "logo": logoImageView]
        
        self.view.addConstraints(NSLayoutConstraint.constraintsWithVisualFormat("H:|-25-[fb]-25-|", options: NSLayoutFormatOptions(0), metrics: nil, views: views))
        self.view.addConstraints(NSLayoutConstraint.constraintsWithVisualFormat("H:|-25-[email]-25-|", options: NSLayoutFormatOptions(0), metrics: nil, views: views))
        self.view.addConstraints(NSLayoutConstraint.constraintsWithVisualFormat("H:|-25-[signUp]-25-|", options: NSLayoutFormatOptions(0), metrics: nil, views: views))
        self.view.addConstraints(NSLayoutConstraint.constraintsWithVisualFormat("V:[fb(==40)]-10-[email(==40)]-10-[signUp(==40)]-30-|", options: NSLayoutFormatOptions(0), metrics: nil, views: views))
    }
    
    func setUpFBLogoAndLabel () {
        
        fbLabel.setTranslatesAutoresizingMaskIntoConstraints(false)
        fbLabel.backgroundColor = UIColor.clearColor()
        fbLabel.text = "CONNECT WITH FACEBOOK"
        fbLabel.textColor = UIColor.whiteColor()
        fbLabel.font = UIFont(name: "Montserrat-Regular", size: 14)
        fbButton.addSubview(fbLabel)
        
        fbLogoImageView.setTranslatesAutoresizingMaskIntoConstraints(false)
        fbLogoImageView.image = UIImage(named: "fbLogo.png")
        fbLogoImageView.contentMode = .ScaleAspectFit
        fbButton.addSubview(fbLogoImageView)
        
        let views = ["fbLogo": fbLogoImageView, "fbLabel": fbLabel]
        
        fbButton.addConstraint(NSLayoutConstraint(item: fbLogoImageView, attribute: .CenterY, relatedBy: .Equal, toItem: fbButton, attribute: .CenterY, multiplier: 1, constant: 0))
        fbButton.addConstraint(NSLayoutConstraint(item: fbLogoImageView, attribute: .Left, relatedBy: .Equal, toItem: fbButton, attribute: .Left, multiplier: 1, constant: 12))
        fbButton.addConstraint(NSLayoutConstraint(item: fbLabel, attribute: .CenterX, relatedBy: .Equal, toItem: fbButton, attribute: .CenterX, multiplier: 1, constant: 12))
        fbButton.addConstraints(NSLayoutConstraint.constraintsWithVisualFormat("H:[fbLogo(==25)]", options: NSLayoutFormatOptions(0), metrics: nil, views: views))
        fbButton.addConstraints(NSLayoutConstraint.constraintsWithVisualFormat("V:[fbLogo(==25)]", options: NSLayoutFormatOptions(0), metrics: nil, views: views))
        fbButton.addConstraints(NSLayoutConstraint.constraintsWithVisualFormat("V:[fbLabel(==35)]", options: NSLayoutFormatOptions(0), metrics: nil, views: views))
        fbButton.addConstraint(NSLayoutConstraint(item: fbLabel, attribute: .CenterY, relatedBy: .Equal, toItem: fbButton, attribute: .CenterY, multiplier: 1, constant: 0))
    }
    
    func setUpEmailLogoAndLabel () {
        
        emailLabel.setTranslatesAutoresizingMaskIntoConstraints(false)
        emailLabel.backgroundColor = UIColor.clearColor()
        emailLabel.text = "CONNECT WITH EMAIL"
        emailLabel.textColor = UIColor.whiteColor()
        emailLabel.font = UIFont(name: "Montserrat-Regular", size: 14)
        emailButton.addSubview(emailLabel)
        
        emailLogoImageView.setTranslatesAutoresizingMaskIntoConstraints(false)
        emailLogoImageView.image = UIImage(named: "emailicon.png")
        emailLogoImageView.contentMode = .ScaleAspectFit
        emailButton.addSubview(emailLogoImageView)
        
        let views = ["emailLogo": emailLogoImageView, "emailLabel": emailLabel]
        
        emailButton.addConstraint(NSLayoutConstraint(item: emailLogoImageView, attribute: .CenterY, relatedBy: .Equal, toItem: emailButton, attribute: .CenterY, multiplier: 1, constant: 0))
        emailButton.addConstraint(NSLayoutConstraint(item: emailLogoImageView, attribute: .Left, relatedBy: .Equal, toItem: emailButton, attribute: .Left, multiplier: 1, constant: 12))
        emailButton.addConstraint(NSLayoutConstraint(item: emailLabel, attribute: .CenterX, relatedBy: .Equal, toItem: emailButton, attribute: .CenterX, multiplier: 1, constant: 12))
        emailButton.addConstraints(NSLayoutConstraint.constraintsWithVisualFormat("H:[emailLogo(==25)]", options: NSLayoutFormatOptions(0), metrics: nil, views: views))
        emailButton.addConstraints(NSLayoutConstraint.constraintsWithVisualFormat("V:[emailLogo(==25)]", options: NSLayoutFormatOptions(0), metrics: nil, views: views))
        emailButton.addConstraints(NSLayoutConstraint.constraintsWithVisualFormat("V:[emailLabel(==35)]", options: NSLayoutFormatOptions(0), metrics: nil, views: views))
        emailButton.addConstraint(NSLayoutConstraint(item: emailLabel, attribute: .CenterY, relatedBy: .Equal, toItem: emailButton, attribute: .CenterY, multiplier: 1, constant: 0))
    }
    
    //MARK:  button actions
    
    func fbButtonTapped () {
        
        PFFacebookUtils.logInWithPermissions(self.permissions, block: { (user: PFUser?, error: NSError?) -> Void in
            if user == nil {
                
                println("Uh oh. The user cancelled the Facebook login.")
            }
            else if user!.isNew {
                
                println("User signed up and logged in through Facebook! \(user)")
                FBRequest.requestForMe()?.startWithCompletionHandler({(connection:FBRequestConnection!, result:AnyObject!, error:NSError!) in
                    
                    if(error != nil){
                        
                        println("Error Getting ME: \(error)");
                    }
                    else {
                        user?["facebookName"] = result["name"] as? String
                        
                        var URLString : String = String(format:"https://graph.facebook.com/%@/picture?type=large&return_ssl_resources=1", arguments:[result["id"] as! String])
                        var request: NSURLRequest = NSURLRequest(URL: NSURL(string: URLString)!)
                        NSURLConnection.sendAsynchronousRequest(request, queue: NSOperationQueue.mainQueue(), completionHandler: { (response: NSURLResponse!, data: NSData!, error: NSError!) -> Void in
                            if (error == nil && data != nil) {
                                let imageFile = PFFile(name: "profile.jpg", data: data)
                                user?["profileImage"] = imageFile
                                
                                user?.saveInBackgroundWithBlock({ (success: Bool, error:NSError?) -> Void in
                                    if success {
                                        //   it worked
                                        println("profile image posted")
                                    }
                                    else {
                                        println(error?.description)
                                    }
                                })
                            }
                        })
                        
                        user?.saveEventually({ (success, error) -> Void in
                            
                            let main = self.storyboard?.instantiateViewControllerWithIdentifier("mainContainer") as! ContainerViewController
                            self.presentViewController(main, animated: true, completion: nil)
                            
                        })
                    }
                });
                
                
            }
            else {
                println("User logged in through Facebook! \(user)")
                let main = self.storyboard?.instantiateViewControllerWithIdentifier("mainContainer") as! ContainerViewController
                self.presentViewController(main, animated: true, completion: nil)
            }
        })
    }
    
    func emailButtonTapped () {
        
        let emailVC = storyboard?.instantiateViewControllerWithIdentifier("connectEmail") as! JHConnectEmailVC
        presentViewController(emailVC, animated: true, completion: nil)
      
    }
    
    func signUpButtonTapped () {
        
        let emailVC = storyboard?.instantiateViewControllerWithIdentifier("signUp") as! JHSignUpVC
        presentViewController(emailVC, animated: true, completion: nil)
    }
    
    func instaButtonTapped () {
        
        //  still need this
        
    }
    
}







