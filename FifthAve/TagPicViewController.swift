//
//  TagPicViewController.swift
//  5thAve
//
//  Created by Johnny on 5/8/15.
//  Copyright (c) 2015 emagid. All rights reserved.
//

import UIKit

class TagPicViewController: UIViewController, UIGestureRecognizerDelegate, UITextFieldDelegate{
    
    var tagImageView = UIImageView()
    var backButton = UIButton()
    var doneButton = UIButton()
    var tagView = UIView()
    var tapPhotoLabel = UILabel()
    var tagIconImageView = UIImageView()
    var tagdeletebutton = UIButton()
    
    var taptag: UITapGestureRecognizer?
    
    let tagwidth = 83.0
    let tagheight = 30.0
    var ratio: CGFloat = 0.0
    
    var newFrame: CGRect?
    
    var deletestate: Bool = false
    
    var delegate: UploadPictureViewController?
    
    override func viewDidLoad() {
        
        super.viewDidLoad()
        view.backgroundColor = UIColor.blackColor()
        
        createBackAndDoneButtons()
        createTagImageView()
        createTapPhotoLabel()
        createTagIconImageView()
    }
    
    override func viewDidAppear(animated: Bool) {
        super.viewDidAppear(animated)
        calculatesize(self.tagImageView.image?.size, destinationSize: self.tagImageView.bounds.size)
        addInteraction()
        addOldTag()
    }
    
    override func prefersStatusBarHidden() -> Bool {
        return true
    }
    
    
    func addOldTag() {
        var tags = self.delegate!.tagsPosition
        
        for tag in tags {
            addButton(CGPoint(x: self.newFrame!.origin.x + ratio * tag.position.x - CGFloat(tagwidth / 2), y: self.newFrame!.origin.y + ratio * tag.position.y), respond: false, text: tag.name)
        }
    }
    
    func addInteraction ()
    {
        tagImageView.userInteractionEnabled = true
        taptag = UITapGestureRecognizer(target: self, action: "tapAction:")
        taptag!.numberOfTapsRequired = 1
        
        self.tagImageView.gestureRecognizers?.removeAll(keepCapacity: false)
        self.tagImageView.addGestureRecognizer(taptag!)
    }
    
    func tapAction(sender:UITapGestureRecognizer)
    {
        if !checkResponder() {
            
            var tapposition = sender.locationInView(self.tagImageView)
            tapposition.x = tapposition.x - CGFloat(tagwidth / 2.0)
            if (isPositionInsideTheFrame(self.newFrame!, position: tapposition))
            {
                //Add button at this position
                addButton(tapposition, respond: true, text: "")
            }
        }
    }
    
    
    func addButton (position: CGPoint, respond: Bool, text: String)
    {
        let tag = UITextField(frame: CGRect(origin: position, size: CGSize(width: tagwidth, height: tagheight)))
        tag.text = text
        tag.borderStyle = UITextBorderStyle.None
        tag.textColor = UIColor.whiteColor()
        tag.background = UIImage(named: "tag.png")
        tag.font = UIFont(name: "Montserrat-Bold", size: 11)
        
        tag.adjustsFontSizeToFitWidth = true
        tag.minimumFontSize = 7.0
        tag.contentVerticalAlignment = UIControlContentVerticalAlignment.Center
        tag.contentHorizontalAlignment = UIControlContentHorizontalAlignment.Center
        tag.textAlignment = NSTextAlignment.Center
        tag.delegate = self
        
        let tapedit = UITapGestureRecognizer(target: self, action: "deletetag:")
        tapedit.numberOfTapsRequired = 1
        
        
        let panRec = UIPanGestureRecognizer(target: self, action: "moveView:")
        
        self.tagImageView.addSubview(tag)
        
        if respond {
            tag.becomeFirstResponder()
        }
        
        taptag!.requireGestureRecognizerToFail(tapedit)
        taptag!.requireGestureRecognizerToFail(panRec)
        
        tag.addGestureRecognizer(panRec)
        tag.addGestureRecognizer(tapedit)
    }
    
