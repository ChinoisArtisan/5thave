//
//  ProfileViewController.swift
//  5thAve
//
//  Created by Emagid Corp on 4/1/15.
//  Copyright (c) 2015 Beyond 2021. All rights reserved.
//

import Foundation
import UIKit

enum ProfileState {
    case Posts
    case Favorite
    case Closet
}


class ProfilViewController: UIViewController, UICollectionViewDataSource, UICollectionViewDelegate, UICollectionViewDelegateFlowLayout, UITextFieldDelegate, navaction, CenterVCProtocol{

    @IBOutlet weak var ProfilView: UIView!
    @IBOutlet weak var ProfileCenterConstraint: NSLayoutConstraint!

  
    @IBOutlet weak var userProfilePicImageView: PFImageView!
    
    @IBOutlet weak var Description: UITextView!
    @IBOutlet weak var nbOfPost: UILabel!
    @IBOutlet weak var nbOfFollowers: TimelineButton!
    @IBOutlet weak var nbOfFollowing: TimelineButton!
    @IBOutlet weak var Profilbutton: UIButton!
    
    
    @IBOutlet weak var postbutton: UIButton!
    @IBOutlet weak var closetbutton: UIButton!
    @IBOutlet weak var favoritebutton: UIButton!
    
    @IBOutlet weak var pageController: UIPageControl!
    @IBOutlet weak var imageCollectionView: UICollectionView!
    
    var popup: CreateCollectionController?
    
    let spacing: CGFloat = 8.0

    var user: PFUser?
    
    var myactionSheetSection: JGActionSheet?
    var pushed: Bool = false
    var state:ProfileState = .Posts
    var showDescription:Bool = false
    var isMyAccount: Bool = true
    
    var myPosts: [CurrentUserPost] = []
    var ContainerVC: ContainerProtocol?

    var ClosetData: Dictionary<String, [String]> = ["": ["PREVIOUS PURCHASES", "LIKED PHOTOS", "WISH LIST"], "COLLECTIONS": ["BAGS", "SHOES", "PANTS","NICE TOPS", "PRADA", "JACKET","FENDI", "SHOES", "ELSE","SUMMER", "SHOES", "PANTS"]]
    var PostsData: Dictionary<String, [String]> = ["": ["FendiImage.png", "profil_menu_icon.png", "EFM_Launch.jpg","FendiImage.png", "profil_menu_icon.png", "EFM_Launch.jpg"]]
    var FavoriteData: Dictionary<String, [String]> = ["": ["BAGS", "SHOES", "PANTS","NICE TOPS", "PRADA", "JACKET","FENDI", "SHOES", "ELSE","SUMMER", "SHOES", "PANTS"]]
    
    let sectionInsets = UIEdgeInsets(top: 10.0, left: 5.0, bottom: 10.0, right: 5.0)
    var data: Dictionary<String, [String]> = ["":[]]
    
    var myPostsImageArray: [UIImage] = []
    
