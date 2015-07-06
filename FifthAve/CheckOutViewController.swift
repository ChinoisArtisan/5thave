//
//  CheckOutViewController.swift
//  5thAve
//
//  Created by WANG Michael on 04/05/2015.
//  Copyright (c) 2015 emagid. All rights reserved.
//

import Foundation
import UIKit


protocol ShoppingCartProtocol{
    func deleteItem(index: Int)
    func ChangeNumber(id: Int)
}


class CheckOutViewController: UIViewController, UITableViewDelegate, UITableViewDataSource, ShoppingCartProtocol, UIPickerViewDataSource, UIPickerViewDelegate{
    
    
    @IBOutlet weak var mytableview: UITableView!
    
    @IBOutlet weak var ShippingPrice: UILabel!
    @IBOutlet weak var SalesTax: UILabel!
    @IBOutlet weak var TotalLabel: UILabel!
    
    var shippingvalue: Double = 0.0
    var salevalue: Double = 0.0
    var totalvalue: Double = 0.0
    var mypicker = UIPickerView()

    var data: [ItemCart] = [ItemCart(itemimage: "EFM_Launch.jpg", itemname: "item1", itemref: "ref: 2002"), ItemCart(itemimage: "EFM_Launch.jpg", itemname: "item2", itemref: "ref: 2002"), ItemCart(itemimage: "EFM_Launch.jpg", itemname: "item3", itemref: "ref: 2002")]
    var unitbutton: Int = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.mytableview.tableFooterView = UIView()
        var tap: UITapGestureRecognizer = UITapGestureRecognizer(target: self, action: "DismissPicker")
        self.mytableview.addGestureRecognizer(tap)
        
        mypicker = Tools.sharedInstance.createpicker(self)
        
        setShipping(3.0)
        setSale(4.0)
        setTotal()
    }
    
    func DismissPicker(){
        mypicker.hidden = true
    }
    
    func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell: ShoppingCartCell = tableView.dequeueReusableCellWithIdentifier(ShoppingCartCellID, forIndexPath: indexPath) as! ShoppingCartCell

        cell.delegate = self
        cell.id = indexPath.row
        
        
        cell.ItemImage.image = UIImage(named: data[indexPath.row].image)
        cell.ItemName.text = data[indexPath.row].name
        cell.ItemPrice.text = toString(data[indexPath.row].price)
        cell.ItemRef.text = "Ref: 2002"
        cell.ItemSize.text = "EXTRA EXTRA LARGE"
        cell.ItemPrice.text = String(format:"%f", data[indexPath.row].price)
        cell.ItemPrice.text = Tools.sharedInstance.priceFormat(data[indexPath.row].price)
        cell.ItemQuantity.setTitle(String(data[indexPath.row].quantity), forState: UIControlState.Normal)
        //cell.ItemQuantity.addTarget(self, action: "ChangeNumber:", forControlEvents: UIControlEvents.TouchUpInside)
        
        return cell
    }

    
    func ChangeNumber(id: Int)
    {
        unitbutton = id
        mypicker.reloadAllComponents()
        mypicker.selectRow(data[unitbutton].quantity - 1, inComponent: 0, animated: true)
        mypicker.hidden = false
    }
    
    
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        
    }
    
    func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
        return 110.0
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return data.count
    }
    
    func deleteItem(index: Int) {
        data.removeAtIndex(index)
        mytableview.reloadData()
        if (data.count == 0)
        {
            setSale(0.0)
            setShipping(0.0)
        }
        
        setTotal()
    }

    func setShipping(value: Double)
    {
        shippingvalue = value
        ShippingPrice.text = Tools.sharedInstance.priceFormat(shippingvalue)
    }
    
    func setSale(value: Double)
    {
        salevalue = value
        SalesTax.text = Tools.sharedInstance.priceFormat(salevalue)
    }
    
    func setTotal()
    {
        totalvalue = 0
        for item in data
        {
            totalvalue += Double(item.quantity) * item.price
        }
        
        totalvalue += salevalue + shippingvalue
        TotalLabel.text = Tools.sharedInstance.priceFormat(totalvalue)
    }
    
    override func touchesBegan(touches: Set<NSObject>, withEvent event: UIEvent) {
        mypicker.hidden = true
    }
    
    //MARK: - Delegates and data sources
    //MARK: Data Sources
    func numberOfComponentsInPickerView(pickerView: UIPickerView) -> Int {
        return 1
    }
    func pickerView(pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return 20
    }
    
    //MARK: Delegates
    func pickerView(pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String! {
        return String(row + 1)
    }
    
    func pickerView(pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        data[unitbutton].quantity = row + 1
        mytableview.reloadData()
        setTotal()
    }

    
}