    func deletetag(sender:UITapGestureRecognizer)
    {
        if deletestate
        {
            sender.view?.removeFromSuperview()
        }
    }
    
    func moveView(sender:UIPanGestureRecognizer)
    {
        self.tagImageView.bringSubviewToFront(sender.view!)
        var translation = sender.translationInView(self.view)
        
        let futurepoint = CGPointMake(sender.view!.frame.origin.x + translation.x, sender.view!.frame.origin.y + translation.y)
        if isPositionInsideTheFrame(self.newFrame!, position: futurepoint)
        {
            sender.view!.frame.origin = futurepoint
        }
        sender.setTranslation(CGPointZero, inView: self.view)
    }
    
    
    func isPositionInsideTheFrame(frame: CGRect, position: CGPoint) -> Bool
    {
        return (((position.x >= frame.origin.x) && (position.x <= (frame.origin.x + frame.size.width))) && ((position.y >= frame.origin.y) && (position.y <= (frame.origin.y + frame.size.height))) )
    }
    
    func calculatesize (image: CGSize?, destinationSize:CGSize)
    {
        var imagewidth = image!.width
        var imageheight = image!.height
        
        var newSize: CGSize
        var newPoint: CGPoint
        
        if (imagewidth > imageheight)
        {
            ratio = destinationSize.width / imagewidth
        }
        else
        {
            ratio = destinationSize.height / imageheight
        }
        
        
        newSize = CGSize(width: ratio * imagewidth, height: ratio * imageheight)
        
        if (newSize.width > destinationSize.width)
        {
            ratio = destinationSize.width / imagewidth
            newSize = CGSize(width: ratio * imagewidth, height: ratio * imageheight)
        }
        if (newSize.height > destinationSize.height)
        {
            ratio = destinationSize.height / imageheight
            newSize = CGSize(width: ratio * imagewidth, height: ratio * imageheight)
        }
        
        
        newPoint = CGPointMake(abs(destinationSize.width - newSize.width) / 2, abs(destinationSize.height - newSize.height) / 2)
        newSize.height -= CGFloat(tagheight)
        newSize.width -= CGFloat(tagwidth)
        
        self.newFrame = CGRect(origin: newPoint, size: newSize)
    }
    
    
    func createBackAndDoneButtons () {
        
        backButton.setTranslatesAutoresizingMaskIntoConstraints(false)
        backButton.backgroundColor = UIColor.clearColor()
        backButton.setTitle("<", forState: .Normal)
        backButton.setTitleColor(UIColor.whiteColor(), forState: .Normal)
        backButton.titleLabel?.font = UIFont(name: "Montserrat-Regular", size: 22)
        backButton.addTarget(self, action: "backButtonTapped", forControlEvents: .TouchUpInside)
        
        doneButton.setTranslatesAutoresizingMaskIntoConstraints(false)
        doneButton.backgroundColor = UIColor.clearColor()
        doneButton.setTitle("Done", forState: .Normal)
        doneButton.setTitleColor(UIColor.whiteColor(), forState: .Normal)
        doneButton.titleLabel?.font = UIFont(name: "Montserrat-Regular", size: 22)
        doneButton.addTarget(self, action: "doneButtonTapped", forControlEvents: .TouchUpInside)
        
        let views = ["back": backButton, "done": doneButton]
        
        view.addSubview(backButton)
        view.addSubview(doneButton)
        view.addConstraints(NSLayoutConstraint.constraintsWithVisualFormat("V:|-10-[back(==40)]", options: NSLayoutFormatOptions(0), metrics: nil, views: views))
        view.addConstraints(NSLayoutConstraint.constraintsWithVisualFormat("H:|-10-[back(==80)]", options: NSLayoutFormatOptions(0), metrics: nil, views: views))
        view.addConstraints(NSLayoutConstraint.constraintsWithVisualFormat("V:|-10-[done(==40)]", options: NSLayoutFormatOptions(0), metrics: nil, views: views))
        view.addConstraints(NSLayoutConstraint.constraintsWithVisualFormat("H:[done(==80)]-10-|", options: NSLayoutFormatOptions(0), metrics: nil, views: views))
        
    }
    
