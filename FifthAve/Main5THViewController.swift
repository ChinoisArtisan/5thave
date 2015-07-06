//
//  Main5THViewController.swift
//  5thAve
//
//  Created by KEEVIN MITCHELL on 3/22/15.
//  Copyright (c) 2015 Beyond 2021. All rights reserved.
//

import UIKit
import MobileCoreServices
import CoreData
import Social

//Different state of the main screen
// Shop mode or Look mode


enum MainScreenState {
    
    case Shops
    case Looks
    case Search
    case Profile
    case Cart
    case Notification
    case Closet
    case Settings
    case BrandStores
    case Favorites
    case MyBrandStores
    case CollectionCloset
    case CollectionLiked
    case CollectionPurchases
    case CollectionWishlist
    case ProfilCollection
    
    case Discover
    case DiscoverUsers
    case DiscoverBrands
    
    case BrandPosts
    case BrandShopTable
    case BrandShopCollection
    case BrandCollectionList
    case BrandListCategorie
    
    case Addtocart
    case OldProfile
    
    case Unknown
}

protocol ShopDashProtocol {
    
    func clickOnShopDash(button:MainScreenState)
}

protocol ProfilCollectionProtocol {
    
    func clickOnCollection(state: typeOfCell, collectionname: String)
}



protocol TimelineProtocol {
    
    func showComment(index: Int)
    func showProfile()
    func showActionSheet(image: UIImage, caption: String)
    func showCart()
}

class Main5THViewController: UIViewController, TimelineProtocol, ShopDashProtocol, CenterVCProtocol, UIImagePickerControllerDelegate, UINavigationControllerDelegate, ProfilCollectionProtocol, UIDocumentInteractionControllerDelegate{
    
    let user = PFUser.currentUser()
    var userNameNavTitle = String()

    var picker = UIImagePickerController()
    var uploadVC: UploadPictureViewController?
    var cameraContainerView = UIView()
    var cameraImageView = UIImageView()
    var previousProfil: ProfilViewController?
    var docu: UIDocumentInteractionController?
    
    
    @IBOutlet weak var shopsButton: UIButton!
    @IBOutlet weak var lookButton: UIButton!
    @IBOutlet weak var buttonView: UIView!
    
    @IBOutlet weak var MainContainer: UIView!
    
    
    @IBAction func cameraTapped(sender: AnyObject) {
        
        createAlertViewController()
    }
    
    @IBOutlet weak var leftMenuButton: UIButton!
    
    var wishcontainerVC: WishListContainerView?
    var myactionSheetSection: JGActionSheet?
    var postFBVC: PostFBContainerViewController?
    var ContainerVC: ContainerProtocol?
    var state: MainScreenState = .Looks
    var currentvc: UIViewController?
    var isButtonHidden: Bool = false
    
