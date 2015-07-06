//
//  UploadPictureViewController.swift
//  5thAve
//
//  Created by Johnny on 5/6/15.
//  Copyright (c) 2015 emagid. All rights reserved.
//

import UIKit

class UploadPictureViewController: UIViewController, UITextViewDelegate, UIScrollViewDelegate {
    
    var mainContainer = UIView()
    
    var scrollView : UIScrollView!
    var containerView : UIView!
    
    var backButton = UIButton()
    var pictureImageView = UIImageView()
    var titleLabel = UILabel()
    var captionTextView = UITextView()
    var captionPlaceHolder = UILabel()
    var tagButton = UIButton()
    var tagIconImageView = UIImageView()
    var tagPeopleLabel = UILabel()
    var buttonContainer = UIView()
    var fbButton = UIButton()
    var fbbuttonLabel = UILabel()
    var fbButtonIconImageView = UIImageView()
    var instaButton = UIButton()
    var instaButtonLabel = UILabel()
    var instaButtonIconImageView = UIImageView()
    var postButton = UIButton()
    
    var postFBVC: PostFBContainerViewController?
    
    var captionHeight: NSLayoutConstraint!
    
    var bottomSpacingConstraint: NSLayoutConstraint!
    
    var post = PFObject(className: "Post")
    var backUpimage: UIImage = UIImage()
    var tagsPosition: [Tag] = []
    
    override func viewDidLoad() {
        
        super.viewDidLoad()
        createBackButton()
        createTitleLabel()
        createMainContainer()
        createScrollView()
        createPicImageView()
        createTextView()
        createTagButton()
        createFbAndInstaButtons()
        createPostButton()
        
        
//        NSNotificationCenter.defaultCenter().addObserver(self, selector: Selector("keyboardWillShow:"), name:UIKeyboardWillShowNotification, object: nil);
//        NSNotificationCenter.defaultCenter().addObserver(self, selector: Selector("keyboardWillHide:"), name:UIKeyboardWillHideNotification, object: nil);
    }
    
    override func viewWillAppear(animated: Bool) {
        
        super.viewWillAppear(animated)
        navigationController?.navigationBarHidden = true
        self.view.backgroundColor = UIColor.blackColor()
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
        
        let views = ["main": mainContainer, "title": titleLabel]
        
        self.view.addConstraints(NSLayoutConstraint.constraintsWithVisualFormat("V:[title]-10-[main]|", options: NSLayoutFormatOptions(0), metrics: nil, views: views))
        self.view.addConstraints(NSLayoutConstraint.constraintsWithVisualFormat("H:|[main]|", options: NSLayoutFormatOptions(0), metrics: nil, views: views))
    }
    
    func createScrollView() {
        
        scrollView = UIScrollView()
        scrollView.delegate = self
        scrollView.minimumZoomScale = 0
        scrollView.maximumZoomScale = 0
        scrollView.contentSize = CGSizeMake(view.frame.size.width, view.frame.size.height + view.frame.size.width)
        scrollView.backgroundColor = UIColor.blackColor()
        scrollView.userInteractionEnabled = true

        containerView = UIView()
        containerView.backgroundColor = UIColor.clearColor()
        containerView.userInteractionEnabled = true
    
        mainContainer.addSubview(scrollView)
        scrollView.addSubview(containerView)
    }

    func createBackButton () {
        
        backButton.setTranslatesAutoresizingMaskIntoConstraints(false)
        backButton.backgroundColor = UIColor.clearColor()
        backButton.setTitle("<", forState: .Normal)
        backButton.setTitleColor(UIColor.whiteColor(), forState: .Normal)
        backButton.titleLabel?.font = UIFont(name: "Montserrat-Regular", size: 22)
        backButton.addTarget(self, action: "backButtonTapped", forControlEvents: .TouchUpInside)
        
        let views = ["back": backButton]
        
        self.view.addSubview(backButton)
        self.view.addConstraints(NSLayoutConstraint.constraintsWithVisualFormat("V:|-10-[back(==40)]", options: NSLayoutFormatOptions(0), metrics: nil, views: views))
        self.view.addConstraints(NSLayoutConstraint.constraintsWithVisualFormat("H:|-10-[back(==60)]", options: NSLayoutFormatOptions(0), metrics: nil, views: views))
        
    }
    
