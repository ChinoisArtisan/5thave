//
//  JHSignUpVC.swift
//  5thAve
//
//  Created by Johnny on 5/5/15.
//  Copyright (c) 2015 emagid. All rights reserved.
//

import UIKit
import CoreData

class JHSignUpVC: UIViewController, UITextFieldDelegate, UIScrollViewDelegate {
    
    let managedContext = (UIApplication.sharedApplication().delegate as! AppDelegate).managedObjectContext
    
    var mainContainer = UIView()
    var scrollView: UIScrollView!
    var containerView: UIView!
    
    var backgroundImageView: UIImageView = UIImageView()
    var logoImageView: UIImageView = UIImageView()
    var backButton: UIButton = UIButton()
    var emailTextField: UITextField = UITextField()
    var usernameTextField: UITextField = UITextField()
    var passwordTextField: UITextField = UITextField()
    var verifyPasswordTextField: UITextField = UITextField()
    var seperatorViewOne: UIView = UIView()
    var seperatorViewTwo: UIView = UIView()
    var seperatorViewThree: UIView = UIView()
    var seperatorViewFour: UIView = UIView()
    var continueButton: UIButton = UIButton()
    
    override func viewDidLoad() {
        
        super.viewDidLoad()
        
//        var center: NSNotificationCenter = NSNotificationCenter.defaultCenter()
//        center.addObserver(self, selector: "keyboardWillShow:", name: UIKeyboardWillShowNotification, object: nil)
//        center.addObserver(self, selector: "keyboardWillHide:", name: UIKeyboardWillHideNotification, object: nil)
        
        setUpBackgroundAndLogoImage()
        createMainContainer()
        createScrollView()
        createBackButton()
        createTextFields()
        createContinueButton()
    }
    
    override func viewDidLayoutSubviews() {
        
        super.viewDidLayoutSubviews()
        scrollView.frame = view.bounds
        containerView.frame = CGRectMake(0, 0, scrollView.contentSize.width, scrollView.contentSize.height)
    }
    
    func createMainContainer () {
        
        mainContainer.setTranslatesAutoresizingMaskIntoConstraints(false)
        mainContainer.backgroundColor = UIColor.clearColor()
        
        self.view.addSubview(mainContainer)
        
        let views = ["main": mainContainer, "logo": logoImageView]
        
        self.view.addConstraints(NSLayoutConstraint.constraintsWithVisualFormat("V:[logo]-10-[main]|", options: NSLayoutFormatOptions(0), metrics: nil, views: views))
        self.view.addConstraints(NSLayoutConstraint.constraintsWithVisualFormat("H:|[main]|", options: NSLayoutFormatOptions(0), metrics: nil, views: views))
    }
    
    func createScrollView() {
        
        scrollView = UIScrollView()
        scrollView.delegate = self
        scrollView.minimumZoomScale = 0
        scrollView.maximumZoomScale = 0
        scrollView.contentSize = CGSizeMake(view.frame.size.width, view.frame.size.height + 100)
        scrollView.backgroundColor = UIColor.clearColor()
        scrollView.userInteractionEnabled = true
        
        containerView = UIView()
        containerView.backgroundColor = UIColor.clearColor()
        containerView.userInteractionEnabled = true
        
        mainContainer.addSubview(scrollView)
        scrollView.addSubview(containerView)
    }
    
