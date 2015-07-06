//
//  ContainerViewController.swift
//  5thAve
//
//  Created by WANG Michael on 28/04/2015.
//  Copyright (c) 2015 Beyond 2021. All rights reserved.
//

import Foundation
import UIKit


protocol MenuProtocol{
    func clickOnMenu(button:CenterContainerState)
    func switchCenterContainer(state:CenterContainerState)
}

protocol ContainerProtocol{
    func showLeft()
    func hideLeft()
    func menuAction()
}

protocol CenterVCProtocol: class{
    var ContainerVC: ContainerProtocol? { get set }
    func enableInteraction(enable:Bool)
}

enum CenterContainerState
{
    case Search
    case Main
    case Profile
    case Cart
    case DiscoverUsers
    case Notification
    case Settings
}

class ContainerViewController: UIViewController, ContainerProtocol, MenuProtocol{
    
    @IBOutlet weak var leftContainer: UIView!
    @IBOutlet weak var centerContainer: UIView!
    
    
    var centervc: UIViewController?
    var state: CenterContainerState = .Main
    var myNavigation: UINavigationController?
    
    var isMenuOut:Bool = false
    let defaults = NSUserDefaults.standardUserDefaults()

    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.addCenterNavigation()
        self.addMenuViewController()
        self.ChangeCenterContainer()
        
    }
    
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
    }
    
    override func viewDidAppear(animated: Bool) {
        super.viewDidAppear(animated)
        let isFirstTime = defaults.boolForKey("firstTimeBool")
        if isFirstTime {
            defaults.setBool(false, forKey: "firstTimeBool")
            defaults.synchronize()
            
            let vc = FirstDiscoverViewController()
            vc.delegate = self
            let nav = UINavigationController(rootViewController: vc)
            nav.navigationBar.translucent = false
            self.presentViewController(nav, animated: true, completion: nil)
        }

    }
    
    override func prefersStatusBarHidden() -> Bool {
        return true
    }
    
    func addMenuViewController()
    {
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let MenuVC = storyboard.instantiateViewControllerWithIdentifier(FlyOutMenuID) as! FlyOutMenuViewController
        MenuVC.delegate = self
        
        
        MenuVC.willMoveToParentViewController(self)
        self.addChildViewController(MenuVC)
        MenuVC.didMoveToParentViewController(self)
        
        
        let menu: CGRect = CGRect(origin: CGPoint(x: 0,y: 0), size: CGSize(width: self.leftContainer.frame.size.width, height: self.leftContainer.frame.size.height))
        MenuVC.view.frame = menu
        
        self.leftContainer.addSubview(MenuVC.view)
    }
    
    func addCenterNavigation ()
    {
        myNavigation = (storyboard!.instantiateViewControllerWithIdentifier(MainNavigationControllerID) as! UINavigationController)
        myNavigation!.willMoveToParentViewController(self)
        self.addChildViewController(myNavigation!)
        myNavigation!.didMoveToParentViewController(self)
        myNavigation!.view.frame = self.centerContainer.bounds
        self.centerContainer.addSubview(myNavigation!.view)
    }
    
    
    // Menu delegate
    func showLeft()
    {
        UIView.animateWithDuration(0.5, animations: {
            var viewframe = self.leftContainer.frame
            viewframe.origin.x += MenuWidth
            self.centerContainer.frame = viewframe
        })
    }
    
    func hideLeft()
    {
        UIView.animateWithDuration(0.5, animations: {
            var viewframe = self.leftContainer.frame
            viewframe.origin.x = 0
            self.centerContainer.frame = viewframe
        })
    }
    
    
    func clickOnMenu(button:CenterContainerState)
    {
        menuAction()
        switchCenterContainer(button)
    }
    
    
    func menuAction()
    {
        if (!isMenuOut)
        {
            // SlideOut the menu
            self.showLeft()
            isMenuOut = true
            (self.centervc! as! CenterVCProtocol).enableInteraction(false)
        }
        else
        {
            //SlideIn the menu
            self.hideLeft()
            isMenuOut = false
            (self.centervc! as! CenterVCProtocol).enableInteraction(true)
        }
    }
    
    
    
    
    
    func switchCenterContainer(state:CenterContainerState)
    {
        if self.state != state
        {
            self.state = state
            self.ChangeCenterContainer()
        }
    }
    
    func ChangeCenterContainer()
    {
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        var vc: UIViewController
        
        switch self.state
        {
        case .Main:
            self.centervc = storyboard.instantiateViewControllerWithIdentifier(Main5THViewControllerID) as! Main5THViewController
        case .Settings:
            self.centervc = storyboard.instantiateViewControllerWithIdentifier(SettingsViewControllerID) as! SettingsViewController
        case .Search:
            self.centervc = storyboard.instantiateViewControllerWithIdentifier(SearchTableViewControllerID) as! SearchTableViewController
        case .Profile:
            self.centervc = storyboard.instantiateViewControllerWithIdentifier(ProfilViewControllerID) as! ProfilViewController
            (self.centervc as! ProfilViewController).user = PFUser.currentUser()
        case .Cart:
            self.centervc = (storyboard.instantiateViewControllerWithIdentifier(ShoppingCartViewControllerID) as! ShoppingCartViewController)
        case .Notification:
            self.centervc = storyboard.instantiateViewControllerWithIdentifier(NotificationViewControllerID) as! NotificationViewController
        case .DiscoverUsers:
            self.centervc = storyboard.instantiateViewControllerWithIdentifier(DiscoverViewControllerID) as! DiscoverViewController
            (self.centervc as! DiscoverViewController).isPushed = false
        default:
            break
        }
        
        if let center = (self.centervc as? CenterVCProtocol){
            center.ContainerVC = self
        }
        
        let vcs = [self.centervc as! AnyObject]
        myNavigation?.setViewControllers(vcs, animated: true)
    }
    
    
}