    func createTitleLabel () {
        
        titleLabel.setTranslatesAutoresizingMaskIntoConstraints(false)
        titleLabel.text = "Upload"
        titleLabel.textColor = UIColor.whiteColor()
        titleLabel.font = UIFont(name: "Montserrat-Regular", size: 22)
        
        let views = ["back": backButton, "title": titleLabel]
        
        self.view.addSubview(titleLabel)
        self.view.addConstraints(NSLayoutConstraint.constraintsWithVisualFormat("V:|-10-[title(==40)]", options: NSLayoutFormatOptions(0), metrics: nil, views: views))
        self.view.addConstraints(NSLayoutConstraint.constraintsWithVisualFormat("H:[title(==100)]", options: NSLayoutFormatOptions(0), metrics: nil, views: views))
        self.view.addConstraint(NSLayoutConstraint(item: titleLabel, attribute: .CenterX, relatedBy: .Equal, toItem: self.view, attribute: .CenterX, multiplier: 1, constant: 0))
    }
    
    func backButtonTapped () {
        
        navigationController?.navigationBarHidden = false
        removeFromParentViewController()
        self.view.removeFromSuperview()
    }
    
    func createPicImageView () {

        pictureImageView.setTranslatesAutoresizingMaskIntoConstraints(false)
        pictureImageView.contentMode = .ScaleAspectFit
        
        let views = ["pic": pictureImageView]
        
        containerView.addSubview(pictureImageView)
        containerView.addConstraints(NSLayoutConstraint.constraintsWithVisualFormat("V:|-10-[pic(==260)]", options: NSLayoutFormatOptions(0), metrics: nil, views: views))
        containerView.addConstraints(NSLayoutConstraint.constraintsWithVisualFormat("H:[pic(==260)]", options: NSLayoutFormatOptions(0), metrics: nil, views: views))
        self.view.addConstraint(NSLayoutConstraint(item: pictureImageView, attribute: .CenterX, relatedBy: .Equal, toItem: self.view, attribute: .CenterX, multiplier: 1, constant: 0))
    }
    
    func createTextView () {
        
        captionTextView.delegate = self
        captionTextView.setTranslatesAutoresizingMaskIntoConstraints(false)
        captionTextView.backgroundColor = UIColor.clearColor()
        captionTextView.textColor = UIColor.whiteColor()
        captionTextView.font = UIFont(name: "Montserrat-Regular", size: 12)
        captionTextView.layer.borderWidth = 0.7
        captionTextView.layer.borderColor = UIColor.whiteColor().CGColor
        
        captionTextView.frame = CGRectMake(20, 150, 100, 80)
        captionTextView.tag = 100
        
        let views = ["pic": pictureImageView, "text": captionTextView]
        
        containerView.addSubview(captionTextView)
        
        captionHeight = NSLayoutConstraint(item: captionTextView, attribute: NSLayoutAttribute.Height, relatedBy: NSLayoutRelation.Equal, toItem: nil, attribute: NSLayoutAttribute.NotAnAttribute, multiplier: 1, constant: 40)
        self.view.addConstraint(captionHeight)
        
        containerView.addConstraints(NSLayoutConstraint.constraintsWithVisualFormat("V:[pic]-10-[text]", options: NSLayoutFormatOptions(0), metrics: nil, views: views))
        self.view.addConstraint(NSLayoutConstraint(item: captionTextView, attribute: .Left, relatedBy: .Equal, toItem: self.view, attribute: .Left, multiplier: 1, constant: 15))
        self.view.addConstraint(NSLayoutConstraint(item: captionTextView, attribute: .Right, relatedBy: .Equal, toItem: self.view, attribute: .Right, multiplier: 1, constant: -15))
        
        createTextViewPlaceHolderLabel()
    }
    
    func createTextViewPlaceHolderLabel () {
        
        captionPlaceHolder.setTranslatesAutoresizingMaskIntoConstraints(false)
        captionPlaceHolder.text = "Write Your Caption"
        captionPlaceHolder.textAlignment = .Left
        captionPlaceHolder.textColor = UIColor.whiteColor()
        captionPlaceHolder.font = UIFont(name: "Montserrat-Regular", size: 12)
        
        let views = ["placeHolder": captionPlaceHolder]
        
        captionTextView.addSubview(captionPlaceHolder)

        captionTextView.addConstraints(NSLayoutConstraint.constraintsWithVisualFormat("V:|-2-[placeHolder]", options: NSLayoutFormatOptions(0), metrics: nil, views: views))
        captionTextView.addConstraints(NSLayoutConstraint.constraintsWithVisualFormat("H:|-8-[placeHolder(==200)]", options: NSLayoutFormatOptions(0), metrics: nil, views: views))
    }

