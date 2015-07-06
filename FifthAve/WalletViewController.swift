//
//  WalletViewController.swift
//  5thAve
//
//  Created by WANG Michael on 04/05/2015.
//  Copyright (c) 2015 emagid. All rights reserved.
//

import Foundation
import UIKit


class WalletViewController: UIViewController, UITableViewDelegate, UITableViewDataSource{
    
    
    @IBOutlet weak var creditlist: UITableView!
    
    var cards: [String] = ["VISA ---1010", "MASTER ---4356", "MASTER ---4976"]
    
    @IBOutlet weak var cardslistheight: NSLayoutConstraint!
    var delegate:ShoppingStep?
    
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.creditlist.tableFooterView = UIView()
        if (cards.count * 44) > 300
        {
            cardslistheight.constant = 300
        }
        else
        {
            cardslistheight.constant = CGFloat(cards.count + 1) * 44.0
        }
    }
    
    
    
    
    @IBAction func usePaypal(sender: AnyObject) {
        
    }
    
    @IBAction func useApplePay(sender: AnyObject) {
        
    }
    
    func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        if (indexPath.row == cards.count)
        {
            let cell:UITableViewCell = tableView.dequeueReusableCellWithIdentifier("AddCardCell", forIndexPath: indexPath) as! UITableViewCell
            return cell
        }
        else
        {
            let cell:UITableViewCell = tableView.dequeueReusableCellWithIdentifier("CreditCardCell", forIndexPath: indexPath) as! UITableViewCell
            cell.textLabel?.text = cards[indexPath.row]
            return cell
        }
        
    }
    
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        self.creditlist.deselectRowAtIndexPath(self.creditlist.indexPathForSelectedRow()!, animated: true)
        if (indexPath.row == cards.count)
        {
            // Add new cards
            let vc = (storyboard!.instantiateViewControllerWithIdentifier(CreditCardInfoViewControllerID) as? CreditCardInfoViewController)!
            self.navigationController?.pushViewController(vc, animated: true)
        }
        else
        {
            // Display the popup to comfirm the checkout
            self.delegate?.ShowPopup()
        }
    }
    
    func tableView(tableView: UITableView, accessoryButtonTappedForRowWithIndexPath indexPath: NSIndexPath) {
        if (indexPath.row == cards.count)
        {
            // Add new cards
            let vc = (storyboard!.instantiateViewControllerWithIdentifier(CreditCardInfoViewControllerID) as? CreditCardInfoViewController)!
            self.navigationController?.pushViewController(vc, animated: true)
        }
        else
        {
            // Select a registered card
            let vc = (storyboard!.instantiateViewControllerWithIdentifier(CreditCardInfoViewControllerID) as? CreditCardInfoViewController)!
            self.navigationController?.pushViewController(vc, animated: true)
        }
    }
    
    func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
        return 44.0
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return cards.count + 1
    }
    
    
    
    
}