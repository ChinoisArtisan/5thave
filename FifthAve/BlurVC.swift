//
//  BlurVC.swift
//  FifthAve
//
//  Created by Johnny on 5/19/15.
//  Copyright (c) 2015 emagid. All rights reserved.
//

import UIKit

class BlurVC: UIViewController, UITextFieldDelegate {
    
    var forgotPassTextField = UITextField()
    var forgotSubmitButton = UIButton()
    var cancelButton = UIButton()
    
    override func viewDidLoad() {
        
        super.viewDidLoad()
        self.view.backgroundColor = .clearColor()
        
        let visuaEffectView = UIVisualEffectView(effect: UIBlurEffect(style: .Light))
        visuaEffectView.frame = self.view.bounds
        visuaEffectView.setTranslatesAutoresizingMaskIntoConstraints(false)
        self.view.addSubview(visuaEffectView)
        
        createSubViews()
    }
    
    func createSubViews () {
        
        forgotPassTextField.delegate = self
        forgotPassTextField.setTranslatesAutoresizingMaskIntoConstraints(false)
        forgotPassTextField.backgroundColor = UIColor.whiteColor()
        forgotPassTextField.font = UIFont(name: "Montserrat-Regular", size: 14)
        forgotPassTextField.placeholder = "Enter your email address"
        forgotPassTextField.textColor = UIColor.blackColor()
        forgotPassTextField.textAlignment = .Center
        self.view.addSubview(forgotPassTextField)
        
        forgotSubmitButton.setTranslatesAutoresizingMaskIntoConstraints(false)
        forgotSubmitButton.backgroundColor = UIColor.clearColor()
        forgotSubmitButton.titleLabel?.font = UIFont(name: "Montserrat-Regular", size: 16)
        forgotSubmitButton.setTitle("Submit", forState: .Normal)
        forgotSubmitButton.setTitleColor(UIColor.whiteColor(), forState: .Normal)
        forgotSubmitButton.addTarget(self, action: "forgotSubmitButtonTapped", forControlEvents: .TouchUpInside)
        self.view.addSubview(forgotSubmitButton)
        
        cancelButton.setTranslatesAutoresizingMaskIntoConstraints(false)
        cancelButton.backgroundColor = UIColor.clearColor()
        cancelButton.titleLabel?.font = UIFont(name: "Montserrat-Regular", size: 16)
        cancelButton.setTitle("Cancel", forState: .Normal)
        cancelButton.setTitleColor(UIColor.whiteColor(), forState: .Normal)
        cancelButton.addTarget(self, action: "cancelButtonTapped", forControlEvents: .TouchUpInside)
        self.view.addSubview(cancelButton)
        
        let views = ["text": forgotPassTextField, "submit": forgotSubmitButton, "cancel": cancelButton]
        
        self.view.addConstraints(NSLayoutConstraint.constraintsWithVisualFormat("H:|-20-[text]-20-|", options: NSLayoutFormatOptions(0), metrics: nil, views: views))
        self.view.addConstraints(NSLayoutConstraint.constraintsWithVisualFormat("V:|-160-[text(==40)]-12-[submit(==40)]", options: NSLayoutFormatOptions(0), metrics: nil, views: views))
        self.view.addConstraints(NSLayoutConstraint.constraintsWithVisualFormat("V:[text]-12-[cancel(==40)]", options: NSLayoutFormatOptions(0), metrics: nil, views: views))
        self.view.addConstraints(NSLayoutConstraint.constraintsWithVisualFormat("H:[submit(==80)]", options: NSLayoutFormatOptions(0), metrics: nil, views: views))
        self.view.addConstraints(NSLayoutConstraint.constraintsWithVisualFormat("H:[cancel(==80)]", options: NSLayoutFormatOptions(0), metrics: nil, views: views))
        self.view.addConstraint(NSLayoutConstraint(item: cancelButton, attribute: .CenterX, relatedBy: .Equal, toItem: self.view, attribute: .CenterX, multiplier: 1, constant: -60))
        self.view.addConstraint(NSLayoutConstraint(item: forgotSubmitButton, attribute: .CenterX, relatedBy: .Equal, toItem: self.view, attribute: .CenterX, multiplier: 1, constant: 60))
    }
    
    //MARK:  button actions
    
    func forgotSubmitButtonTapped () {
 
        resetPassword()
    }
    
    func cancelButtonTapped () {
        
        self.dismissViewControllerAnimated(true, completion: nil)
    }
    
    //MARK:  textfield delegate
    
    func textFieldShouldReturn(textField: UITextField) -> Bool {
        
        textField.resignFirstResponder()
        return true
    }
    
    override func touchesBegan(touches: Set<NSObject>, withEvent event: UIEvent) {
        
        self.view.endEditing(true)
    }
    
    func resetPassword () {
        
        let user = PFUser.currentUser()
        
        PFUser.requestPasswordResetForEmailInBackground(forgotPassTextField.text) { (Bool, error: NSError?) -> Void in
            
            if error != nil {
                switch error!.code {
                    
                case 100 :
                    self.errorAlertController(self.errorLoginTitle(), errorMessage: self.connectionFailedMessage())
                    
                case 204:
                    self.errorAlertController(self.errorLoginTitle(), errorMessage: self.emailEmptyMessage())
                    
                case 125:
                    self.errorAlertController(self.errorLoginTitle(), errorMessage: self.invalidEmail())
                    
                case 205:
                    self.errorAlertController(self.errorLoginTitle(), errorMessage: self.noEmailOnFile())
                    
                default:
                    println("something else bad")
                }
            }
            else {
                self.emailSentSuccessAlert(self.emailSentMessage())
                
                
            }
        }
    }
    
    //MARK:  Error handling
    
    func emailSentSuccessAlert (successMessage: String) {
        
        let alertController = UIAlertController(title: "Sent!", message: successMessage, preferredStyle: .Alert)
        let okAction = UIAlertAction(title: "OK", style: .Default) { (action) in
          
            self.dismissViewControllerAnimated(true, completion: nil)
        }
        
        alertController.addAction(okAction)
        self.presentViewController(alertController, animated: true) {
        }
    }
    
    func errorAlertController (errorTitle: String, errorMessage: String) {
        
        let alertController = UIAlertController(title: errorTitle, message: errorMessage, preferredStyle: .Alert)
        let okAction = UIAlertAction(title: "OK", style: .Default) { (action) in
        }
        
        alertController.addAction(okAction)
        self.presentViewController(alertController, animated: true) {
        }
    }
    
    func connectionFailedMessage () -> String {
        
        let connectFail = "No network connection. Please try again"
        return connectFail
    }
    
    func errorLoginTitle () -> String {
        
        let errorTitle = "Error!"
        return errorTitle
    }
    
    func noEmailOnFile () -> String {
        
        let noEmail = "Email address not on file. Try again"
        return noEmail
    }
    
    func invalidEmail () -> String {
        
        let invalid = "Email Address is invalid"
        return invalid
    }
    
    func emailEmptyMessage () -> String {
        
        let sentTitle = "Please enter email address"
        return sentTitle
    }
    
    func emailSentMessage () -> String {
        
        let message = "An email has been sent to \(forgotPassTextField.text)"
        return message
    }


}