    //MARK:  Buttons
    
    func createTagButton () {
        
        let views = ["text": captionTextView, "icon": tagIconImageView, "label": tagPeopleLabel, "tagButton": tagButton]
        
        tagButton.setTranslatesAutoresizingMaskIntoConstraints(false)
        tagButton.backgroundColor = UIColor.clearColor()
        tagButton.addTarget(self, action: "tagButtonTapped", forControlEvents: .TouchUpInside)
        containerView.addSubview(tagButton)
        
        tagIconImageView.setTranslatesAutoresizingMaskIntoConstraints(false)
        tagIconImageView.image = UIImage(named: "tag_unselected@x2.png")
        tagIconImageView.contentMode = .ScaleAspectFit
        
        tagPeopleLabel.setTranslatesAutoresizingMaskIntoConstraints(false)
        tagPeopleLabel.backgroundColor = UIColor.clearColor()
        tagPeopleLabel.text = "TAG PEOPLE OR BRANDS"
        tagPeopleLabel.textAlignment = .Left
        tagPeopleLabel.textColor = UIColor.whiteColor()
        tagPeopleLabel.font = UIFont(name: "Montserrat-Regular", size: 14)
        
        tagButton.addSubview(tagPeopleLabel)
        tagButton.addSubview(tagIconImageView)
        containerView.addConstraints(NSLayoutConstraint.constraintsWithVisualFormat("V:[text]-10-[tagButton(==35)]", options: NSLayoutFormatOptions(0), metrics: nil, views: views))
        self.view.addConstraint(NSLayoutConstraint(item: tagButton, attribute: .Left, relatedBy: .Equal, toItem: self.view, attribute: .Left, multiplier: 1, constant: 15))
        self.view.addConstraint(NSLayoutConstraint(item: tagButton, attribute: .Right, relatedBy: .Equal, toItem: self.view, attribute: .Right, multiplier: 1, constant: -15))
        tagButton.addConstraints(NSLayoutConstraint.constraintsWithVisualFormat("H:|-15-[icon(==20)]-10-[label(==220)]", options: NSLayoutFormatOptions(0), metrics: nil, views: views))
        tagButton.addConstraints(NSLayoutConstraint.constraintsWithVisualFormat("V:[icon(==20)]", options: NSLayoutFormatOptions(0), metrics: nil, views: views))
        tagButton.addConstraint(NSLayoutConstraint(item: tagIconImageView, attribute: .CenterY, relatedBy: .Equal, toItem: tagButton, attribute: .CenterY, multiplier: 1, constant: 0))
        tagButton.addConstraints(NSLayoutConstraint.constraintsWithVisualFormat("V:|[label(==35)]|", options: NSLayoutFormatOptions(0), metrics: nil, views: views))
        
    }
    