    override func viewDidLoad() {
        
        super.viewDidLoad()
        getCurrentUserInfo()
        getUserProfilePic()
        Tools.sharedInstance.roundImageView(userProfilePicImageView, borderWitdh: 1.0)
        
        let firstgesture: UISwipeGestureRecognizer = UISwipeGestureRecognizer(target: self, action: "swipeaction:")
        firstgesture.direction = UISwipeGestureRecognizerDirection.Left
        self.ProfilView.userInteractionEnabled = true
        self.ProfilView.addGestureRecognizer(firstgesture)
        
        
        let secondgesture: UISwipeGestureRecognizer = UISwipeGestureRecognizer(target: self, action: "swipeaction:")
        secondgesture.direction = UISwipeGestureRecognizerDirection.Right
        self.Description.userInteractionEnabled = true
        self.Description.addGestureRecognizer(secondgesture)
        
        self.nbOfFollowers.hitframe = UIEdgeInsetsMake(-5, -5, -5, -5)
        self.nbOfFollowing.hitframe = UIEdgeInsetsMake(-5, -5, -5, -5)

        //Add notification when the image is loaded
        NSNotificationCenter.defaultCenter().addObserver(self, selector:"getUserProfilePic",  name:"ImageChangedNotification", object:nil);
    }

    
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
        self.loadAccountType()
        setLeftBarbutton()
        setNavBarTitle()
        self.changebuttoncolor()
        getCurrentUserInfo()
    }
    
    
    override func viewWillDisappear(animated: Bool) {
        super.viewWillDisappear(animated)

        if (myactionSheetSection?.superview != nil)
        {
            myactionSheetSection?.dismissAnimated(true)
        }
        
    }
    
    @IBAction func showFollowers(sender: AnyObject) {
        let vc = UserListViewController()
        vc.user = self.user
        vc.state = .Followers
        let nav = UINavigationController(rootViewController: vc)
        nav.navigationBar.translucent = false
        
        presentViewController(nav, animated: true, completion: nil)
    }
    
    @IBAction func showFollowing(sender: AnyObject) {
        
        let vc = UserListViewController()
        vc.user = self.user
        vc.state = .Following
        let nav = UINavigationController(rootViewController: vc)
        nav.navigationBar.translucent = false
        
        presentViewController(nav, animated: true, completion: nil)
    }
    
    
    func enableInteraction(enable:Bool)
    {
        self.view.userInteractionEnabled = enable
    }
    
    func loadAccountType ()
    {
        if (!isMyAccount)
        {
            self.Description.editable = false
            self.Profilbutton.setTitle("FOLLOW", forState: UIControlState.Normal)
            self.navigationItem.rightBarButtonItem = NavButtonGenerator.sharedInstance.createextra(self)
            //self.delegate?.navigationItem.rightBarButtonItems?.append(self.navigationItem.rightBarButtonItem!)
        }
        
    }
    
    func swipeaction(gestureRecognizer:UISwipeGestureRecognizer) {
        self.moveProfilView()
        self.pageController.currentPage = (self.showDescription ? 1:0)
    }
    
    @IBAction func switchProfileView(sender: AnyObject) {
       self.moveProfilView()
    }
    
    func moveProfilView()
    {
        UIView.animateWithDuration(0.5, animations: {
            var viewframe = self.ProfilView.frame
            if !self.showDescription
            {
                viewframe.origin.x -= viewframe.size.width
                self.showDescription = true
                self.Description.frame.origin.x = 0
            }
            else
            {
                viewframe.origin.x = 0
                self.showDescription = false
                self.Description.frame.origin.x = viewframe.size.width
            }
            self.ProfilView.frame = viewframe
            
            }, completion: { (finish: Bool) in
                
                var viewframe = self.ProfilView.frame
                if self.showDescription
                {
                    self.ProfileCenterConstraint.constant += viewframe.size.width
                }
                else
                {
                    self.ProfileCenterConstraint.constant = 0
                }
            })
    }
    
    @IBAction func switchView(sender: AnyObject) {
        if (sender as! NSObject == self.postbutton)
        {
            self.changestate(.Posts)
        }
        else if (sender as! NSObject == self.closetbutton)
        {
            self.changestate(.Closet)
        }
        else
        {
            self.changestate(.Favorite)
        }
    }
    
    @IBAction func clickOnEditProfil(sender: AnyObject) {
        
        if isMyAccount
        {
            let storyboard = UIStoryboard(name: "Main", bundle: nil)
            let vc: EditProfileViewController = storyboard.instantiateViewControllerWithIdentifier(EditProfileViewControllerID) as! EditProfileViewController
        
            self.navigationController?.pushViewController(vc, animated: true)
        }
    }
    
    func changestate(state:ProfileState)
    {
        if (self.state != state)
        {
            self.state = state
            self.changebuttoncolor()
        }
    }
    
    func changebuttoncolor()
    {
        switch self.state
        {
        case .Closet:
            changebuttonstate(self.closetbutton, clicked: true)
            changebuttonstate(self.postbutton, clicked: false)
            changebuttonstate(self.favoritebutton, clicked: false)
            self.data = ClosetData
            
        case .Favorite:
            changebuttonstate(self.closetbutton, clicked: false)
            changebuttonstate(self.postbutton, clicked: false)
            changebuttonstate(self.favoritebutton, clicked: true)
            self.data = FavoriteData
            
        default:
            changebuttonstate(self.closetbutton, clicked: false)
            changebuttonstate(self.postbutton, clicked: true)
            changebuttonstate(self.favoritebutton, clicked: false)
            getUserPostsImage()
            self.data = PostsData
        }
        
        self.imageCollectionView.reloadData()
    }
    
    
    func changebuttonstate(button:UIButton, clicked:Bool){
        button.backgroundColor = clicked ? AppColor.lightBlueColorApp() : UIColor.darkGrayColor()
    }
    
    

    
       
    //MARK: COLLECTION DELEGATE AND DATASOURCE
    
    func numberOfSectionsInCollectionView(collectionView: UICollectionView) -> Int {
        return data.count
    }
    
    
    
    func collectionView(collectionView: UICollectionView, cellForItemAtIndexPath indexPath: NSIndexPath) -> UICollectionViewCell {
        
        if (self.state == .Closet)
        {
            let cell: FavoriteCollectionCell = collectionView.dequeueReusableCellWithReuseIdentifier(FavoriteCollectionCellID, forIndexPath: indexPath) as! FavoriteCollectionCell
        
            //Complete the data in the cell
            let values = Array(data.values)
            if ((isMyAccount) && (indexPath.row == values[indexPath.section].count) && (indexPath.section == 1))
            {
                cell.label.text = "CREATE A NEW LIST"
                //cell.label.backgroundColor = AppColor.lightBlueColorApp()
                //cell.label.alpha = 1.0
                return cell
            }
            else
            {
                cell.label.text = values[indexPath.section][indexPath.row]
                //cell.label.backgroundColor = AppColor.lightBlueColorApp()
                //cell.label.alpha = 1.0
                
            }

            return cell
        }
        else if (self.state == .Posts)
        {
            let cell: PostsCollectionCell = collectionView.dequeueReusableCellWithReuseIdentifier(PostsCollectionCellID, forIndexPath: indexPath) as! PostsCollectionCell
            cell.myPostsImageView.image = nil
                if let imageFile = (myPosts[indexPath.row] as CurrentUserPost).postImageFile {
                    cell.myPostsImageView.file = (myPosts[indexPath.row] as CurrentUserPost).postImageFile
                    cell.myPostsImageView.loadInBackground({ (image: UIImage?, error: NSError?) -> Void in
                        if error == nil {
                            cell.myPostsImageView.image = image
                            }
                        else {
                            println(error?.description)
                        }
                    })
                }
           
    
            return cell
        }
        else
        {
            let cell: FavoriteCollectionCell = collectionView.dequeueReusableCellWithReuseIdentifier(FavoriteCollectionCellID, forIndexPath: indexPath) as! FavoriteCollectionCell
            
            //Complete the data in the cell
            let values = Array(data.values)
            cell.label.text = values[indexPath.section][indexPath.row]
            return cell
        }
        
    }
    
    func collectionView(collectionView: UICollectionView, didSelectItemAtIndexPath indexPath: NSIndexPath) {
        let values = Array(data.values)
        if (self.state == .Closet)
        {
            if indexPath.section == 0
            {
                var vc: ListViewController = (storyboard!.instantiateViewControllerWithIdentifier(ListViewControllerID) as! ListViewController)
                vc.isMyAccount = self.isMyAccount
                vc.isPrivate = false

                switch indexPath.row
                {
                case 0:
                    //self.delegate?.clickOnCollection(.texte, collectionname: "PREVIOUS PURCHASES")
                    (vc as ListViewController).celltype = .texte
                    (vc as ListViewController).setNavBarTitle("PREVIOUS PURChASES")
                    self.navigationController?.pushViewController(vc, animated: true)
                    
                    println("PREVIOUS PURChASES")
                case 1:
                    (vc as ListViewController).celltype = .image
                    (vc as ListViewController).setNavBarTitle("LIKED PHOTOS")
                    self.navigationController?.pushViewController(vc, animated: true)
                    
                    println("LIKED PHOTOS")
                    
                default:
                    (vc as ListViewController).celltype = .delete
                    (vc as ListViewController).setNavBarTitle("WISHLIST")
                    self.navigationController?.pushViewController(vc, animated: true)
                    
                    println("WISHLIST")
                    
                }
                
            }
            else
            {
                if ((isMyAccount) && (indexPath.row == values[indexPath.section].count))
                {
                    popup = CreateCollectionController()
                    popup!.view.frame = self.view.bounds
                    
                    addChildViewController(popup!)
                    self.view.addSubview(popup!.view)
                    
                    popup!.popupsave.addTarget(self, action: "save", forControlEvents: UIControlEvents.TouchUpInside)
                    popup!.didMoveToParentViewController(self)
                    
                }
                else
                {
                    let values = Array(data.values)
                    var vc: ListViewController = (storyboard!.instantiateViewControllerWithIdentifier(ListViewControllerID) as! ListViewController)
                    (vc as ListViewController).celltype = .delete
                    (vc as ListViewController).setNavBarTitle(values[indexPath.section][indexPath.row])
                    self.navigationController?.pushViewController(vc, animated: true)
                }
            }
        }
        else if (self.state == .Posts)
        {
            let vc = ZoomImageViewController()
            vc.zoomImage.image = nil
            vc.zoomImage.file = self.myPosts[indexPath.row].postImageFile
            let nav = UINavigationController(rootViewController: vc)
            nav.navigationBar.translucent = false
            
            presentViewController(nav, animated: true, completion: nil)
        }
    }
    
    func save()
    {
        //Add to data the new name collection
        if (popup!.popuptextfield.text != "NAME")
        {
            data["COLLECTIONS"]?.append(popup!.popuptextfield.text)
            imageCollectionView.reloadData()
            //Remove the popup
            popup!.removeFromParentViewController()
            popup!.view.removeFromSuperview()
        }
        else
        {
            var alert = UIAlertController(title: "Missing", message: "You forgot to put the name of your collection", preferredStyle: UIAlertControllerStyle.Alert)
            alert.addAction(UIAlertAction(title: "OK", style: UIAlertActionStyle.Default, handler: nil))
            self.presentViewController(alert, animated: true, completion: nil)
        }
        
       
    }
    
    func collectionView(collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        let values = Array(data.values)
        
        if ((self.state == .Closet) && isMyAccount && (section == 1))
        {
            return values[section].count + 1
        }
        else if (self.state == .Posts) {
            return myPosts.count
        }
        
        return values[section].count
    }
    
    
    func collectionView(collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, atIndexPath indexPath: NSIndexPath) -> UICollectionReusableView {
        
        //Make a default cell
        
        let headerView = collectionView.dequeueReusableSupplementaryViewOfKind(kind, withReuseIdentifier: ClosetHeaderCellID, forIndexPath: indexPath) as! ClosetCollectionHeaderCell
        headerView.title.text = "COLLECTIONS"
        return headerView
            
    }
    
    func collectionView(collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, referenceSizeForHeaderInSection section: Int) -> CGSize {
        if ((section == 1) && (self.state == .Closet))
        {
            return CGSizeMake(self.view.bounds.size.width, 40)
        }
        
        return CGSizeMake(0, 0)
    }
    
    
    //MARK:  COLLECTION VIEW  -  Flow Collection
    func collectionView(collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAtIndexPath indexPath: NSIndexPath) -> CGSize {
        var cellwidth = (self.view.bounds.size.width - 6 * 10) / 3
        
        return CGSize(width:cellwidth , height: cellwidth)
    }
    
    func collectionView(collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAtIndex section: Int) -> UIEdgeInsets {
        return sectionInsets
    }
    
    func collectionView(collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAtIndex section: Int) -> CGFloat {
        return spacing
    }
    
    func collectionView(collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAtIndex section: Int) -> CGFloat {
        return spacing
    }
    
    
    //MARK:
    
    @IBAction func showActionSheet(sender: AnyObject) {
        //Show the actionsheet
        println("Show the action sheet")
        
        
        var actionSheetSection: JGActionSheetSection = JGActionSheetSection(title: nil, message: nil, buttonTitles: ["BLOCK USER", "REPORT SPAM"], buttonStyle: JGActionSheetButtonStyle.Red)
        actionSheetSection.settimelineno()
        
        
        var cancelActionSheetSection: JGActionSheetSection = JGActionSheetSection(title: nil, message: nil, buttonTitles: ["CANCEL"], buttonStyle: JGActionSheetButtonStyle.Cancel)
        cancelActionSheetSection.settimelineno()
        
        let sections = [actionSheetSection, cancelActionSheetSection]
        
        var actionSheet: JGActionSheet = JGActionSheet(sections: sections)
        
        actionSheet.buttonPressedBlock = {(actionSheet: JGActionSheet!, indexPath: NSIndexPath!) in
            
            if indexPath.section == 0 {
                switch(indexPath.row) {
                case 0:
                    actionSheet.dismissAnimated(true)
                    
                default:
                    actionSheet.dismissAnimated(true)
                }
                
            }
            else if indexPath.section == 1 {
                switch(indexPath.row) {
                default:
                    actionSheet.dismissAnimated(true)
                }
            }
        }
        
        actionSheet.outsidePressBlock = {(actionSheet: JGActionSheet!) in
            
            actionSheet.dismissAnimated(true)
        }
        
        myactionSheetSection = actionSheet
        actionSheet.showInView(self.view, animated: true)
        
    }
    
    //MARK Navigation Item Setup
    func setNavBarTitle()
    {
        var currentUser = user
        
        let tmplabel = UILabel()
        
    
        if currentUser != nil {
            self.navigationItem.titleView = NavButtonGenerator.sharedInstance.createnavtitle(ParseQuery.sharedInstance.getName(currentUser!))
        }
        else {
            self.navigationItem.titleView = NavButtonGenerator.sharedInstance.createnavtitle("Hello Stranger")
        }
        
        self.navigationItem.titleView?.sizeToFit()
    }
    
    func setLeftBarbutton()
    {
        if pushed{
            self.navigationItem.leftBarButtonItem = NavButtonGenerator.sharedInstance.createbackbutton(self)
        }
        else
        {
            self.navigationItem.leftBarButtonItem = NavButtonGenerator.sharedInstance.createmenubutton(self)
        }
    }
    
    
    //MARK:     navaction protocol
    func backaction()
    {
        self.navigationController?.popViewControllerAnimated(true)
    }
    
    func menuaction()
    {
        self.ContainerVC?.menuAction()
    }
    
    
    
    //MARK:  Parse My Posts Fetch
    
    func getUserPostsImage () {
        
        var query = PFQuery(className: "Post")
        query.orderByAscending("createdAt")
        query.fromPinWithName("CurrentUserPost")
        query.whereKey("user", equalTo: user!)
        query.findObjectsInBackgroundWithBlock { (objects: [AnyObject]?, error: NSError?) -> Void in
            if error == nil {
                if let objects = objects as? [PFObject] {
                    self.myPosts = []
                    for object in objects {
                        let userPosts = CurrentUserPost()
                        if let userImageFile = object["postImage"] as? PFFile {
                            userPosts.postImageFile = userImageFile
                        }
                        if let postComment = object["comment"] as? String {
                            userPosts.postComment = postComment
                        }
                        self.myPosts.append(userPosts)
                    }
                    self.imageCollectionView.reloadData()
                }
            }
            
            var query = PFQuery(className: "Post")
            query.orderByAscending("createdAt")
            query.whereKey("user", equalTo: self.user!)
            query.findObjectsInBackgroundWithBlock { (objects: [AnyObject]?, error: NSError?) -> Void in
                if error == nil {
                    if let objects = objects as? [PFObject] {
                        self.myPosts = []
                        for object in objects {
                            let userPosts = CurrentUserPost()
                            if let userImageFile = object["postImage"] as? PFFile {
                                userPosts.postImageFile = userImageFile
                            }
                            if let postComment = object["comment"] as? String {
                                userPosts.postComment = postComment
                            }
                            
                            self.myPosts.append(userPosts)
                        }
                        self.imageCollectionView.reloadData()
                        
                        PFObject.pinAllInBackground(objects, withName: "CurrentUserPost", block: { (done: Bool, error:NSError?) -> Void in
                            if (error != nil) {
                                println(error)
                            }
                        })
                    }
                }
                
            }
        }
    }
    
    func getCurrentUserInfo () {
        
        if let numberOfPost: AnyObject = user?["numberOfPosts"] {
            nbOfPost.text = numberOfPost.description
        }
        
        if let numberOfFollowers: AnyObject = user?["numberOfFollowers"] {
            nbOfFollowers.setTitle("0", forState: UIControlState.Normal)
        }
        getNumberOfFollower()
        
        
        if let numberFollowing: AnyObject = user?["numberFollowing"] {
            nbOfFollowing.setTitle("0", forState: UIControlState.Normal)
        }
        getNumberOfFollowing()
    }
    
    func getUserProfilePic () {
        self.userProfilePicImageView.image = nil
        
        if let userImageFile = user?["profileImage"] as? PFFile {
            self.userProfilePicImageView.file = userImageFile
            self.userProfilePicImageView.loadInBackground({ (image: UIImage?, error: NSError?) -> Void in
                if error == nil {
                    self.userProfilePicImageView.image = image
                }
                else {
                    println(error?.description)
                }
            })
        }
    }
    

    func getNumberOfFollowing() {
        
        var query = PFQuery(className: "FollowUser")
        query.whereKey("from", equalTo: self.user!)
        query.countObjectsInBackgroundWithBlock { (number: Int32, error: NSError?) -> Void in
            if error == nil {
                self.nbOfFollowing.setTitle(number.description, forState: UIControlState.Normal)
//                self.user!["numberFollowing"] = Int(number)
//                if self.isMyAccount {
//                    self.user!.saveEventually({ (done: Bool, error: NSError?) -> Void in
//                        if error != nil {
//                            println(error)
//                        }
//                    })
//                }
//                else {
//                    PFObject.pinAllInBackground([self.user!], withName: "FollowUser", block: nil)
//                }
            }
        }
    }
    
    
    func getNumberOfFollower() {
        
        var query = PFQuery(className: "FollowUser")
        query.whereKey("to", equalTo: self.user!)
        query.countObjectsInBackgroundWithBlock { (number: Int32, error: NSError?) -> Void in
            if error == nil {
                self.nbOfFollowers.setTitle(number.description, forState: UIControlState.Normal)
//                self.user!["numberOfFollowers"] = Int(number)
//
//                if self.isMyAccount {
//                    self.user!.saveEventually({ (done: Bool, error: NSError?) -> Void in
//                        if error != nil {
//                            println(error)
//                        }
//                    })
//                }
//                else {
//                    PFObject.pinAllInBackground([self.user!], withName: "FollowUser", block: nil)
//                }
            }
        }
    }
}