    func backButtonTapped () {
        dismissViewControllerAnimated(true, completion: nil)
        println("back")
    }
    
    func doneButtonTapped  () {
        self.delegate?.tagsPosition = getTagPosition()
        self.delegate?.pictureImageView.image = getImageView()
        println("done Tapped")
        dismissViewControllerAnimated(true, completion: nil)
    }
    
    func createTagImageView () {
        
        tagImageView.setTranslatesAutoresizingMaskIntoConstraints(false)
        tagImageView.contentMode = .ScaleAspectFit
        tagImageView.userInteractionEnabled = true
        
        //tagImageView.backgroundColor = UIColor.blueColor()
        //tagImageView.addGestureRecognizer(UITapGestureRecognizer(target: self, action: "tagViewTapped:"))
        
        let views = ["pic": tagImageView, "done": doneButton]
        
        view.addSubview(tagImageView)
        view.addConstraints(NSLayoutConstraint.constraintsWithVisualFormat("V:[done]-20-[pic(==300)]", options: NSLayoutFormatOptions(0), metrics: nil, views: views))
        view.addConstraints(NSLayoutConstraint.constraintsWithVisualFormat("H:|-10-[pic]-10-|", options: NSLayoutFormatOptions(0), metrics: nil, views: views))
        view.addConstraint(NSLayoutConstraint(item: tagImageView, attribute: .CenterX, relatedBy: .Equal, toItem: self.view, attribute: .CenterX, multiplier: 1, constant: 0))
    }
    
    /*
    func tagViewTapped(gesture : UITapGestureRecognizer) {
    
    }
    */
    
    func createTapPhotoLabel () {
        
        tapPhotoLabel.setTranslatesAutoresizingMaskIntoConstraints(false)
        tapPhotoLabel.backgroundColor = UIColor.clearColor()
        tapPhotoLabel.text = "Tap Photo To Tag Brands"
        tapPhotoLabel.textColor = UIColor.whiteColor()
        tapPhotoLabel.textAlignment = .Center
        tapPhotoLabel.font = UIFont(name: "Montserrat-Regular", size: 12)
        
        let views = ["pic": tagImageView, "tap": tapPhotoLabel]
        
        view.addSubview(tapPhotoLabel)
        view.addConstraints(NSLayoutConstraint.constraintsWithVisualFormat("V:[pic]-30-[tap(==40)]", options: NSLayoutFormatOptions(0), metrics: nil, views: views))
        view.addConstraints(NSLayoutConstraint.constraintsWithVisualFormat("H:|-40-[tap]-40-|", options: NSLayoutFormatOptions(0), metrics: nil, views: views))
    }
    
