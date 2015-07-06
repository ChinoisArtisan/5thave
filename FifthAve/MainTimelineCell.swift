//
//  MainTimelineCell.swift
//  5thAve
//
//  Created by WANG Michael on 24/04/2015.
//  Copyright (c) 2015 Beyond 2021. All rights reserved.
//

import Foundation
import UIKit


protocol PopoverTagProtocol{
    func TagClicked()
}




class MainTimelineCell: PFTableViewCell, UITableViewDelegate, UITableViewDataSource, PopoverTagProtocol{
    
    @IBOutlet weak var PostImage: PFImageView!
    @IBOutlet weak var NumberOfLike: UILabel!
    @IBOutlet weak var commentTableView: UITableView!
    @IBOutlet weak var moreButton: UIButton!
    @IBOutlet weak var comlabel: UILabel!
    @IBOutlet weak var cartlabel: UILabel!
    
    @IBOutlet weak var likeButton: TimelineButton!
    @IBOutlet weak var commentButton: TimelineButton!
    @IBOutlet weak var cartButton: TimelineButton!
    
    
    var table: TimelineTableViewController?
    var index: Int?
    var post: PFObject?
    
    var comments: [PFObject] = []
    var listoftag: [PFObject] = []
    
    var listOfButton: [UIButton] = []
    var imagesize: CGSize?
    
    var tappostimage: UITapGestureRecognizer?
    var tappostlike: UITapGestureRecognizer?
    
    var liked: Bool = false
    
    override func awakeFromNib() {
        super.awakeFromNib()
        self.commentTableView.dataSource = self
        self.commentTableView.delegate = self
        
        
        
        tappostimage = UITapGestureRecognizer(target: self, action: "tapAction:")
        tappostimage!.numberOfTapsRequired = 1
        tappostlike = UITapGestureRecognizer(target: self, action: "tapLike:")
        tappostlike!.numberOfTapsRequired = 2
        self.PostImage.userInteractionEnabled = true
        
        
        self.PostImage.gestureRecognizers?.removeAll(keepCapacity: false)
        self.PostImage.addGestureRecognizer(tappostimage!)
        self.PostImage.addGestureRecognizer(tappostlike!)
        tappostimage?.requireGestureRecognizerToFail(tappostlike!)
        
        
        //self.likeButton.hitframe = UIEdgeInsetsMake(-5, -5, -5, 0 - self.NumberOfLike.frame.size.width - 5)
        //self.commentButton.hitframe = UIEdgeInsetsMake(-5, -5, -5, 0 - self.comlabel.frame.size.width - 5)
        //self.cartButton.hitframe = UIEdgeInsetsMake(-5, -5, -5, 0 - self.cartlabel.frame.size.width - 5)
        
    }
    
    func setUpMoreButton () {
        self.table!.delegate?.showActionSheet(self.PostImage.image!, caption: self.table!.objects![self.index!]["comment"] as! String)
    }
    
    // UIGEsture Control
    func tapAction(sender:UITapGestureRecognizer)
    {
        sender
        if (self.listoftag.count > 0)
        {
            // Show the tag
            if (table?.data[index!] != false)
            {
                self.showPopover(false)
                table?.data[index!] = false
            }
            else
            {
                self.showPopover(true)
                table?.data[index!] = true
            }
        }
    }
    
    func tapLike(sender:UITapGestureRecognizer)
    {
        table?.likePost(post!)
    }
    
    func TagClicked()
    {
        //Remove all the popover and push on the profil
        self.showPopover(false)
        table?.data[index!] = false
    }
    
    
    
    
    func showPopover(show:Bool)
    {
        //Clean all the tag on the image
        for vc in listOfButton
        {
            vc.removeFromSuperview()
        }
        listOfButton.removeAll(keepCapacity: false)
        
        
        if show
        {
            for tmp in listoftag
            {
                let tag = UIButton()
                tag.setTitle(tmp["tagName"] as? String, forState: UIControlState.Normal)
                tag.setTitleColor(UIColor.whiteColor(), forState: UIControlState.Normal)
                tag.setTitleColor(UIColor.darkGrayColor(), forState: UIControlState.Highlighted)
                tag.setBackgroundImage(UIImage(named: "tag.png"), forState: UIControlState.Normal)
                
                tag.titleLabel?.font = UIFont(name: "Montserrat-Bold", size: 11)
                tag.titleLabel?.adjustsFontSizeToFitWidth = true
                
                //tag.frame = CGRectMake(CGFloat(tmp["xCoordinate"] as! Int), CGFloat(tmp["yCoordinate"] as! Int), 50, 20)
                tag.frame = CGRect(origin: newPosition(self.imagesize!, destinationSize: self.PostImage.frame.size, position: CGPoint(x: CGFloat(tmp["xCoordinate"] as! Int), y: CGFloat(tmp["yCoordinate"] as! Int))), size: CGSize(width: 55, height: 20))
                tag.addTarget(self, action: "TagClicked", forControlEvents: UIControlEvents.TouchUpInside)
                
                
                self.addSubview(tag)
                
                
                listOfButton.append(tag)
            }
        }
        else
        {
            for vc in listOfButton
            {
                vc.removeFromSuperview()
            }
            listOfButton.removeAll(keepCapacity: false)
        }
    }
    
    
    func newPosition (image: CGSize, destinationSize:CGSize, position: CGPoint) -> CGPoint
    {
        var imagewidth = image.width
        var imageheight = image.height
        var ratio: CGFloat
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
        var newPosition: CGPoint = CGPointMake(self.PostImage.frame.origin.x + newPoint.x + ratio * position.x - (55.0 / 2.0), self.PostImage.frame.origin.y + newPoint.y + ratio * position.y)
        
        return newPosition
    }
    
    
    
    //MARK:   TableView Delegate and Datasource
    
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        // SHOULD DO NOTHING
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("CommentCell", forIndexPath: indexPath) as! UITableViewCell
        
        var text = ""
        text += ParseQuery.sharedInstance.getName(comments[indexPath.row]["user"] as! PFUser)
        text += "  "
        text += (comments[indexPath.row]["content"] as? String)!
        
        var attributedString = NSMutableAttributedString(string: text)
        var attributes: [NSObject: AnyObject] = [
            NSFontAttributeName : cell.textLabel?.font as! AnyObject,
            NSForegroundColorAttributeName : AppColor.lightBlueColorApp() as AnyObject]
        attributedString.addAttributes(attributes, range: (NSString(string: text)).rangeOfString(ParseQuery.sharedInstance.getName(comments[indexPath.row]["user"] as! PFUser)))
        cell.textLabel?.attributedText = attributedString
        
        return cell
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return comments.count
    }
    
    
    func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
        return 15
    }
    
    
    
    
    //Button action
    @IBAction func clickLike(sender: AnyObject) {
        if !liked {
            liked = true
            self.table?.likePost(post!)
        }
    }
    
    @IBAction func clickComment(sender: AnyObject) {
        self.table?.showComment(post!)
    }
    
    @IBAction func clickCart(sender: AnyObject) {
        
    }
    
    @IBAction func clickOther(sender: AnyObject) {
        
    }
    
    
}