    func createFbAndInstaButtons () {
        
        buttonContainer.setTranslatesAutoresizingMaskIntoConstraints(false)
        buttonContainer.backgroundColor = UIColor.redColor()
        buttonContainer.userInteractionEnabled = true
        containerView.addSubview(buttonContainer)
        
        fbButton.setTranslatesAutoresizingMaskIntoConstraints(false)
        fbButton.backgroundColor = AppColor.fbBlueColor()
        fbButton.addTarget(self, action: "fbButtonTapped", forControlEvents: .TouchUpInside)
        
        instaButton.setTranslatesAutoresizingMaskIntoConstraints(false)
        instaButton.backgroundColor = AppColor.instaBlueColor()
        instaButton.addTarget(self, action: "instaButtonTapped", forControlEvents: .TouchUpInside)
        
        let views = ["tagButton": tagButton, "fbButton": fbButton, "instaButton": instaButton, "container": buttonContainer]
        
        buttonContainer.addSubview(fbButton)
        buttonContainer.addSubview(instaButton)
        containerView.addConstraints(NSLayoutConstraint.constraintsWithVisualFormat("V:[tagButton]-10-[container(==40)]", options: NSLayoutFormatOptions(0), metrics: nil, views: views))
        self.view.addConstraint(NSLayoutConstraint(item: buttonContainer, attribute: .Left, relatedBy: .Equal, toItem: self.view, attribute: .Left, multiplier: 1, constant: 15))
        self.view.addConstraint(NSLayoutConstraint(item: buttonContainer, attribute: .Right, relatedBy: .Equal, toItem: self.view, attribute: .Right, multiplier: 1, constant: -15))
    
        buttonContainer.addConstraints(NSLayoutConstraint.constraintsWithVisualFormat("H:|[fbButton][instaButton]|", options: NSLayoutFormatOptions(0), metrics: nil, views: views))
        buttonContainer.addConstraints(NSLayoutConstraint.constraintsWithVisualFormat("V:|[fbButton]|", options: NSLayoutFormatOptions(0), metrics: nil, views: views))
        buttonContainer.addConstraints(NSLayoutConstraint.constraintsWithVisualFormat("V:|[instaButton]|", options: NSLayoutFormatOptions(0), metrics: nil, views: views))
        buttonContainer.addConstraint(NSLayoutConstraint(item: fbButton, attribute: .Width, relatedBy: .Equal, toItem: instaButton, attribute: .Width, multiplier: 1, constant: 0))
        
        setUpFBLogoAndLabel()
        setUpInstaLogoAndLabel()
    }
    
    func setUpFBLogoAndLabel () {
        
        fbbuttonLabel.setTranslatesAutoresizingMaskIntoConstraints(false)
        fbbuttonLabel.backgroundColor = UIColor.clearColor()
        fbbuttonLabel.text = "FACEBOOK"
        fbbuttonLabel.textColor = UIColor.whiteColor()
        fbbuttonLabel.font = UIFont(name: "Montserrat-Regular", size: 12)
        fbButton.addSubview(fbbuttonLabel)
        
        fbButtonIconImageView.setTranslatesAutoresizingMaskIntoConstraints(false)
        fbButtonIconImageView.image = UIImage(named: "fbLogo.png")
        fbButtonIconImageView.contentMode = .ScaleAspectFit
        fbButton.addSubview(fbButtonIconImageView)
        
        let views = ["fbLogo": fbButtonIconImageView, "fbLabel": fbbuttonLabel]
        
        fbButton.addConstraint(NSLayoutConstraint(item: fbButtonIconImageView, attribute: .CenterY, relatedBy: .Equal, toItem: fbButton, attribute: .CenterY, multiplier: 1, constant: 0))
        fbButton.addConstraint(NSLayoutConstraint(item: fbButtonIconImageView, attribute: .Left, relatedBy: .Equal, toItem: fbButton, attribute: .Left, multiplier: 1, constant: 10))
        fbButton.addConstraints(NSLayoutConstraint.constraintsWithVisualFormat("H:[fbLogo(==25)]-15-[fbLabel]-5-|", options: NSLayoutFormatOptions(0), metrics: nil, views: views))
        fbButton.addConstraints(NSLayoutConstraint.constraintsWithVisualFormat("V:[fbLogo(==25)]", options: NSLayoutFormatOptions(0), metrics: nil, views: views))
        fbButton.addConstraints(NSLayoutConstraint.constraintsWithVisualFormat("V:[fbLabel(==35)]", options: NSLayoutFormatOptions(0), metrics: nil, views: views))
        fbButton.addConstraint(NSLayoutConstraint(item: fbbuttonLabel, attribute: .CenterY, relatedBy: .Equal, toItem: fbButton, attribute: .CenterY, multiplier: 1, constant: 0))
        
    }
    