    func setUpBackgroundAndLogoImage () {
        
        backgroundImageView.setTranslatesAutoresizingMaskIntoConstraints(false)
        backgroundImageView.image = UIImage(named: "5thavebackground_640x1136.jpg")
        self.view.addSubview(backgroundImageView)
        
        logoImageView.setTranslatesAutoresizingMaskIntoConstraints(false)
        logoImageView.image = UIImage(named: "5thave_smalllogo.png")
        logoImageView.contentMode = .ScaleAspectFit
        self.view.addSubview(logoImageView)
        self.view.bringSubviewToFront(logoImageView)
        
        let views = ["back": backgroundImageView, "logo":logoImageView]
        
        self.view.addConstraints(NSLayoutConstraint.constraintsWithVisualFormat("V:|[back]|", options: NSLayoutFormatOptions(0), metrics: nil, views: views))
        self.view.addConstraints(NSLayoutConstraint.constraintsWithVisualFormat("H:|[back]|", options: NSLayoutFormatOptions(0), metrics: nil, views: views))
        
        self.view.addConstraint(NSLayoutConstraint(item: logoImageView, attribute: .CenterX, relatedBy: .Equal, toItem: self.view, attribute: .CenterX, multiplier: 1, constant: 0))
        self.view.addConstraints(NSLayoutConstraint.constraintsWithVisualFormat("V:|-60-[logo(==120)]", options: NSLayoutFormatOptions(0), metrics: nil, views: views))
        self.view.addConstraints(NSLayoutConstraint.constraintsWithVisualFormat("H:[logo(==120)]", options: NSLayoutFormatOptions(0), metrics: nil, views: views))
        self.view.addConstraint(NSLayoutConstraint(item: logoImageView, attribute: .CenterX, relatedBy: .Equal, toItem: self.view, attribute: .CenterX, multiplier: 1, constant: 0))
    }
    
    func createBackButton () {
        
        backButton.setTranslatesAutoresizingMaskIntoConstraints(false)
        backButton.backgroundColor = UIColor.clearColor()
        backButton.setTitle("BACK", forState: .Normal)
        backButton.setTitleColor(UIColor.whiteColor(), forState: .Normal)
        backButton.titleLabel?.font = UIFont(name: "Montserrat-Regular", size: 16)
        backButton.addTarget(self, action: "backButtonTapped", forControlEvents: .TouchUpInside)
        
        self.view.addSubview(backButton)
        self.view.addConstraint(NSLayoutConstraint(item: backButton, attribute: .Left, relatedBy: .Equal, toItem: self.view, attribute: .Left, multiplier: 1, constant: 15))
        self.view.addConstraint(NSLayoutConstraint(item: backButton, attribute: .Top, relatedBy: .Equal, toItem: self.view, attribute: .Top, multiplier: 1, constant: 20))
        self.view.addConstraint(NSLayoutConstraint(item: backButton, attribute: .Height, relatedBy: .Equal, toItem: self.view, attribute: .Height, multiplier: 0, constant: 40))
        self.view.addConstraint(NSLayoutConstraint(item: backButton, attribute: .Width, relatedBy: .Equal, toItem: self.view, attribute: .Width, multiplier: 0, constant: 80))
        
    }
    
    func backButtonTapped () {
        
        dismissViewControllerAnimated(true, completion: nil)
    }
    
