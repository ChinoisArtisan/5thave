//
//  ShippingAddressViewController.swift
//  5thAve
//
//  Created by Emagid Corp on 4/15/15.
//  Copyright (c) 2015 Beyond 2021. All rights reserved.
//

import Foundation
import UIKit

class ShippingAddressViewController: UIViewController, UITextFieldDelegate, UIPickerViewDataSource, UIPickerViewDelegate, navaction{
    
    @IBOutlet var useSameAddress: UIButton!
    var mypicker = UIPickerView()
    
    
    @IBOutlet var firstNameField: UITextField!
    @IBOutlet var lastNameField: UITextField!
    @IBOutlet var addressField: UITextField!
    @IBOutlet var postalCodeField: UITextField!
    @IBOutlet weak var cityField: UITextField!
    
    @IBOutlet weak var stateField: UITextField!
    
    @IBOutlet var selectCountryButton: UIButton!
    @IBOutlet var selectButton: UIButton!
    
    @IBOutlet var saveButton: UIButton!
    var delegate:ShoppingStep?
    
    
    var useBillingAddress: Bool = true
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        firstNameField.delegate = self
        lastNameField.delegate = self
        addressField.delegate = self
        postalCodeField.delegate = self
        cityField.delegate = self
        stateField.delegate = self
        createpicker()
        self.navigationItem.titleView = NavButtonGenerator.sharedInstance.createnavtitle("SHIPPING ADDRESS")
        self.navigationItem.titleView?.sizeToFit()
        self.navigationItem.leftBarButtonItem = NavButtonGenerator.sharedInstance.createbackbutton(self)
        
    }
    
    @IBAction func choosecountry(sender: AnyObject) {
        self.view.endEditing(true)
        mypicker.reloadAllComponents()
        mypicker.hidden = false
    }
    
    @IBAction func savePushed(sender: AnyObject) {
        if checkfield()
        {
            self.navigationController?.popToRootViewControllerAnimated(true)
        }
    }
    
    func backaction() {
        self.navigationController?.popViewControllerAnimated(true)
    }
    
    @IBAction func SameBilling(sender: AnyObject) {
        
    }
    
    func checkfield() -> Bool
    {
        var message: String = ""
        if firstNameField.text == firstnameplaceholder
        {
            message += "First name\n"
        }
        if lastNameField.text == lastnameplaceholder
        {
            message += "Last name\n"
        }
        if addressField.text == addressplaceholder
        {
            message += "Address\n"
        }
        if cityField.text == cityplaceholder
        {
            message += "City\n"
        }
        if postalCodeField.text == postalplaceholder
        {
            message += "Postal Code\n"
        }
        if stateField.text == stateplaceholder
        {
            message += "State or Region\n"
        }
        if selectCountryButton.titleLabel?.text == "CHOOSE A COUNTRY"
        {
            message += "Country"
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
        mypicker.hidden = true
        self.view.endEditing(true)
    }
    
    func textFieldShouldBeginEditing(textField: UITextField) -> Bool {
        switch(textField)
        {
        case firstNameField:
            textField.text = (textField.text == firstnameplaceholder) ? "" : textField.text
        case lastNameField:
            textField.text = (textField.text == lastnameplaceholder) ? "" : textField.text
        case addressField:
            textField.text = (textField.text == addressplaceholder) ? "" : textField.text
        case postalCodeField:
            textField.text = (textField.text == postalplaceholder) ? "" : textField.text
        case cityField:
            textField.text = (textField.text == cityplaceholder) ? "" : textField.text
        default:
            textField.text = (textField.text == stateplaceholder) ? "" : textField.text
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
        case addressField:
            textField.text = (textField.text == "") ? addressplaceholder : textField.text
        case postalCodeField:
            textField.text = (textField.text == "") ? postalplaceholder : textField.text
        case cityField:
            textField.text = (textField.text == "") ? cityplaceholder : textField.text
        default:
            textField.text = (textField.text == "") ? stateplaceholder: textField.text
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
    
    
    
    
    
    
    //MARK: - Delegates and data sources
    //MARK: Data Sources
    func numberOfComponentsInPickerView(pickerView: UIPickerView) -> Int {
        return 1
    }
    func pickerView(pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return country.count
    }
    
    //MARK: Delegates
    func pickerView(pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String! {
        
        return country[row]
        
    }
    
    func pickerView(pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        return selectCountryButton.setTitle(country[row], forState: UIControlState.Normal)
    }
}