    override func viewDidLoad() {
        
        super.viewDidLoad()
        
        //setUserNameNavTitle()
        buttonClicked()
        self.Changeviewcontroller()
        
        picker.delegate = self
    }
    
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
    }
    
    override func viewDidAppear(animated: Bool) {
        super.viewDidAppear(animated)
        
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func setUserNameNavTitle () {
        
        if PFFacebookUtils.isLinkedWithUser(user!) {
            userNameNavTitle = user?["facebookName"] as! String
        }
        else if user != nil {
            userNameNavTitle = user!.username!
        }
        else {
            userNameNavTitle = "Hello Stranger"
        }
        
    }
    
    func coreDataFetch () {
        
        let managedContext = (UIApplication.sharedApplication().delegate as! AppDelegate).managedObjectContext
        let fetchRequest = NSFetchRequest(entityName: "CurrentUser")
        
        if let fetchResults = managedContext!.executeFetchRequest(fetchRequest, error: nil) as? [CurrentUser] {
            
            if fetchResults.count > 0 {
                if let name = fetchResults[0].userName as String? {
                    self.userNameNavTitle = fetchResults[0].userName
                }
            }
            else {
                self.userNameNavTitle = "Hello"
            }
        }
    }
    
    @IBAction func ShopsPressed(sender: UIButton) {
        //NSNotificationCenter.defaultCenter().postNotificationName("shopsClicked", object: nil)
        if (state == .DiscoverUsers) || (state == .DiscoverBrands)
        {
            if (state == .DiscoverBrands)
            {
                self.state = .DiscoverUsers
                buttonClicked()
                self.Changeviewcontroller()
            }
        }
        else
        {
            if self.state != .Shops
            {
                self.state = .Shops
                buttonClicked()
                
                self.Changeviewcontroller()
            }
        }
    }
    
    @IBAction func looksPressed(sender: UIButton) {
        //NSNotificationCenter.defaultCenter().postNotificationName("LooksClicked", object: nil)
        if (state == .DiscoverUsers) || (state == .DiscoverBrands)
        {
            if (state == .DiscoverUsers)
            {
                self.state = .DiscoverBrands
                buttonClicked()
                self.Changeviewcontroller()
            }
        }
        else
        {
            if self.state != .Looks
            {
                self.state = .Looks
                buttonClicked()
                
                self.Changeviewcontroller()
            }
        }
    }
    
    func buttonClicked(){
        
        if (state == .Looks)
        {
            shopsButton.backgroundColor = UIColor.blackColor()
            lookButton.backgroundColor = AppColor.lightBlueColorApp()
        }
        else
        {
            lookButton.backgroundColor = UIColor.blackColor()
            shopsButton.backgroundColor = AppColor.lightBlueColorApp()
        }
    }

    
    func ChangeState(state: MainScreenState)
    {
        if ((self.state != state) || (state == .Profile))
        {
            self.state = state
            self.Changeviewcontroller()
        }
    }
    
    func Changeviewcontroller()
    {
        var vc: UIViewController
        
        if (state == .Looks)
        {
            vc = storyboard!.instantiateViewControllerWithIdentifier(TimelineViewControllerID) as! TimelineTableViewController
            (vc as! TimelineTableViewController).delegate = self
            self.navigationItem.titleView = NavButtonGenerator.sharedInstance.createnavtitle("LOOKS")
            self.navigationItem.titleView?.sizeToFit()
        }
        else
        {
            vc = storyboard!.instantiateViewControllerWithIdentifier(ShopDashboardID) as! ShopDashboardViewController
            (vc as! ShopDashboardViewController).delegate = self
            self.navigationItem.titleView = NavButtonGenerator.sharedInstance.createnavtitle("SHOP")
            self.navigationItem.titleView?.sizeToFit()
        }
        
        //Remove the old vc
        if (currentvc != nil)
        {
            self.currentvc!.willMoveToParentViewController(self)
            self.currentvc!.removeFromParentViewController()
            self.currentvc!.didMoveToParentViewController(nil)
            
            self.currentvc!.view.removeFromSuperview()
        }
        
        //Add the new one
        vc.willMoveToParentViewController(self)
        self.addChildViewController(vc)
        vc.didMoveToParentViewController(self)
        
        vc.view.frame = self.MainContainer.bounds
        self.MainContainer.addSubview(vc.view)
        
        
        //Change the currentvc variable
        self.currentvc = vc
    }

    
    //Move the navbar and the main view for the flyout menu
    
    @IBAction func leftButtonClicked(sender: AnyObject) {
        self.ContainerVC?.menuAction()
        removePopup()
    }
    
    func removePopup()
    {
        if (myactionSheetSection?.superview != nil)
        {
            myactionSheetSection?.dismissAnimated(true)
        }
        if wishcontainerVC != nil
        {
            if wishcontainerVC!.view.superview != nil
            {
                wishcontainerVC!.view.removeFromSuperview()
            }
        }
        if postFBVC != nil
        {
            if postFBVC!.view.superview != nil
            {
                postFBVC!.view.removeFromSuperview()
            }
        }
        
    }
    
    func enableInteraction(enable:Bool)
    {
        self.MainContainer.userInteractionEnabled = enable
        self.shopsButton.userInteractionEnabled = enable
        self.lookButton.userInteractionEnabled = enable
    }
    
    
    
    // MARK ShopDashProtocol
    func clickOnShopDash(button:MainScreenState)
    {
        self.ChangeState(button)
    }
    
    func clickOnCollection(state: typeOfCell, collectionname: String)
    {
        self.ChangeState(.ProfilCollection)
        (self.currentvc as! ListViewController).celltype = state
        (self.currentvc as! ListViewController).setNavBarTitle(collectionname)
    }
    
    // MARK TimelineProtocol
    
    func showComment(index: Int) {
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let vc: CommentsTableViewController = storyboard.instantiateViewControllerWithIdentifier(CommentTableViewID) as! CommentsTableViewController
        
        self.navigationController?.pushViewController(vc, animated: true)
    }
    
    func showProfile() {
        
        self.ChangeState(.Profile)
    }
    
    func showCart(){
        
        self.ChangeState(.Addtocart)
    }
    
    func showActionSheet(image: UIImage, caption: String) {
        
        var actionSheetSection: JGActionSheetSection = JGActionSheetSection(title: nil, message: nil, buttonTitles: ["ADD TO WISHLIST", "ADD TO COLLECTIONS", "POST TO FACEBOOK", "POST TO INSTAGRAM", "TAG AS INAPPROPRIATE"], buttonStyle: JGActionSheetButtonStyle.Default)
        var cancelActionSheetSection: JGActionSheetSection = JGActionSheetSection(title: nil, message: nil, buttonTitles: ["CANCEL"], buttonStyle: JGActionSheetButtonStyle.Default)
        
        actionSheetSection.settimelineyes()
        cancelActionSheetSection.settimelineyes()
        
        let sections = [actionSheetSection, cancelActionSheetSection]
        
        var actionSheet: JGActionSheet = JGActionSheet(sections: sections)
        
        actionSheet.buttonPressedBlock = {(actionSheet: JGActionSheet!, indexPath: NSIndexPath!) in
            
            if indexPath.section == 0 {
                switch(indexPath.row) {
                case 0:
                    actionSheet.dismissAnimated(true)
                    self.createWishContainerView()
                    NSNotificationCenter.defaultCenter().postNotificationName(wishListNotifKey, object: self)
                    
                case 1:
                    actionSheet.dismissAnimated(true)
                    self.createCollectionsContainerView()
                    NSNotificationCenter.defaultCenter().postNotificationName(collectionsNotifKey, object: self)
                    
                case 2:
                    actionSheet.dismissAnimated(true)
                    self.createPostFBContainerView(image, caption: caption)
                    
                case 3:
                    actionSheet.dismissAnimated(true)
                    self.createPostInstaView(image, caption: caption)
                case 4:
                    actionSheet.dismissAnimated(true)
                    self.tagInappropriate()
                    
                default:
                    actionSheet.dismissAnimated(true)
                }
                
            }
            else if indexPath.section == 1 {
                switch(indexPath.row) {
                default:
                    actionSheet.dismissAnimated(true)
                    //
                }
            }
        }
        
        actionSheet.outsidePressBlock = {(actionSheet: JGActionSheet!) in
            
            actionSheet.dismissAnimated(true)
        }
        myactionSheetSection = actionSheet
        actionSheet.showInView(self.view, animated: true)
    }
    
    
    func createWishContainerView () {
        wishcontainerVC = storyboard?.instantiateViewControllerWithIdentifier("wishListContainerView") as? WishListContainerView
        
        addChildViewController(wishcontainerVC!)
        self.view.addSubview(wishcontainerVC!.view)
        wishcontainerVC!.titleLabel.text = "ADD TO WISHLIST"
        wishcontainerVC!.doneButton.addTarget(self, action: "doneButtonTapped", forControlEvents: .TouchUpInside)
        wishcontainerVC!.didMoveToParentViewController(self)
    }
    
    func doneButtonTapped () {
        
        wishcontainerVC!.removeFromParentViewController()
        wishcontainerVC!.view.removeFromSuperview()
    }
    
    func createCollectionsContainerView () {
        
        wishcontainerVC = storyboard?.instantiateViewControllerWithIdentifier("wishListContainerView") as? WishListContainerView
        
        addChildViewController(wishcontainerVC!)
        self.view.addSubview(wishcontainerVC!.view)
        wishcontainerVC!.titleLabel.text = "ADD TO COLLECTIONS"
        wishcontainerVC!.doneButton.addTarget(self, action: "doneButtonTapped", forControlEvents: .TouchUpInside)
        wishcontainerVC!.didMoveToParentViewController(self)
    }
    
    func createPostFBContainerView (image: UIImage, caption: String) {

        if SLComposeViewController.isAvailableForServiceType(SLServiceTypeFacebook) {
            var fbSheet = SLComposeViewController(forServiceType: SLServiceTypeFacebook)
            fbSheet.setInitialText(caption)
            fbSheet.addImage(image)
            
            self.presentViewController(fbSheet, animated: true, completion: nil)
        } else {
            println("error") 
        }
        
//        postFBVC = storyboard?.instantiateViewControllerWithIdentifier("postFB") as? PostFBContainerViewController
//        
//        addChildViewController(postFBVC!)
//        self.view.addSubview(postFBVC!.view)
//        postFBVC!.titleLabel.text = "FACEBOOK"
//        postFBVC!.contentImageView.image = UIImage(named: "Looks_Cell")
//        postFBVC!.cancelButton.addTarget(self, action: "cancelButtonTapped", forControlEvents: .TouchUpInside)
//        postFBVC!.postButton.addTarget(self, action: "postFBTapped", forControlEvents: .TouchUpInside)
//        postFBVC!.didMoveToParentViewController(self)
    }
    
    func createPostInstaView (image: UIImage, caption: String) {
        
        postFBVC = storyboard?.instantiateViewControllerWithIdentifier("postFB") as? PostFBContainerViewController
        
        addChildViewController(postFBVC!)
        self.view.addSubview(postFBVC!.view)
        postFBVC?.titleLabel.text = "INSTAGRAM"
        postFBVC!.contentImageView.image = image
        postFBVC!.contentTextView.text = caption
        postFBVC!.cancelButton.addTarget(self, action: "cancelButtonTapped", forControlEvents: .TouchUpInside)
        postFBVC!.postButton.addTarget(self, action: "postInstagramTapped", forControlEvents: .TouchUpInside)
    }
    
    func tagInappropriate()
    {
        
    }
    
    func cancelButtonTapped () {
        
        postFBVC!.removeFromParentViewController()
        postFBVC!.view.removeFromSuperview()
    }
    
    func postFBTapped () {
        
        SocialTools.sharedInstance.postOnFacebook()
        
        println("posted to fb")
        postFBVC!.removeFromParentViewController()
        postFBVC!.view.removeFromSuperview()
    }
    
    func postInstagramTapped () {
        let instagramURL = NSURL(string: "instagram://app")!
        if UIApplication.sharedApplication().canOpenURL(instagramURL) {
            let rect = CGRectZero
            UIGraphicsBeginImageContextWithOptions(CGSizeMake(640, 640), self.view.opaque, 0)
            self.postFBVC?.contentImageView.image?.drawInRect(CGRect(origin: CGPointZero, size: CGSizeMake(612, 612)))
            let scaledImage = UIGraphicsGetImageFromCurrentImageContext()
            UIGraphicsEndImageContext()
            
            
            let imageData = UIImagePNGRepresentation(scaledImage)
            let fileManager = NSFileManager.defaultManager()
            let paths: NSArray = NSSearchPathForDirectoriesInDomains(NSSearchPathDirectory.DocumentDirectory, NSSearchPathDomainMask.UserDomainMask, true)
            let documentDirectory: AnyObject = paths.objectAtIndex(0)
            let fullPath = documentDirectory.stringByAppendingPathComponent("insta.igo")
            fileManager.createFileAtPath(fullPath, contents: imageData, attributes: nil)
            
            docu = UIDocumentInteractionController(URL: NSURL(fileURLWithPath: fullPath as String)!)
            docu!.UTI = "com.instagram.exclusivegram"
            docu!.delegate = self
            docu!.annotation = NSDictionary(object: self.postFBVC!.contentTextView.text, forKey: "InstagramCaption")
            docu!.presentOpenInMenuFromRect(rect, inView: self.view, animated: true)
        }
        else {
            println("Don't have the app")
        }
        
        
        postFBVC!.removeFromParentViewController()
        postFBVC!.view.removeFromSuperview()
    }
    
    func adaptivePresentationStyleForPresentationController(
        controller: UIPresentationController!) -> UIModalPresentationStyle {
            return .None
    }
    
    
    //MARK: camera
    
    func createAlertViewController () {
        removePopup()
        
        let alertController = UIAlertController(title: "Choose Photo Option", message: nil, preferredStyle: .Alert)
        
        let takePhoto = UIAlertAction(title: "Take Photo", style: .Default) { action -> Void in
            self.takePhotoButtonTapped()
        }
        
        let cameraRoll = UIAlertAction(title: "Camera Roll", style: .Default) { action -> Void in
            self.presentLibrary()
        }
        
        let cancelAction = UIAlertAction(title: "Cancel", style: .Cancel) { (_) in
            
        }
        
        alertController.addAction(takePhoto)
        alertController.addAction(cameraRoll)
        alertController.addAction(cancelAction)
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
    
    func createpicker()
    {
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
    

    
    func noCamera () {
        
        let alertVC = UIAlertController(title: "No Camera", message: "Sorry, this device has no camera", preferredStyle: .Alert)
        let okAction = UIAlertAction(title: "OK", style:.Default, handler: nil)
        alertVC.addAction(okAction)
        presentViewController(alertVC, animated: true, completion: nil)
    }
    
    func presentLibrary () {
        
        if UIImagePickerController.isSourceTypeAvailable(UIImagePickerControllerSourceType.PhotoLibrary) {
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
    
    // picker returns with a photo
    
    func imagePickerController(picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [NSObject : AnyObject]) {
        
        var selectedImage = info[UIImagePickerControllerOriginalImage] as! UIImage
        
        if(picker.sourceType == UIImagePickerControllerSourceType.PhotoLibrary) {
            
            createUploadPicVC()
            uploadVC?.pictureImageView.image = selectedImage
            dismissViewControllerAnimated(true, completion: nil)
            
            
        }
        else if picker.sourceType == UIImagePickerControllerSourceType.Camera {
            
            createUploadPicVC()
            uploadVC?.pictureImageView.image = selectedImage
            dismissViewControllerAnimated(true, completion: nil)
        }
        
        uploadVC?.backUpimage = selectedImage
        
        
    }
    
    func imagePickerControllerDidCancel(picker: UIImagePickerController) {
        dismissViewControllerAnimated(true, completion: nil)
    }
    
    func createUploadPicVC () {
        
        uploadVC = storyboard?.instantiateViewControllerWithIdentifier("uploadVC") as? UploadPictureViewController
        addChildViewController(uploadVC!)
        self.view.addSubview(uploadVC!.view)
        
        uploadVC!.didMoveToParentViewController(self)
    }
    
    func createcameraImageView () {
        
        cameraImageView.setTranslatesAutoresizingMaskIntoConstraints(false)
        self.view.addSubview(cameraImageView)
        
        let views = ["image": cameraImageView]
        
        self.view.addConstraints(NSLayoutConstraint.constraintsWithVisualFormat("V:[image(==200)]", options: NSLayoutFormatOptions(0), metrics: nil, views: views))
        self.view.addConstraints(NSLayoutConstraint.constraintsWithVisualFormat("H:[image(==200)]", options: NSLayoutFormatOptions(0), metrics: nil, views: views))
        self.view.addConstraint(NSLayoutConstraint(item: cameraImageView, attribute: .CenterX, relatedBy: .Equal, toItem: self.view, attribute: .CenterX, multiplier: 1, constant: 0))
        self.view.addConstraint(NSLayoutConstraint(item: cameraImageView, attribute: .CenterY, relatedBy: .Equal, toItem: self.view, attribute: .CenterY, multiplier: 1, constant: 0))
    }
    
}