    func setUpInstaLogoAndLabel () {
        
        instaButtonLabel.setTranslatesAutoresizingMaskIntoConstraints(false)
        instaButtonLabel.backgroundColor = UIColor.clearColor()
        instaButtonLabel.text = "INSTAGRAM"
        instaButtonLabel.textColor = UIColor.whiteColor()
        instaButtonLabel.font = UIFont(name: "Montserrat-Regular", size: 12)
        instaButton.addSubview(instaButtonLabel)
        
        instaButtonIconImageView.setTranslatesAutoresizingMaskIntoConstraints(false)
        instaButtonIconImageView.image = UIImage(named: "instaLogo.png")
        instaButtonIconImageView.contentMode = .ScaleAspectFit
        instaButton.addSubview(instaButtonIconImageView)
        
        let views = ["instaLogo": instaButtonIconImageView, "instaLabel": instaButtonLabel]
        
        instaButton.addConstraint(NSLayoutConstraint(item: instaButtonIconImageView, attribute: .CenterY, relatedBy: .Equal, toItem: instaButton, attribute: .CenterY, multiplier: 1, constant: 0))
        instaButton.addConstraint(NSLayoutConstraint(item: instaButtonIconImageView, attribute: .Left, relatedBy: .Equal, toItem: instaButton, attribute: .Left, multiplier: 1, constant: 10))
        instaButton.addConstraints(NSLayoutConstraint.constraintsWithVisualFormat("H:[instaLogo(==25)]-15-[instaLabel]-5-|", options: NSLayoutFormatOptions(0), metrics: nil, views: views))
        instaButton.addConstraints(NSLayoutConstraint.constraintsWithVisualFormat("V:[instaLogo(==25)]", options: NSLayoutFormatOptions(0), metrics: nil, views: views))
        instaButton.addConstraints(NSLayoutConstraint.constraintsWithVisualFormat("V:[instaLabel(==35)]", options: NSLayoutFormatOptions(0), metrics: nil, views: views))
        instaButton.addConstraint(NSLayoutConstraint(item: instaButtonLabel, attribute: .CenterY, relatedBy: .Equal, toItem: instaButton, attribute: .CenterY, multiplier: 1, constant: 0))
    }
    
    func createPostButton () {
        
        postButton.setTranslatesAutoresizingMaskIntoConstraints(false)
        postButton.backgroundColor = UIColor.whiteColor()
        postButton.setTitle("POST", forState: .Normal)
        postButton.setTitleColor(UIColor.blackColor(), forState: .Normal)
        postButton.addTarget(self, action: "postButtonTapped", forControlEvents: .TouchUpInside)
        
        let views = ["container": buttonContainer, "post": postButton]
        
        containerView.addSubview(postButton)
        containerView.addConstraints(NSLayoutConstraint.constraintsWithVisualFormat("V:[container]-10-[post(==40)]", options: NSLayoutFormatOptions(0), metrics: nil, views: views))
        self.view.addConstraint(NSLayoutConstraint(item: postButton, attribute: .Left, relatedBy: .Equal, toItem: self.view, attribute: .Left, multiplier: 1, constant: 15))
        self.view.addConstraint(NSLayoutConstraint(item: postButton, attribute: .Right, relatedBy: .Equal, toItem: self.view, attribute: .Right, multiplier: 1, constant: -15))
    }
    
    func createPostFBContainerView () {
        
        postFBVC = storyboard?.instantiateViewControllerWithIdentifier("postFB") as? PostFBContainerViewController
        postFBVC!.titleLabel.text = "FACEBOOK"
        postFBVC!.contentImageView.image = pictureImageView.image
        postFBVC!.cancelButton.addTarget(self, action: "cancelButtonTapped", forControlEvents: .TouchUpInside)
        postFBVC!.postButton.addTarget(self, action: "postFBTapped", forControlEvents: .TouchUpInside)
        
        presentViewController(postFBVC!, animated: true, completion: nil)
    }
    
    func createPostInstaView () {
        
        postFBVC = storyboard?.instantiateViewControllerWithIdentifier("postFB") as? PostFBContainerViewController
        postFBVC!.titleLabel.text = "INSTAGRAM"
        postFBVC!.contentImageView.image = pictureImageView.image
        postFBVC!.cancelButton.addTarget(self, action: "cancelButtonTapped", forControlEvents: .TouchUpInside)
        postFBVC!.postButton.addTarget(self, action: "postInstagramTapped", forControlEvents: .TouchUpInside)
        
        presentViewController(postFBVC!, animated: true, completion: nil)
    }
    
    //MARK:  button actions
    
    func cancelButtonTapped () {
        
        //navigationController?.navigationBarHidden = true
        dismissViewControllerAnimated(true, completion: nil)
    }
    
    func tagButtonTapped () {
        
        let tagVC = storyboard?.instantiateViewControllerWithIdentifier("tagVC") as! TagPicViewController
        tagVC.tagImageView.image = backUpimage
        tagVC.delegate = self
        
        presentViewController(tagVC, animated: true, completion: nil)
        println("tag tapped")
    }
    
