//
//  JHConnectEmailVC.swift
//  5thAve
//
//  Created by Johnny on 5/4/15.
//  Copyright (c) 2015 emagid. All rights reserved.
//

import UIKit

class JHConnectEmailVC: UIViewController, UITextFieldDelegate {
    
    var backgroundImageView: UIImageView = UIImageView()
    var logoImageView: UIImageView = UIImageView()
    var backButton: UIButton = UIButton()
    var usernameTextField: UITextField = UITextField()
    var passwordTextField: UITextField = UITextField()
    var seperatorViewOne: UIView = UIView()
    var seperatorViewTwo: UIView = UIView()
    var signInButton: UIButton = UIButton()
    var forgotPasswordButton: UIButton = UIButton()

    var blurView = UIVisualEffectView()
    
    override func viewDidLoad() {
        
        super.viewDidLoad()
        
        setUpBackgroundAndLogoImage()
        createBackButton()
        createTextFields()
        createSignInAndForgotButtons()
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
    
    func createTextFields () {
        
        usernameTextField.delegate = self
        usernameTextField.setTranslatesAutoresizingMaskIntoConstraints(false)
        usernameTextField.backgroundColor = UIColor.clearColor()
        usernameTextField.attributedPlaceholder = NSAttributedString(string:"USERNAME",
            attributes:[NSForegroundColorAttributeName: UIColor.whiteColor()])
        usernameTextField.font = UIFont(name: "Montserrat-Regular", size: 14)
        usernameTextField.textAlignment = .Left
        usernameTextField.textColor = UIColor.whiteColor()
        self.view.addSubview(usernameTextField)
        
        seperatorViewOne.setTranslatesAutoresizingMaskIntoConstraints(false)
        seperatorViewOne.backgroundColor = UIColor.whiteColor()
        self.view.addSubview(seperatorViewOne)
        
        passwordTextField.delegate = self
        passwordTextField.setTranslatesAutoresizingMaskIntoConstraints(false)
        passwordTextField.backgroundColor = UIColor.clearColor()
        passwordTextField.placeholder = "PASSWORD"
        passwordTextField.font = UIFont(name: "Montserrat-Regular", size: 14)
        passwordTextField.textAlignment = .Left
        passwordTextField.textColor = UIColor.whiteColor()
        passwordTextField.attributedPlaceholder = NSAttributedString(string:"PASSWORD",
            attributes:[NSForegroundColorAttributeName: UIColor.whiteColor()])
        passwordTextField.secureTextEntry = true
        self.view.addSubview(passwordTextField)
        
        seperatorViewTwo.setTranslatesAutoresizingMaskIntoConstraints(false)
        seperatorViewTwo.backgroundColor = UIColor.whiteColor()
        self.view.addSubview(seperatorViewTwo)
        
        let views = ["logo": logoImageView, "username": usernameTextField, "one": seperatorViewOne, "password": passwordTextField, "two": seperatorViewTwo]
        
        self.view.addConstraints(NSLayoutConstraint.constraintsWithVisualFormat("V:[logo]-40-[username(==40)]-4-[one(==1)]-4-[password(==40)]-4-[two(==1)]", options: NSLayoutFormatOptions(0), metrics: nil, views: views))
        self.view.addConstraints(NSLayoutConstraint.constraintsWithVisualFormat("H:|-30-[username]-30-|", options: NSLayoutFormatOptions(0), metrics: nil, views: views))
        self.view.addConstraints(NSLayoutConstraint.constraintsWithVisualFormat("H:|-30-[one]-30-|", options: NSLayoutFormatOptions(0), metrics: nil, views: views))
        self.view.addConstraints(NSLayoutConstraint.constraintsWithVisualFormat("H:|-30-[password]-30-|", options: NSLayoutFormatOptions(0), metrics: nil, views: views))
        self.view.addConstraints(NSLayoutConstraint.constraintsWithVisualFormat("H:|-30-[two]-30-|", options: NSLayoutFormatOptions(0), metrics: nil, views: views))
    }
    
    func createSignInAndForgotButtons () {
        
        signInButton.setTranslatesAutoresizingMaskIntoConstraints(false)
        signInButton.backgroundColor = UIColor.whiteColor()
        signInButton.setTitle("SIGN IN", forState: .Normal)
        signInButton.setTitleColor(UIColor.blackColor(), forState: .Normal)
        signInButton.titleLabel?.font = UIFont(name: "Montserrat-Regular", size: 16)
        signInButton.addTarget(self, action: "signInButtonTapped", forControlEvents: .TouchUpInside)
        self.view.addSubview(signInButton)
        
        forgotPasswordButton.setTranslatesAutoresizingMaskIntoConstraints(false)
        forgotPasswordButton.backgroundColor = UIColor.clearColor()
        forgotPasswordButton.setTitle("FORGOT YOUR PASSWORD?", forState: .Normal)
        forgotPasswordButton.setTitleColor(UIColor.whiteColor(), forState: .Normal)
        forgotPasswordButton.titleLabel?.font = UIFont(name: "Montserrat-Regular", size: 14)
        forgotPasswordButton.addTarget(self, action: "forgotButtonTapped", forControlEvents: .TouchUpInside)
        self.view.addSubview(forgotPasswordButton)
        
        let views = ["two": seperatorViewTwo, "signIn": signInButton, "forgot": forgotPasswordButton]
        
        self.view.addConstraints(NSLayoutConstraint.constraintsWithVisualFormat("V:[two]-10-[signIn(==40)]-2-[forgot]", options: NSLayoutFormatOptions(0), metrics: nil, views: views))
        self.view.addConstraints(NSLayoutConstraint.constraintsWithVisualFormat("H:|-30-[signIn]-30-|", options: NSLayoutFormatOptions(0), metrics: nil, views: views))
        self.view.addConstraints(NSLayoutConstraint.constraintsWithVisualFormat("H:|-30-[forgot]-30-|", options: NSLayoutFormatOptions(0), metrics: nil, views: views))
    }
    
    //MARK:  button actions
    
    func backButtonTapped () {
        
        dismissViewControllerAnimated(true, completion: nil)
    }
    
    func signInButtonTapped () {
        
        parseLogin()
    }
    
    func forgotButtonTapped () {
        
        let modalViewController = BlurVC()
        modalViewController.modalPresentationStyle = .OverFullScreen
        self.presentViewController(modalViewController, animated: true, completion: nil)
    }
    
    //  MARK:  textfield delegate
    
    func textFieldDidBeginEditing(textField: UITextField) {
        
        switch(textField) {
        case usernameTextField:
            usernameTextField.becomeFirstResponder()
        
        case passwordTextField:
            passwordTextField.becomeFirstResponder()
        
        default:
            break
        }
    }
    
    func textFieldShouldReturn(textField: UITextField) -> Bool {
        
        textField.resignFirstResponder()
        return true
    }
    
    override func touchesBegan(touches: Set<NSObject>, withEvent event: UIEvent) {
        
        self.view.endEditing(true)
    }
    
    //MARK:  Parse Login
    
    func parseLogin () {
        
        PFUser.logInWithUsernameInBackground(usernameTextField.text.lowercaseString, password: passwordTextField.text) { (user: PFUser?, error: NSError?) -> Void in
            if user != nil {
               
                let main = self.storyboard?.instantiateViewControllerWithIdentifier("mainContainer") as! ContainerViewController
                self.presentViewController(main, animated: true, completion: nil)
                println("login success")
            }
            else {
                
                switch error!.code {
                    
                case 100 :
                    self.errorAlertController(self.errorLoginTitle(), errorMessage: self.connectionFailedMessage())
                    
                default:
                    self.errorAlertController(self.errorLoginTitle(), errorMessage: self.errorLoginMessage())
                }
            }
        }
    }
    
    //MARK:  Error handling
    
    func errorAlertController (errorTitle: String, errorMessage: String) {
        
        let alertController = UIAlertController(title: errorTitle, message: errorMessage, preferredStyle: .Alert)
        let okAction = UIAlertAction(title: "OK", style: .Default) { (action) in
            println("thsi is what i want")
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
    
    func errorLoginMessage () -> String {
        
        let errorMessage = "Username or password not correct"
        return errorMessage
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
}















