//
//  ShoppingCartViewController.swift
//  5thAve
//
//  Created by Emagid Corp on 4/21/15.
//  Copyright (c) 2015 Beyond 2021. All rights reserved.
//

import Foundation
import UIKit

enum ShoppingCartState{
    case Mywallet
    case CheckOut
    
    case Billing
    case Shipping
    case CardInfo
    
}


protocol ShoppingStep
{
    func ShowPopup()
    func RemovePopup()
    func ChangeState(state:ShoppingCartState)
    func getMainNavi()->UINavigationItem
}

class ShoppingCartViewController: UIViewController, ShoppingStep, CenterVCProtocol, navaction{
    
    @IBOutlet weak var CartContainer: UIView!
    
    @IBOutlet weak var CheckOutButton: UIButton!
    @IBOutlet weak var MyWalletButton: UIButton!
    
    var state: ShoppingCartState = .CheckOut
    var currentvc: UIViewController?
    var mainleftbutton: UIBarButtonItem?
    var MainNavi: UINavigationItem?
    var ContainerVC: ContainerProtocol?
    
    var popupVC: CheckOutPopupViewController?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        buttonClicked()
        
        self.navigationItem.leftBarButtonItem = NavButtonGenerator.sharedInstance.createmenubutton(self)
        
        
        self.Changeviewcontroller()
    }
    
    func menuaction()
    {
        self.ContainerVC?.menuAction()
    }
    
    func enableInteraction(enable:Bool)
    {
        self.view.userInteractionEnabled = enable
    }
    
    @IBAction func CheckOutButton(sender: AnyObject) {
        if self.state != .CheckOut
        {
            self.state = .CheckOut
            buttonClicked()
            
            self.Changeviewcontroller()
        }
    }
    
    @IBAction func MyWalletButton(sender: AnyObject) {
        if self.state != .Mywallet
        {
            self.state = .Mywallet
            buttonClicked()
            
            self.Changeviewcontroller()
        }
    }
    
    func buttonClicked(){
        
        if state == .CheckOut
        {
            MyWalletButton.backgroundColor = UIColor.blackColor()
            CheckOutButton.backgroundColor = AppColor.lightBlueColorApp()
            self.setNavBarTitle("SHOPPING CART")
        }
        else
        {
            CheckOutButton.backgroundColor = UIColor.blackColor()
            MyWalletButton.backgroundColor = AppColor.lightBlueColorApp()
            self.setNavBarTitle("MY WALLET")
        }
    }
    
    func setNavBarTitle(title:String)
    {
        self.navigationItem.titleView = NavButtonGenerator.sharedInstance.createnavtitle(title)
        self.navigationItem.titleView?.sizeToFit()
    }
    
    
    //MARK PopupVC
    func ShowPopup()
    {
        popupVC = storyboard?.instantiateViewControllerWithIdentifier("CheckOutPopupViewController") as? CheckOutPopupViewController
        popupVC!.view.frame = self.view.bounds
        popupVC!.delegate = self
        addChildViewController(popupVC!)
        self.view.addSubview(popupVC!.view)
        popupVC!.didMoveToParentViewController(self)
    }
    func RemovePopup()
    {
        popupVC!.removeFromParentViewController()
        popupVC!.view.removeFromSuperview()
    }
    
    func ChangeState(state: ShoppingCartState)
    {
        if (self.state != state)
        {
            self.state = state
            self.Changeviewcontroller()
        }
    }
    
    func getMainNavi()->UINavigationItem
    {
        return self.MainNavi!
    }
    
    func Changeviewcontroller()
    {
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        var vc: UIViewController
        
        if (state == .CheckOut)
        {
            vc = storyboard.instantiateViewControllerWithIdentifier(CheckOutViewControllerID) as! CheckOutViewController
            self.setNavBarTitle("SHOPPING CART")
        }
        else if (state == .Billing)
        {
            vc = (storyboard.instantiateViewControllerWithIdentifier(BillingAddressViewControllerID) as? BillingAddressViewController)!
            //(vc as! BillingAddressViewController).delegate = self
        }
        else if (state == .CardInfo)
        {
            vc = (storyboard.instantiateViewControllerWithIdentifier(CreditCardInfoViewControllerID) as? CreditCardInfoViewController)!
            //(vc as! CreditCardInfoViewController).delegate = self
        }
        else if (state == .Shipping)
        {
            vc = (storyboard.instantiateViewControllerWithIdentifier(ShippingAddressViewControllerID) as? ShippingAddressViewController)!
            (vc as! ShippingAddressViewController).delegate = self
        }
        else
        {
            vc = (storyboard.instantiateViewControllerWithIdentifier(WalletViewControllerID) as? WalletViewController)!
            (vc as! WalletViewController).delegate = self
            self.setNavBarTitle("MY WALLET")
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
        
        vc.view.frame = self.CartContainer.bounds
        self.CartContainer.addSubview(vc.view)
        
        
        //Change the currentvc variable
        self.currentvc = vc
    }
    
}