    func createTagIconImageView () {
        
        tagIconImageView.setTranslatesAutoresizingMaskIntoConstraints(false)
        tagIconImageView.image = UIImage(named: "tag_unselected@x2.png")
        tagIconImageView.contentMode = .ScaleAspectFit
        
        let views = ["tap": tapPhotoLabel, "icon": tagIconImageView]
        
        view.addSubview(tagIconImageView)
        view.addConstraints(NSLayoutConstraint.constraintsWithVisualFormat("V:[tap]-10-[icon(==30)]", options: NSLayoutFormatOptions(0), metrics: nil, views: views))
        view.addConstraints(NSLayoutConstraint.constraintsWithVisualFormat("H:[icon(==30)]", options: NSLayoutFormatOptions(0), metrics: nil, views: views))
        view.addConstraint(NSLayoutConstraint(item: tagIconImageView, attribute: .Trailing, relatedBy: .Equal, toItem: tapPhotoLabel, attribute: .CenterX, multiplier: 1, constant: -10))
        
        
        
        tagdeletebutton.setTranslatesAutoresizingMaskIntoConstraints(false)
        tagdeletebutton.setTitle("X", forState: UIControlState.Normal)
        tagdeletebutton.titleLabel?.font = UIFont(name: "Montserrat-Bold", size: 25)
        tagdeletebutton.addTarget(self, action: "changestate", forControlEvents: UIControlEvents.TouchUpInside)
        
        
        let vie = ["tap": tapPhotoLabel, "delete": tagdeletebutton]
        view.addSubview(tagdeletebutton)
        view.addConstraints(NSLayoutConstraint.constraintsWithVisualFormat("H:[delete(==30)]", options: NSLayoutFormatOptions(0), metrics: nil, views: vie))
        view.addConstraint(NSLayoutConstraint(item: tagdeletebutton, attribute: .Top, relatedBy: .Equal, toItem: tagIconImageView, attribute: .Top, multiplier: 1, constant: 0))
        view.addConstraint(NSLayoutConstraint(item: tagdeletebutton, attribute: .Bottom, relatedBy: .Equal, toItem: tagIconImageView, attribute: .Bottom, multiplier: 1, constant: 0))
        view.addConstraint(NSLayoutConstraint(item: tagdeletebutton, attribute: .Leading, relatedBy: .Equal, toItem: tapPhotoLabel, attribute: .CenterX, multiplier: 1, constant: 10))
    }
    
    
    func changestate()
    {
        self.deletestate = !deletestate
        if (deletestate)
        {
            tagdeletebutton.setTitleColor(UIColor.redColor(), forState: UIControlState.Normal)
        }
        else
        {
            tagdeletebutton.setTitleColor(UIColor.whiteColor(), forState: UIControlState.Normal)
        }
        stopedit(deletestate)
    }
    
    func stopedit(stop:Bool)
    {
        for text in tagImageView.subviews
        {
            var gesture: [UIGestureRecognizer] = text.gestureRecognizers as! [UIGestureRecognizer]
            gesture.append(gesture[0])
            gesture.removeAtIndex(0)
            gesture.append(gesture[0])
            gesture.removeAtIndex(0)
            if stop
            {
                (text as! UITextField).resignFirstResponder()
            }
            (text as! UITextField).gestureRecognizers = gesture
        }
    }
    
    func checkResponder () -> Bool {
        for text in tagImageView.subviews
        {
            if (text as! UITextField).isFirstResponder()
            {
                text.resignFirstResponder()
                return true
            }
        }
        return false
    }
    
    
    //MARK:  TextField delegate
    
    func textFieldShouldBeginEditing(textField: UITextField) -> Bool {
        return !deletestate
    }
    
    func textFieldDidEndEditing(textField: UITextField) {
        if textField.text == ""
        {
            textField.removeFromSuperview()
        }
    }
    
    func textFieldShouldReturn(textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
    
    
    func getTagPosition() -> [Tag]
    {
        var tmp: [Tag] = []
    
        println(self.tagImageView.image?.size)
        
        for text in tagImageView.subviews
        {
            let newX = ((text as! UITextField).frame.origin.x + CGFloat(tagwidth / 2)) - newFrame!.origin.x
            let transformX = newX * tagImageView.image!.size.width / (newFrame!.size.width + CGFloat(tagwidth))
            
            
            let newY = (text as! UITextField).frame.origin.y - newFrame!.origin.y
            let transformY = newY * tagImageView.image!.size.height / (newFrame!.size.height + CGFloat(tagheight))
            
            tmp.append(Tag(position: CGPoint(x: transformX, y: transformY), name: (text as! UITextField).text))
        }
        
        //println(tmp)
        return tmp
    }
    
    func getImageView() -> UIImage {
        UIGraphicsBeginImageContext(self.tagImageView.bounds.size);
        
        self.tagImageView.layer.renderInContext(UIGraphicsGetCurrentContext())
        
        var viewImage = UIGraphicsGetImageFromCurrentImageContext();
        UIGraphicsEndImageContext();
        
        return viewImage;
    }
}
















