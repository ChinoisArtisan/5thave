//
//  BrandViewController.swift
//  5thAve
//
//  Created by Emagid Corp on 4/20/15.
//  Copyright (c) 2015 Beyond 2021. All rights reserved.
//

import Foundation

enum BrandProfilState{
    case shoptable
    case shopcollection
}


class BrandViewController: UIViewController, navaction{
    
    
    @IBOutlet weak var postsbutton: UIButton!
    @IBOutlet weak var shopbutton: UIButton!
    
    @IBOutlet weak var profilimage: PFImageView!
    
    @IBOutlet weak var favoributton: UIButton!
    @IBOutlet weak var followbutton: UIButton!
    
    
    @IBOutlet weak var nbOfPost: UILabel!
    @IBOutlet weak var nbOfFollower: UILabel!
    @IBOutlet weak var nbOfFollowing: UILabel!
    
    
    var shopstate: BrandProfilState = .shoptable
    var isPosts: Bool = false
    var isFavori: Bool = true
    var currentvc: UIViewController?
    
    
    @IBOutlet weak var profilcontainer: UIView!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.navigationItem.leftBarButtonItem = NavButtonGenerator.sharedInstance.createbackbutton(self)
        self.navigationItem.titleView = NavButtonGenerator.sharedInstance.createnavtitle("BRAND")
        self.navigationItem.titleView?.sizeToFit()
        
        self.Changeviewcontroller()
        Tools.sharedInstance.roundImageView(profilimage, borderWitdh: 1.0)
    }
    
    override func viewWillDisappear(animated: Bool) {
        super.viewWillDisappear(animated)
    }
    
    func backaction() {
        self.navigationController?.popViewControllerAnimated(true)
    }
    
    @IBAction func postspushed(sender: AnyObject) {
        if (!isPosts)
        {
            self.isPosts = !isPosts
            Changeviewcontroller()
        }
    }
    
    @IBAction func shoppushed(sender: AnyObject) {
        if (isPosts)
        {
            self.isPosts = !isPosts
            Changeviewcontroller()
        }
    }
    
    func buttonClicked(){
        
        if (isPosts)
        {
            shopbutton.backgroundColor = UIColor.blackColor()
            postsbutton.backgroundColor = AppColor.lightBlueColorApp()
        }
        else
        {
            postsbutton.backgroundColor = UIColor.blackColor()
            shopbutton.backgroundColor = AppColor.lightBlueColorApp()
        }
    }
    
    func Changeviewcontroller()
    {
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        var vc: UIViewController
        
        /*
        if (shopstate == .shopcollection)
        {
        println("")
        
        if (!isPosts)
        {
        delegate?.navigationItem.leftBarButtonItem = self.navigationItem.leftBarButtonItem
        }
        else
        {
        delegate?.navigationItem.leftBarButtonItem = self.old
        }
        
        }*/
        
        
        self.buttonClicked()
        
        
        if (!isPosts)
        {
            if (self.shopstate == .shoptable)
            {
                vc = storyboard.instantiateViewControllerWithIdentifier(BrandProfilTableviewID) as! BrandProfilTableview
                (vc as! BrandProfilTableview).delegate = self
            }
            else
            {
                vc = storyboard.instantiateViewControllerWithIdentifier(BrandProfilCollectionViewID) as! BrandProfilCollectionView
                (vc as! BrandProfilCollectionView).isCart = true
            }
        }
        else
        {
            vc = storyboard.instantiateViewControllerWithIdentifier(BrandProfilCollectionViewID) as! BrandProfilCollectionView
            (vc as! BrandProfilCollectionView).isCart = false
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
        
        vc.view.frame = self.profilcontainer.bounds
        self.profilcontainer.addSubview(vc.view)
        
        
        //Change the currentvc variable
        self.currentvc = vc
    }
    
    @IBAction func changeFavori(sender: AnyObject) {
        isFavori = !isFavori
        if (isFavori)
        {
            self.favoributton.setImage(UIImage(named:"star_selected@x2.png"), forState: UIControlState.Normal)
        }
        else
        {
            self.favoributton.setImage(UIImage(named: "star_unselected@x2.png"), forState: UIControlState.Normal)
        }
        
    }
    
    
    func pushList(name:String)
    {
        let vc = (storyboard!.instantiateViewControllerWithIdentifier(BrandListCategorieID) as! BrandListCategorie)
        (vc as BrandListCategorie).name = name
        self.navigationController?.pushViewController(vc, animated: true)
    }
    
    
    
}