    func createTextFields () {
        
        emailTextField.delegate = self
        emailTextField.setTranslatesAutoresizingMaskIntoConstraints(false)
        emailTextField.backgroundColor = UIColor.clearColor()
        emailTextField.attributedPlaceholder = NSAttributedString(string:"EMAIL ADDRESS",
            attributes:[NSForegroundColorAttributeName: UIColor.whiteColor()])
        emailTextField.font = UIFont(name: "Montserrat-Regular", size: 14)
        emailTextField.textAlignment = .Left
        emailTextField.textColor = UIColor.whiteColor()
        containerView.addSubview(emailTextField)
        
        seperatorViewOne.setTranslatesAutoresizingMaskIntoConstraints(false)
        seperatorViewOne.backgroundColor = UIColor.whiteColor()
        containerView.addSubview(seperatorViewOne)
        
        usernameTextField.delegate = self
        usernameTextField.setTranslatesAutoresizingMaskIntoConstraints(false)
        usernameTextField.backgroundColor = UIColor.clearColor()
        usernameTextField.attributedPlaceholder = NSAttributedString(string:"USERNAME",
            attributes:[NSForegroundColorAttributeName: UIColor.whiteColor()])
        usernameTextField.font = UIFont(name: "Montserrat-Regular", size: 14)
        usernameTextField.textAlignment = .Left
        usernameTextField.textColor = UIColor.whiteColor()
        containerView.addSubview(usernameTextField)
        
        seperatorViewTwo.setTranslatesAutoresizingMaskIntoConstraints(false)
        seperatorViewTwo.backgroundColor = UIColor.whiteColor()
        containerView.addSubview(seperatorViewTwo)
        
        passwordTextField.delegate = self
        passwordTextField.setTranslatesAutoresizingMaskIntoConstraints(false)
        passwordTextField.backgroundColor = UIColor.clearColor()
        passwordTextField.font = UIFont(name: "Montserrat-Regular", size: 14)
        passwordTextField.textAlignment = .Left
        passwordTextField.textColor = UIColor.whiteColor()
        passwordTextField.attributedPlaceholder = NSAttributedString(string:"PASSWORD",
            attributes:[NSForegroundColorAttributeName: UIColor.whiteColor()])
        passwordTextField.secureTextEntry = true
        containerView.addSubview(passwordTextField)
        
        seperatorViewThree.setTranslatesAutoresizingMaskIntoConstraints(false)
        seperatorViewThree.backgroundColor = UIColor.whiteColor()
        containerView.addSubview(seperatorViewThree)
        
        verifyPasswordTextField.delegate = self
        verifyPasswordTextField.setTranslatesAutoresizingMaskIntoConstraints(false)
        verifyPasswordTextField.backgroundColor = UIColor.clearColor()
        verifyPasswordTextField.font = UIFont(name: "Montserrat-Regular", size: 14)
        verifyPasswordTextField.textAlignment = .Left
        verifyPasswordTextField.textColor = UIColor.whiteColor()
        verifyPasswordTextField.attributedPlaceholder = NSAttributedString(string:"VERIFY PASSWORD",
            attributes:[NSForegroundColorAttributeName: UIColor.whiteColor()])
        verifyPasswordTextField.secureTextEntry = true
        containerView.addSubview(verifyPasswordTextField)
        
        seperatorViewFour.setTranslatesAutoresizingMaskIntoConstraints(false)
        seperatorViewFour.backgroundColor = UIColor.whiteColor()
        containerView.addSubview(seperatorViewFour)
        
        let views = ["email": emailTextField, "one": seperatorViewOne, "username": usernameTextField, "two": seperatorViewTwo, "password": passwordTextField, "three": seperatorViewThree, "verify": verifyPasswordTextField, "four": seperatorViewFour]
        
        containerView.addConstraints(NSLayoutConstraint.constraintsWithVisualFormat("V:|-20-[email(==40)]-4-[one(==1)]-4-[username(==40)]-4-[two(==1)]-4-[password(==40)]-4-[three(==1)]-4-[verify(==40)]-4-[four(==1)]", options: NSLayoutFormatOptions(0), metrics: nil, views: views))
        
        self.view.addConstraint(NSLayoutConstraint(item: emailTextField, attribute: .Left, relatedBy: .Equal, toItem: self.view, attribute: .Left, multiplier: 1, constant: 15))
        self.view.addConstraint(NSLayoutConstraint(item: emailTextField, attribute: .Right, relatedBy: .Equal, toItem: self.view, attribute: .Right, multiplier: 1, constant: -15))
        self.view.addConstraint(NSLayoutConstraint(item: seperatorViewOne, attribute: .Left, relatedBy: .Equal, toItem: self.view, attribute: .Left, multiplier: 1, constant: 15))
        self.view.addConstraint(NSLayoutConstraint(item: seperatorViewOne, attribute: .Right, relatedBy: .Equal, toItem: self.view, attribute: .Right, multiplier: 1, constant: -15))
        self.view.addConstraint(NSLayoutConstraint(item: usernameTextField, attribute: .Left, relatedBy: .Equal, toItem: self.view, attribute: .Left, multiplier: 1, constant: 15))
        self.view.addConstraint(NSLayoutConstraint(item: usernameTextField, attribute: .Right, relatedBy: .Equal, toItem: self.view, attribute: .Right, multiplier: 1, constant: -15))
        self.view.addConstraint(NSLayoutConstraint(item: seperatorViewTwo, attribute: .Left, relatedBy: .Equal, toItem: self.view, attribute: .Left, multiplier: 1, constant: 15))
        self.view.addConstraint(NSLayoutConstraint(item: seperatorViewTwo, attribute: .Right, relatedBy: .Equal, toItem: self.view, attribute: .Right, multiplier: 1, constant: -15))
        self.view.addConstraint(NSLayoutConstraint(item: passwordTextField, attribute: .Left, relatedBy: .Equal, toItem: self.view, attribute: .Left, multiplier: 1, constant: 15))
        self.view.addConstraint(NSLayoutConstraint(item: passwordTextField, attribute: .Right, relatedBy: .Equal, toItem: self.view, attribute: .Right, multiplier: 1, constant: -15))
        self.view.addConstraint(NSLayoutConstraint(item: seperatorViewThree, attribute: .Left, relatedBy: .Equal, toItem: self.view, attribute: .Left, multiplier: 1, constant: 15))
        self.view.addConstraint(NSLayoutConstraint(item: seperatorViewThree, attribute: .Right, relatedBy: .Equal, toItem: self.view, attribute: .Right, multiplier: 1, constant: -15))
        self.view.addConstraint(NSLayoutConstraint(item: verifyPasswordTextField, attribute: .Left, relatedBy: .Equal, toItem: self.view, attribute: .Left, multiplier: 1, constant: 15))
        self.view.addConstraint(NSLayoutConstraint(item: verifyPasswordTextField, attribute: .Right, relatedBy: .Equal, toItem: self.view, attribute: .Right, multiplier: 1, constant: -15))
        self.view.addConstraint(NSLayoutConstraint(item: seperatorViewFour, attribute: .Left, relatedBy: .Equal, toItem: self.view, attribute: .Left, multiplier: 1, constant: 15))
        self.view.addConstraint(NSLayoutConstraint(item: seperatorViewFour, attribute: .Right, relatedBy: .Equal, toItem: self.view, attribute: .Right, multiplier: 1, constant: -15))
    }
    
