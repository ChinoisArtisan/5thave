//
//  CreditCardInfoViewController.swift
//  5thAve
//
//  Created by Emagid Corp on 4/15/15.
//  Copyright (c) 2015 Beyond 2021. All rights reserved.
//

import Foundation
import UIKit

enum pickerstate{
    case year
    case month
    case cardtype
}


class CreditCardInfoViewController: UIViewController, UITextFieldDelegate, UIPickerViewDataSource, UIPickerViewDelegate, navaction{
    
    @IBOutlet var typeOfCardButton: UIButton!
    @IBOutlet var selectButton: UIButton!
    
    @IBOutlet var firstNameField: UITextField!
    @IBOutlet var lastNameField: UITextField!
    @IBOutlet var cardNumberField: UITextField!
    @IBOutlet weak var monthButton: UIButton!
    @IBOutlet weak var yearButton: UIButton!
    
    @IBOutlet var cscField: UITextField!
    
    @IBOutlet var saveButton: UIButton!
    
    var mypicker = UIPickerView()
    let cardtype = ["VISA", "MASTER CARD"]
    
    var pickerstatus: pickerstate = .year
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        firstNameField.delegate = self
        lastNameField.delegate = self
        cardNumberField.delegate = self
        cscField.delegate = self
        
        createpicker()
        self.navigationItem.titleView = NavButtonGenerator.sharedInstance.createnavtitle("CREDIT CARD INFO")
        self.navigationItem.titleView?.sizeToFit()
        self.navigationItem.leftBarButtonItem = NavButtonGenerator.sharedInstance.createbackbutton(self)
    }
    
    override func viewDidAppear(animated: Bool) {
        super.viewDidAppear(animated)
    }
    
    func doneAction()
    {
        self.view.endEditing(true)
    }
    
    func backaction() {
        self.navigationController?.popViewControllerAnimated(true)
    }
    
    @IBAction func saveClicked(sender: AnyObject) {
        if checkfield()
        {
            let vc = (storyboard!.instantiateViewControllerWithIdentifier(BillingAddressViewControllerID) as? BillingAddressViewController)!
            self.navigationController?.pushViewController(vc, animated: true)
        }
    }
    
    
    @IBAction func backPushed(sender: AnyObject) {
        self.navigationController?.popViewControllerAnimated(true)
    }
    
    
    func checkfield() -> Bool
    {
        var message: String = ""
        if typeOfCardButton.titleLabel?.text == "TYPE OF CARD"
        {
            message += "Type of card\n"
        }
        if firstNameField.text == firstnameplaceholder
        {
            message += "First name\n"
        }
        if lastNameField.text == lastnameplaceholder
        {
            message += "Last name\n"
        }
        if cardNumberField.text == cardnumberplaceholder
        {
            message += "Card number\n"
        }
        if monthButton.titleLabel?.text == "MM"
        {
            message += "Expiration month\n"
        }
        if yearButton.titleLabel?.text == "YYYY"
        {
            message += "Expiration year\n"
        }
        if cscField.text == cvcplaceholder
        {
            message += "CVC code"
        }
        
        if message != ""
        {
            message  = "Please complete the :\n" + message
            var alert = UIAlertController(title: "Alert", message: message, preferredStyle: UIAlertControllerStyle.Alert)
            alert.addAction(UIAlertAction(title: "OK", style: UIAlertActionStyle.Default, handler: nil))
            
            self.presentViewController(alert, animated: true, completion: nil)
            
            return false
        }
        return true
    }
    
    
    // MARK UITextField Delegate
    
    func textFieldDidBeginEditing(textField: UITextField) {
        textField.becomeFirstResponder()
        mypicker.hidden = true
        
    }
    
    func textFieldShouldReturn(textField: UITextField) -> Bool {
        
        textField.resignFirstResponder()
        return true
    }
    
    override func touchesBegan(touches: Set<NSObject>, withEvent event: UIEvent) {
        
        self.view.endEditing(true)
        mypicker.hidden = true
    }
    
    
    func textFieldShouldBeginEditing(textField: UITextField) -> Bool {
        switch(textField)
        {
        case firstNameField:
            textField.text = (textField.text == firstnameplaceholder) ? "" : textField.text
        case lastNameField:
            textField.text = (textField.text == lastnameplaceholder) ? "" : textField.text
        case cardNumberField:
            textField.text = (textField.text == cardnumberplaceholder) ? "" : textField.text
        default:
            textField.text = (textField.text == cvcplaceholder) ? "" : textField.text
            textField.secureTextEntry = true
        }
        return true
    }
    
    func textField(textField: UITextField, shouldChangeCharactersInRange range: NSRange, replacementString string: String) -> Bool {
        if textField == cscField
        {
            return ((count(textField.text) - range.length + count(string)) <= 4)
        }
        return true
    }
    
    func textFieldDidEndEditing (textField: UITextField) {
        switch(textField)
        {
        case firstNameField:
            textField.text = (textField.text == "") ? firstnameplaceholder : textField.text
        case lastNameField:
            textField.text = (textField.text == "") ? lastnameplaceholder : textField.text
        case cardNumberField:
            textField.text = (textField.text == "") ? cardnumberplaceholder : textField.text
        default:
            textField.secureTextEntry = (textField.text != "")
            textField.text = (textField.text == "") ? cvcplaceholder : textField.text
        }
    }
    
    
    func createpicker()
    {
        mypicker.setTranslatesAutoresizingMaskIntoConstraints(false)
        mypicker.backgroundColor = UIColor.whiteColor()
        mypicker.hidden = true
        mypicker.delegate = self
        mypicker.dataSource = self
        self.view.addSubview(mypicker)
        
        let views = ["view": self.view, "picker": mypicker]
        
        view.addConstraint(NSLayoutConstraint(item: mypicker, attribute: .Bottom, relatedBy: .Equal, toItem: self.view, attribute: .Bottom, multiplier: 1, constant: 0))
        view.addConstraint(NSLayoutConstraint(item: mypicker, attribute: .CenterX, relatedBy: .Equal, toItem: self.view, attribute: .CenterX, multiplier: 1, constant: 0))
        view.addConstraint(NSLayoutConstraint(item: mypicker, attribute: .Width, relatedBy: .Equal, toItem: self.view, attribute: .Width, multiplier: 1, constant: 0))
        
    }
    
    
    
    @IBAction func choosethecard(sender: AnyObject) {
        self.view.endEditing(true)
        pickerstatus = .cardtype
        mypicker.reloadAllComponents()
        mypicker.hidden = false
    }
    
    @IBAction func chooseyear(sender: AnyObject) {
        self.view.endEditing(true)
        pickerstatus = .year
        mypicker.reloadAllComponents()
        mypicker.hidden = false
    }
    
    @IBAction func choosemonth(sender: AnyObject) {
        self.view.endEditing(true)
        pickerstatus = .month
        mypicker.reloadAllComponents()
        mypicker.hidden = false
    }
    
    //MARK: - Delegates and data sources
    //MARK: Data Sources
    func numberOfComponentsInPickerView(pickerView: UIPickerView) -> Int {
        return 1
    }
    func pickerView(pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        if pickerstatus == .cardtype
        {
            return cardtype.count
        }
        else if pickerstatus == .month
        {
            return month.count
        }
        else
        {
            return maxyear - year
        }
    }
    
    //MARK: Delegates
    func pickerView(pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String! {
        if pickerstatus == .cardtype
        {
            return cardtype[row]
        }
        else if pickerstatus == .month
        {
            return month[row]
        }
        else
        {
            return String(year + row)
        }
        
    }
    
    func pickerView(pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        if pickerstatus == .cardtype
        {
            return typeOfCardButton.setTitle(cardtype[row], forState: UIControlState.Normal)
        }
        else if pickerstatus == .month
        {
            return monthButton.setTitle(month[row], forState: UIControlState.Normal)
        }
        else
        {
            return yearButton.setTitle(String(year + row), forState: UIControlState.Normal)
        }
    }
    
    
}
