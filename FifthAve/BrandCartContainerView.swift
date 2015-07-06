//
//  BrandCartContainerView.swift
//  5thAve
//
//  Created by WANG Michael on 08/05/2015.
//  Copyright (c) 2015 emagid. All rights reserved.
//

import Foundation
import UIKit


enum CartPop
{
    case size
    case color
    case quantity
}

class BrandCartContainerView: UIViewController, UIPickerViewDelegate, UIPickerViewDataSource{
    
    
    @IBOutlet weak var CloseButton: UIButton!
    @IBOutlet weak var itemimage: PFImageView!
    @IBOutlet weak var previousbutton: UIButton!
    @IBOutlet weak var nextbutton: UIButton!
    
    @IBOutlet weak var itemname: UILabel!
    @IBOutlet weak var itemmodel: UILabel!
    @IBOutlet weak var itemprice: UILabel!
    
    @IBOutlet weak var sizefield: UITextField!
    @IBOutlet weak var colorfield: UITextField!
    @IBOutlet weak var quantityfield: UITextField!
    
    @IBOutlet weak var sizebutton: TimelineButton!
    @IBOutlet weak var colorbutton: TimelineButton!
    @IBOutlet weak var quantitybutton: TimelineButton!
    
    @IBOutlet weak var wishbutton: UIButton!
    @IBOutlet weak var cartbutton: UIButton!
    
    @IBOutlet weak var cartspace: NSLayoutConstraint!
    @IBOutlet weak var wishheight: NSLayoutConstraint!
    @IBOutlet weak var wishwidth: NSLayoutConstraint!
    
    @IBOutlet weak var containview: UIView!
    
    var mypicker: UIPickerView = UIPickerView()
    var data: [String] = []
    
    var wishenable: Bool = true
    var state: CartPop = .color
    
    var sizeIndex = 0
    var colorIndex = 0
    var quantityIndex = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setitemprice(200.0)
        mypicker = Tools.sharedInstance.createpicker(self)
        addAction()
    }
    
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
        
        if !wishenable
        {
            removeWishbutton()
            changeclosebutton()
        }
    }
    
    override func viewDidAppear(animated: Bool) {
        super.viewDidAppear(animated)
        resizetoucharea()
        
        
    }
    
    func resizetoucharea()
    {
        self.sizebutton.hitframe = UIEdgeInsetsMake(-3, -self.sizefield.bounds.size.width, -3, -3)
        self.colorbutton.hitframe = UIEdgeInsetsMake(-3, -self.colorfield.bounds.size.width, -3, -3)
        self.quantitybutton.hitframe = UIEdgeInsetsMake(-3, -self.quantityfield.bounds.size.width, -3, -3)
    }
    
    
    func addAction()
    {
        self.sizebutton.addTarget(self, action: "selectsize", forControlEvents: UIControlEvents.TouchUpInside)
        self.colorbutton.addTarget(self, action: "selectcolor", forControlEvents: UIControlEvents.TouchUpInside)
        self.quantitybutton.addTarget(self, action: "selectquantity", forControlEvents: UIControlEvents.TouchUpInside)
    }
    
    
    func selectsize ()
    {
        data = size
        state = .size
        mypicker.reloadAllComponents()
        mypicker.selectRow(sizeIndex, inComponent: 0, animated: true)
        mypicker.hidden = false
    }
    
    func selectcolor ()
    {
        data = color
        state = .color
        mypicker.reloadAllComponents()
        mypicker.selectRow(colorIndex, inComponent: 0, animated: true)
        
        mypicker.hidden = false
    }
    
    func selectquantity ()
    {
        state = .quantity
        mypicker.reloadAllComponents()
        mypicker.selectRow(quantityIndex, inComponent: 0, animated: true)
        
        mypicker.hidden = false
    }
    
    func setitemprice (price: Double)
    {
        itemprice.text = Tools.sharedInstance.priceFormat(price)
    }
    
    
    func removeWishbutton ()
    {
        wishbutton.hidden = true
        //cartspace.constant = 0
        //wishwidth.constant = 0
    }
    
    func changeclosebutton()
    {
        CloseButton.setImage(UIImage(named: "closet_delete_button@x3.png"), forState: UIControlState.Normal)
    }
    
    override func touchesBegan(touches: Set<NSObject>, withEvent event: UIEvent) {
        mypicker.hidden = true
        
        //Check if the user is touch inside the frame or not
        let location = touches.first as! UITouch
        let toucheLocation = location.locationInView(self.view)
        
        let myframe = self.view.convertRect(self.containview.frame, fromView: self.containview)
        if !CGRectContainsPoint(self.containview.frame, toucheLocation)
        {
            self.removeFromParentViewController()
            self.view.removeFromSuperview()
        }
    }
    
    
    
    
    
    //MARK: - Delegates and data sources
    //MARK: Data Sources
    func numberOfComponentsInPickerView(pickerView: UIPickerView) -> Int {
        return 1
    }
    func pickerView(pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        if state == .quantity
        {
            return 40
        }
        return data.count
    }
    
    //MARK: Delegates
    func pickerView(pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String! {
        
        if state == .quantity
        {
            return String(row + 1)
        }
        
        return data[row]
    }
    
    func pickerView(pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        switch (state)
        {
        case .color:
            colorfield.text = data[row]
            colorIndex = row
        case .size:
            sizefield.text = data[row]
            sizeIndex = row
        case .quantity:
            quantityfield.text = String(row + 1)
            quantityIndex = row
        default:
            break
        }
        
    }
    
    
}