    func createContinueButton () {
        
        continueButton.setTranslatesAutoresizingMaskIntoConstraints(false)
        continueButton.backgroundColor = UIColor.whiteColor()
        continueButton.setTitle("CONTINUE", forState: .Normal)
        continueButton.setTitleColor(UIColor.blackColor(), forState: .Normal)
        continueButton.titleLabel?.font = UIFont(name: "Montserrat-Regular", size: 14)
        continueButton.addTarget(self, action: "continueButtonTapped", forControlEvents: .TouchUpInside)
        containerView.addSubview(continueButton)
        
        let views = ["four": seperatorViewFour, "continue": continueButton]
        
        self.view.addConstraints(NSLayoutConstraint.constraintsWithVisualFormat("V:[four]-10-[continue(==40)]", options: NSLayoutFormatOptions(0), metrics: nil, views: views))
        self.view.addConstraint(NSLayoutConstraint(item: continueButton, attribute: .Left, relatedBy: .Equal, toItem: self.view, attribute: .Left, multiplier: 1, constant: 15))
        self.view.addConstraint(NSLayoutConstraint(item: continueButton, attribute: .Right, relatedBy: .Equal, toItem: self.view, attribute: .Right, multiplier: 1, constant: -15))
    }
    
    func continueButtonTapped () {
        
        parseUserSignUp()
        println("continue tapped")
    }
    