    func fbButtonTapped () {
        
        createPostFBContainerView()
        println("fb tapped")
    }
    
    func instaButtonTapped () {
        
        createPostInstaView()
        println("insta tapped")
    }
    
    func postButtonTapped () {
        
        println("post tapped")
        parsePost()
        backButtonTapped ()
    }

    // MARK:  UIScrollViewDelegate
    
    func scrollViewWillBeginZooming(scrollView: UIScrollView, withView view: UIView!) {
        
    }
    func scrollViewDidZoom(scrollView: UIScrollView) {
       
    }
    func scrollViewDidEndZooming(scrollView: UIScrollView, withView view: UIView!, atScale scale: CGFloat) {
     
    }
    func scrollViewDidEndDecelerating(scrollView: UIScrollView) {
       
    }
    func scrollViewDidEndDragging(scrollView: UIScrollView, willDecelerate decelerate: Bool) {
       
    }
    func scrollViewWillBeginDragging(scrollView: UIScrollView) {
        
    }
    func scrollViewDidScroll(scrollView: UIScrollView) {
        
       
    }
    func viewForZoomingInScrollView(scrollView: UIScrollView) -> UIView? {
        
        return containerView
    }
    
    //MARK:  UITextFieldDelegate
    
    func textViewDidBeginEditing(textView: UITextView) {
        
        if textView.tag == 100 {
            captionPlaceHolder.hidden = true
            
            self.scrollView .setContentOffset(CGPointMake(0, textView.center.y-180), animated: true)
            self .viewDidLayoutSubviews()
        }
    }
    
    func textViewDidEndEditing(textView: UITextView) {
        
        if textView.text.isEmpty {
            captionPlaceHolder.hidden = false
        
        }
        self.scrollView .setContentOffset(CGPointMake(0, 0), animated: true)
        self .viewDidLayoutSubviews()
    }
    
    func textViewDidChange(textView: UITextView) {
        let sizeFit = captionTextView.sizeThatFits(captionTextView.frame.size)
        captionHeight.constant = (sizeFit.height < 40) ? 40 : sizeFit.height
    }
    
    func textView(textView: UITextView, shouldChangeTextInRange range: NSRange, replacementText text: String) -> Bool {
        
        //  dismiss keyboard on return key
        if text == "\n" {
            textView.resignFirstResponder()
            return false
        }
        if text == "\u{8}" {
            return true
        }
        return ((count(textView.text) - range.length + count(text)) <= 130)
    }
    
//    func textView(textView: UITextView, shouldChangeTextInRange range: NSRange, replacementText text: String) -> Bool {
    
    override func touchesBegan(touches: Set<NSObject>, withEvent event: UIEvent) {
        
        self.view.endEditing(true)
    }
    
    //MARK:  Keyboard
    
    func keyboardWillShow(notification: NSNotification) {
        
        
    }
    
    //MARK:  Parse
    
    func parsePost () {
        
        var user = PFUser.currentUser()
        user?.incrementKey("numberOfPosts")
        user?.saveInBackgroundWithBlock({ (success: Bool, error: NSError?) -> Void in
            if success {
                println("posts been incremented")
            }
            else {
                println(error?.description)
            }
        })
        
        let postImage = backUpimage
        let imageData = UIImageJPEGRepresentation(postImage, 1.0)
        let imageFile = PFFile(name: "image.jpg", data: imageData)
        
        
        post["user"] = user
        post["comment"] = captionTextView.text
        post["username"] = user?.username
        post["postImage"] = imageFile
        post["numberOfLikes"] = 0
        post.addObjectsFromArray(getPFObject(), forKey: "postTags")
        
        
        println(post)
        
        post.saveInBackgroundWithBlock { (success: Bool, error: NSError?) -> Void in
            if (success) {
                //  saved worked
                println("something happened")
            }
            else {
                //  error
                println(error?.description)
            }
        }
    }
    
    
    func getPFObject() -> [PFObject] {
        var tmp: [PFObject] = []
        
        for tag in self.tagsPosition {
            tmp.append(ParseQuery.sharedInstance.getPostTagObject(Int(tag.position.x), yCoordinate: Int(tag.position.y), tagName: tag.name))
        }
        
        return tmp
    }
}










