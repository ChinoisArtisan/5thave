//
//  CommentsTableViewController.swift
//  5thAve
//
//  Created by KEEVIN MITCHELL on 3/25/15.
//  Copyright (c) 2015 Beyond 2021. All rights reserved.
//

import UIKit

class CommentsTableViewController: UIViewController, UITableViewDelegate, UITableViewDataSource, UITextViewDelegate, navaction {
    
    @IBOutlet weak var commentlist: UITableView!
    @IBOutlet weak var fieldContraint: NSLayoutConstraint!
    
    @IBOutlet weak var fieldView: UIView!
    @IBOutlet weak var commentfield: UITextView!
    @IBOutlet weak var commentfieldheigth: NSLayoutConstraint!
    @IBOutlet weak var fieldViewheigth: NSLayoutConstraint!
    
    @IBOutlet weak var sendbutton: UIButton!
    
    
    //Some data to complete the field
    //var data: [User] = [User(name: "toto", profilpicture: "EFM_Launch.jpg"), User(name: "mika", profilpicture: "EFM_Launch.jpg"), User(name: "Test", profilpicture: "EFM_Launch.jpg")]
    //var comments: [String] = ["Hello", "Hello World", "Newbie!!"]
    
    //Data is an array of Comments
    
    var data: [PFObject] = []
    var Post: PFObject?
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //Set up the navigation bar title and background color
        self.navigationItem.leftBarButtonItem = NavButtonGenerator.sharedInstance.createbackbutton(self)
        self.navigationItem.titleView = NavButtonGenerator.sharedInstance.createnavtitle("COMMENTS")
        self.navigationItem.titleView?.sizeToFit()
        
        //Put the field view in front
        self.fieldView.layer.zPosition = 1
        self.commentfield.delegate = self
        //commentfield.textContainerInset = UIEdgeInsetsZero
        commentfield.textContainer.lineFragmentPadding = 8
        
        var tap: UITapGestureRecognizer = UITapGestureRecognizer(target: self, action: "DismissKeyboard")
        commentlist.addGestureRecognizer(tap)
        
        sendbutton.addTarget(self, action: "Sendaction", forControlEvents: UIControlEvents.TouchUpInside)
        
        
        //When keyboard show and hide launch the function
        NSNotificationCenter.defaultCenter().addObserver(self, selector:"keyboardWasShown:",  name:UIKeyboardDidShowNotification, object:nil)
        NSNotificationCenter.defaultCenter().addObserver(self, selector:"keyboardWillBeHidden:",  name:UIKeyboardWillHideNotification, object:nil)
        
