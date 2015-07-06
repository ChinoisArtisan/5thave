//
//  EditProfileViewController.swift
//  5thAve
//
//  Created by Emagid Corp on 4/15/15.
//  Copyright (c) 2015 Beyond 2021. All rights reserved.
//

import Foundation
import UIKit

class EditProfileViewController: UIViewController, UITextFieldDelegate, UITextViewDelegate, UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    
    let user = PFUser.currentUser()
    var picker = UIImagePickerController()
    
    @IBOutlet weak var aboutfield: UITextView!
    @IBOutlet weak var aboutconstraint: NSLayoutConstraint!

 
    @IBOutlet weak var userProfileImageView: PFImageView!

    @IBOutlet weak var userField: UITextField!
    @IBOutlet weak var emailField: UITextField!
    @IBOutlet weak var websiteField: UITextField!
    
    override func viewDidLoad() {
        
        super.viewDidLoad()
        
        self.setNavBarTitle("EDIT PROFILE")
        getCurrentUserParse()
        getUserProfilePic()
        
        Tools.sharedInstance.roundImageView(userProfileImageView, borderWitdh: 1.0)
        
        aboutfield.delegate = self
        aboutfield.textContainerInset = UIEdgeInsetsZero
        aboutfield.textContainer.lineFragmentPadding = 0
        
        userField.delegate = self
        emailField.delegate = self
        websiteField.delegate = self
        
    }
    
    override func viewWillAppear(animated: Bool) {
        
        super.viewWillAppear(animated)
        getUserProfilePic()
    }
    
    
    //MARK:  parse data
    
    func getCurrentUserParse () {
        
        if PFFacebookUtils.isLinkedWithUser(PFUser.currentUser()!) {
            userField.text = user?["facebookName"] as! String
            getUserEditProfileData()
        }
        else {
            userField.text = user?.username
            emailField.text = user?.email
            getUserEditProfileData()
        }
    }
    
    func getUserEditProfileData () {
        
        if let aboutMe: AnyObject = user?["aboutMe"] {
            aboutfield.text = user?["aboutMe"] as! String
        }
        
        if let website: AnyObject = user?["website"] {
            websiteField.text = user?["website"] as! String
        }
    }
    
    func getUserProfilePic () {
        self.userProfileImageView.image = nil
        
        if let userImageFile = user?["profileImage"] as? PFFile {
            self.userProfileImageView.file = userImageFile
            self.userProfileImageView.loadInBackground({ (image: UIImage?, error: NSError?) -> Void in
                if error == nil {
                    self.userProfileImageView.image = image
                }
                else {
                    println(error?.description)
                }
            })
        }
    }
    
    func saveProfilePic () {
        
        let postImage = userProfileImageView.image
        let imageData = UIImageJPEGRepresentation(postImage, 1.0)
        let imageFile = PFFile(name: "profile.jpg", data: imageData)
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
    
    //MARK:  button actions
    
    @IBAction func cameraButtonTapped(sender: AnyObject) {
        
        // remove this and move everything to browse and change it to edit
        println("camera monkey")
        
    }
    @IBAction func browseButtonTapped(sender: AnyObject) {
        
        createAlertViewController()
        println("browse bitches")
        
    }
    
    @IBAction func SaveClicked(sender: AnyObject) {
        
        if !aboutfield.text.isEmpty {
            user?["aboutMe"] = aboutfield.text
        }
        
        if !websiteField.text.isEmpty {
            user?["website"] = websiteField.text
        }
        user?.saveEventually({ (Bool, error: NSError?) -> Void in
            println("save success")
        })
        
//        user?.saveInBackgroundWithBlock({ (Bool, error: NSError?) -> Void in
//            println("save success")
//        })
    
        self.navigationController?.popViewControllerAnimated(true)
    }
    
    @IBAction func backbutton(sender: AnyObject) {
        self.navigationController?.popViewControllerAnimated(true)
    }
    
    //MARK:  Set up the new navigation bar
    func setNavBarTitle(title:String)
    {
        let tmplabel = UILabel()
        tmplabel.text = title
        tmplabel.font = UIFont(name: "Montserrat-Bold", size: 20)
        tmplabel.textColor = UIColor.whiteColor()
        tmplabel.backgroundColor = UIColor.clearColor()
        
        self.navigationItem.titleView = tmplabel
        self.navigationController?.navigationBar.backgroundColor = UIColor.blackColor()
        
        tmplabel.sizeToFit()
        
    }
    
    //MARK:  textview delegate
    
    func textViewDidChange(textView: UITextView) {
        let sizeFit = aboutfield.sizeThatFits(aboutfield.frame.size)
        aboutconstraint.constant = (sizeFit.height < 20) ? 20 : sizeFit.height
    }
    
    func textView(textView: UITextView, shouldChangeTextInRange range: NSRange, replacementText text: String) -> Bool {
        if (text == "\n")
        {
            aboutfield.resignFirstResponder()
            return false
        }
        
        return ((count(textView.text) - range.length + count(text)) <= 40)
    }
    
    func textViewShouldBeginEditing(textView: UITextView) -> Bool {
        if ((textView.text == "ABOUT ME") || (textView.text == ""))
        {
            textView.text = ""
        }

        return true
    }
    
    func textViewDidBeginEditing(textView: UITextView) {
        aboutfield.becomeFirstResponder()
    }
    
    func textViewDidEndEditing(textView: UITextView) {
        if ((textView.text == "ABOUT ME") || (textView.text == ""))
        {
            textView.text = "ABOUT ME"
        }
    }
    
    
    
    func textFieldShouldBeginEditing(textField: UITextField) -> Bool {
        switch(textField)
        {
        case userField:
            textField.text = (textField.text == "USERNAME") ? "" : textField.text
        case emailField:
            textField.text = (textField.text == "EMAIL") ? "" : textField.text
        default:
            textField.text = (textField.text == "WEBSITE") ? "" : textField.text
        }
        return true
    }
    

    
    func textFieldDidEndEditing (textField: UITextField) {
        switch(textField)
        {
        case userField:
            textField.text = (textField.text == "") ? "USERNAME" : textField.text
        case emailField:
            textField.text = (textField.text == "") ? "EMAIL" : textField.text
        default:
            textField.text = (textField.text == "") ? "WEBSITE" : textField.text
        }
    }
    
    func textFieldDidBeginEditing(textField: UITextField) {
        textField.becomeFirstResponder()
    }
    
    func textFieldShouldReturn(textField: UITextField) -> Bool {
        
        textField.resignFirstResponder()
        return true
    }
    
    override func touchesBegan(touches: Set<NSObject>, withEvent event: UIEvent) {
        
        self.view.endEditing(true)
    }
    
    //MARK:  camera photos
    
    func createAlertViewController () {
      
        
        let alertController = UIAlertController(title: "Choose Photo Option", message: nil, preferredStyle: .Alert)
        
        let takePhoto = UIAlertAction(title: "Take Photo", style: .Default) { action -> Void in
            self.takePhotoButtonTapped()
        }
        
        let cameraRoll = UIAlertAction(title: "Camera Roll", style: .Default) { action -> Void in
            self.presentLibrary()
        }
        
        let facebookPhoto = UIAlertAction(title: "Use Facebook picture", style: .Default) { action -> Void in
            self.takeFacebookPicture()
        }
        
        let cancelAction = UIAlertAction(title: "Cancel", style: .Cancel) { (_) in
            
        }
        
        alertController.addAction(takePhoto)
        alertController.addAction(cameraRoll)
        alertController.addAction(cancelAction)
        if PFFacebookUtils.isLinkedWithUser(PFUser.currentUser()!) {
            alertController.addAction(facebookPhoto)
        }
        
        presentViewController(alertController, animated: true, completion: nil)
    }
    
    func takePhotoButtonTapped () {
        
        if UIImagePickerController.availableCaptureModesForCameraDevice(.Rear) != nil {
            createpicker()
        }
        else {
            noCamera()
        }
    }
    
    func createpicker () {
        
        picker = UIImagePickerController()
        picker.delegate = self
        picker.definesPresentationContext = true
        picker.providesPresentationContextTransitionStyle = true
        picker.modalPresentationStyle = UIModalPresentationStyle.OverCurrentContext
        picker.allowsEditing = false
        picker.sourceType = UIImagePickerControllerSourceType.Camera
        picker.cameraCaptureMode = .Photo
        presentViewController(picker, animated: false, completion: nil)
    }
    
    func createpickerlibrary () {
        
        picker = UIImagePickerController()
        picker.delegate = self
        picker.definesPresentationContext = true
        picker.providesPresentationContextTransitionStyle = true
        picker.modalPresentationStyle = UIModalPresentationStyle.OverCurrentContext
        picker.sourceType = UIImagePickerControllerSourceType.Camera
        picker.allowsEditing = false
        picker.cameraCaptureMode = .Photo
    }
    
    
    func noCamera () {
        
        let alertVC = UIAlertController(title: "No Camera", message: "Sorry, this device has no camera", preferredStyle: .Alert)
        let okAction = UIAlertAction(title: "OK", style:.Default, handler: nil)
        alertVC.addAction(okAction)
        presentViewController(alertVC, animated: true, completion: nil)
    }
    
    func presentLibrary () {
        
        if UIImagePickerController.isSourceTypeAvailable(UIImagePickerControllerSourceType.PhotoLibrary) {
            createpickerlibrary()
            picker.sourceType = UIImagePickerControllerSourceType.PhotoLibrary
            picker.mediaTypes = [kUTTypeImage]
            picker.allowsEditing = false
            
            self.presentViewController(picker, animated: true, completion: nil)
        }
        else {
            // error msg
            println("error")
        }
    }
    
    func takeFacebookPicture () {
        SocialTools.sharedInstance.setFacebookProfileImage(self.userProfileImageView)
    }
    
    // picker returns with a photo
    
    func imagePickerController(picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [NSObject : AnyObject]) {
        
        var selectedImage = info[UIImagePickerControllerOriginalImage] as! UIImage
        
        if(picker.sourceType == UIImagePickerControllerSourceType.PhotoLibrary) {
            
            userProfileImageView.image = selectedImage
            saveProfilePic()
            dismissViewControllerAnimated(true, completion: nil)
        }
        else if picker.sourceType == UIImagePickerControllerSourceType.Camera {
            userProfileImageView.image = selectedImage
            saveProfilePic()
            dismissViewControllerAnimated(true, completion: nil)
        }
    }
    
    func imagePickerControllerDidCancel(picker: UIImagePickerController) {
        dismissViewControllerAnimated(true, completion: nil)
    }
}

























//