    //  MARK:  textfield delegate
    
    //  temp fix
    func scrollUpKeyboard (textfield: UITextField) {
        
        self.scrollView .setContentOffset(CGPointMake(0, textfield.center.y - 40), animated: true)
        self .viewDidLayoutSubviews()
    }
    
    func textFieldDidBeginEditing(textField: UITextField) {
        
        switch(textField) {
        case emailTextField:
            emailTextField.becomeFirstResponder()
            //scrollUpKeyboard(emailTextField)
            
        case usernameTextField:
            usernameTextField.becomeFirstResponder()
            //scrollUpKeyboard(usernameTextField)
            
        case passwordTextField:
            passwordTextField.becomeFirstResponder()
             scrollUpKeyboard(passwordTextField)
          
        case verifyPasswordTextField:
            verifyPasswordTextField.becomeFirstResponder()
            scrollUpKeyboard(verifyPasswordTextField)
            
        default:
            break
        }
    }
    
    func textFieldDidEndEditing(textField: UITextField) {
        
        if textField == verifyPasswordTextField {
            
            if passwordTextField.text != verifyPasswordTextField.text {
                errorAlertController(passwordDoNotMatch())
            }
        }
        
        self.scrollView .setContentOffset(CGPointMake(0, 0), animated: true)
        self .viewDidLayoutSubviews()
    }
    func textFieldShouldReturn(textField: UITextField) -> Bool {
        
        textField.resignFirstResponder()
        return true
    }
    
    override func touchesBegan(touches: Set<NSObject>, withEvent event: UIEvent) {
        
        self.view.endEditing(true)
    }
    
    
    //MARK: Keyboard
    
    
    
    //MARK:  Parse
    func parseUserSignUp () {
        
        var user = PFUser()
        user.username = usernameTextField.text.lowercaseString
        user.password = passwordTextField.text
        user.email = emailTextField.text
        
        user.signUpInBackgroundWithBlock { (succeed: Bool, error: NSError?) -> Void in
            if let error = error {
                let errorString = error.userInfo?["error"] as? NSString
                
                switch error.code {
                    
                case 204:
                    self.errorAlertController(self.emailMissing())
                    
                case 125:
                    self.errorAlertController(self.emailInvalid())
                    
                case 203:
                    self.errorAlertController(self.emailTaken())
                    
                case 200:
                    self.errorAlertController(self.usernameMissing())
                    
                case 202:
                    self.errorAlertController(self.usernameTaken())
                    
                case 201:
                    self.errorAlertController(self.passwordMissing())
                    
                default:
                    println("something bad")
                }
            }
            else {
                let main = self.storyboard?.instantiateViewControllerWithIdentifier("mainContainer") as! ContainerViewController
                self.presentViewController(main, animated: true, completion: nil)
                println("everything worked")
            }
        }
    }
    
    // MARK:  Login Error AlertViews
    
    func errorAlertController (errorMessage: String) {
        
        let alertController = UIAlertController(title: "Error!", message: errorMessage, preferredStyle: .Alert)
        let okAction = UIAlertAction(title: "OK", style: .Default) { (action) in
        }
        alertController.addAction(okAction)
        self.presentViewController(alertController, animated: true) {
        }
    }
    
    func emailMissing () -> String {
        
        let message = "Missing Email address"
        return message
    }
    
    func emailInvalid () -> String {
        
        let message = "Invalid Email address"
        return message
    }
    
    func emailTaken () -> String {
        
        let message = "Email address already on file"
        return message
    }
    
    func usernameMissing () -> String {
        
        let message =  "Username field is empty"
        return message
    }
    
    func usernameTaken () -> String {
        
        let message = "Username taken, Try again."
        return message
    }
    
    func passwordMissing () -> String {
        
        let message = "Password field is empty"
        return message
    }
    
    func passwordDoNotMatch () -> String {
        
        let message = "Passwords do no match"
        return message
    }
}