        parseRequest()
    }
    
    func backaction() {
        self.navigationController?.popViewControllerAnimated(true)
    }
    
    func DismissKeyboard(){
        //Causes the view (or one of its embedded text fields) to resign the first responder status.
        self.view.endEditing(true)
        if (commentfield.text == "")
        {
            commentfield.text = "Add a comment ..."
        }
    }
    
    func Sendaction()
    {
        self.view.endEditing(true)
        
        if commentfield.text != "Add a comment ..." {
            println("Send")
            //Send the message
            var comment = PFObject(className: "Comment")
            comment["userPost"] = self.Post!
            comment["user"] = PFUser.currentUser()
            comment["content"] = self.commentfield.text
            
            self.commentlist.reloadData()
            self.commentfield.text = "Add a comment ..."
            let sizeFit = commentfield.sizeThatFits(commentfield.frame.size)
            commentfieldheigth.constant = (sizeFit.height < 50) ? 50 : sizeFit.height
            fieldViewheigth.constant = commentfieldheigth.constant + 10
            
            comment.saveEventually {  (sucess: Bool, error: NSError?) -> Void in
                if error == nil {
                    println("Send comment")
                    PFObject.pinAllInBackground([comment], withName: "Comment", block: { (done: Bool, error: NSError?) -> Void in
                        if error == nil {
                            self.data.append(comment)
                            self.commentlist.reloadData()
                            self.commentlist.scrollToRowAtIndexPath(NSIndexPath(forRow: self.data.count - 1, inSection: 0), atScrollPosition: UITableViewScrollPosition.Top, animated: true)
                        }
                    })
                }
                else {
                    println(error)
                }
            }
        }
    }
    
    
    //MARK:  Tableview delegate and Datasource function
    
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return data.count
    }
    
    
    func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
        return 114.0
    }
    
    
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell
    {
        let cell: CommentCell = tableView.dequeueReusableCellWithIdentifier(CommentCellID, forIndexPath: indexPath) as! CommentCell
        
        
        if var user = data[indexPath.row]["user"] as? PFUser {
            cell.Username.text = ParseQuery.sharedInstance.getName(user)
        
            cell.ProfilPicture.image = nil
            cell.ProfilPicture.file = data[indexPath.row]["user"]!["profileImage"] as? PFFile
            cell.ProfilPicture.loadInBackground { (image: UIImage?, error: NSError?) -> Void in
                if error != nil {
                    cell.ProfilPicture.image = image
                }
            }
        }
        Tools.sharedInstance.roundImageView(cell.ProfilPicture, borderWitdh: 0.5)
        
        //Must come from data
        cell.PostTime.text = Tools.sharedInstance.diff(data[indexPath.row].createdAt!)
        if let content = data[indexPath.row]["content"] as? String {
            cell.CommentText.text = content
        }
        cell.CommentText.textContainerInset = UIEdgeInsetsZero
        cell.CommentText.textContainer.lineFragmentPadding = 0
        cell.CommentText.font = UIFont(name: "Montserrat-Regular", size: 12)
        cell.CommentText.textColor = UIColor.whiteColor()
        
        return cell
    }
    
    
    //MARK: Keyboard Notification action
    
    //Keyboard show and hide notification. Move the field
    func keyboardWasShown(Notification: NSNotification)
    {
        if let userInfo = Notification.userInfo
        {
            let endFrame = (userInfo[UIKeyboardFrameEndUserInfoKey] as? NSValue)?.CGRectValue().size
            let duration:NSTimeInterval = (userInfo[UIKeyboardAnimationDurationUserInfoKey] as? NSNumber)?.doubleValue ?? 0
            let animationCurveRawNSN = userInfo[UIKeyboardAnimationCurveUserInfoKey] as? NSNumber
            let animationCurveRaw = animationCurveRawNSN?.unsignedLongValue ?? UIViewAnimationOptions.CurveEaseInOut.rawValue
            let animationCurve:UIViewAnimationOptions = UIViewAnimationOptions(rawValue: animationCurveRaw)
            
            
            UIView.animateWithDuration(duration,
                delay: NSTimeInterval(0),
                options: animationCurve,
                animations: {self.fieldContraint.constant = endFrame!.height},
                completion: nil)
        }
    }
    
    func keyboardWillBeHidden(Notification: NSNotification)
    {
        self.fieldContraint.constant = 0
    }
    
    //MARK:  textview delegate
    
    func textViewDidChange(textView: UITextView) {
        let sizeFit = commentfield.sizeThatFits(commentfield.frame.size)
        commentfieldheigth.constant = (sizeFit.height < 50) ? 50 : sizeFit.height
        fieldViewheigth.constant = commentfieldheigth.constant + 10
    }
    
    func textView(textView: UITextView, shouldChangeTextInRange range: NSRange, replacementText text: String) -> Bool {
        if (text == "\n")
        {
            commentfield.resignFirstResponder()
            return false
        }
        if text == "\u{8}" {
            return true
        }
        return ((count(textView.text) - range.length + count(text)) <= 200)
    }
    
    func textViewShouldBeginEditing(textView: UITextView) -> Bool {
        if (textView.text == "Add a comment ...")
        {
            textView.text = ""
        }
        
        return true
    }
    
    func textViewDidBeginEditing(textView: UITextView) {
        commentfield.becomeFirstResponder()
    }
    
    func textViewDidEndEditing(textView: UITextView) {
        if (textView.text == "")
        {
            textView.text = "Add a comment ..."
        }
    }
    
    //MARK: Parse Query
    
    func parseRequest() {
        
        var query = PFQuery(className: "Comment")
        query.includeKey("user")
        query.fromPinWithName("Comment")
        query.orderByAscending("createdAt")
        query.whereKey("userPost", equalTo: self.Post!)
        query.findObjectsInBackgroundWithBlock { (objects: [AnyObject]?, error: NSError?) -> Void in
            if error == nil {
                if let array = objects as? [PFObject] {
                    self.data = array
                    self.commentlist.reloadData()
                }
                
                var query = PFQuery(className: "Comment")
                query.includeKey("user")
                query.orderByAscending("createdAt")
                query.whereKey("userPost", equalTo: self.Post!)
                query.findObjectsInBackgroundWithBlock { (objects: [AnyObject]?, error: NSError?) -> Void in
                    if error == nil {
                        if let array = objects as? [PFObject] {
                            self.data = array
                            self.commentlist.reloadData()
                            
                            PFObject.pinAllInBackground(array, withName: "Comment", block: nil)
                        }
                    }
                    else {
                        println(error)
                    }
                }
                
            }
            else {
                println(error)
            }
        }
    }
    
}
