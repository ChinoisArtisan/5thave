//
//  AddToCartViewController.swift
//  5thAve
//
//  Created by KEEVIN MITCHELL on 3/25/15.
//  Copyright (c) 2015 Beyond 2021. All rights reserved.
//

import UIKit

class AddToCartViewController: UITableViewController, navaction{
    var brandcontainerVC: BrandCartContainerView?
    
    var data: [PFFile] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.tableView.tableFooterView = UIView()
        self.tableView.rowHeight = UITableViewAutomaticDimension
        self.tableView.estimatedRowHeight = 44.0
        
        self.navigationItem.leftBarButtonItem = NavButtonGenerator.sharedInstance.createbackbutton(self)
        self.navigationItem.titleView = NavButtonGenerator.sharedInstance.createnavtitle("ADD TO CART")
        self.navigationItem.titleView?.sizeToFit()
    }
    
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
    }
    
    override func viewDidAppear(animated: Bool) {
        super.viewDidAppear(animated)
    }
    
    override func viewWillDisappear(animated: Bool) {
        super.viewWillDisappear(animated)
    }
    
    func backaction() {
        self.navigationController?.popViewControllerAnimated(true)
    }
    
    
    // MARK - Popup Cart
    
    func showPopup()
    {
        brandcontainerVC = storyboard?.instantiateViewControllerWithIdentifier("BrandCartContainerView") as? BrandCartContainerView
        brandcontainerVC!.view.frame = self.view.bounds
        
        addChildViewController(brandcontainerVC!)
        self.view.addSubview(brandcontainerVC!.view)
        
        brandcontainerVC!.itemimage.image = UIImage(named: "EFM_Launch.jpg")
        brandcontainerVC!.itemname.text = "SLIM JEANS"
        brandcontainerVC!.itemmodel.text = "Model 4242"
        brandcontainerVC!.itemprice.text = Tools.sharedInstance.priceFormat(20.0)
        
        brandcontainerVC!.CloseButton.addTarget(self, action: "doneButtonTapped", forControlEvents: .TouchUpInside)
        brandcontainerVC!.didMoveToParentViewController(self)
    }
    
    func doneButtonTapped () {
        brandcontainerVC!.removeFromParentViewController()
        brandcontainerVC!.view.removeFromSuperview()
    }
    
    
    //MARK Tableview delegate and datasource
    override func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 1
    }
    
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell: AddToCartCell = tableView.dequeueReusableCellWithIdentifier(AddToCartCellID, forIndexPath: indexPath) as! AddToCartCell
        
        cell.itemname.text = "PANTS"
        cell.itemdescription.text = "This is a fantastic pants dude!"
        
        
        cell.itemimage.image = defaultimage
        /*cell.itemimage.file = defaultfile
        cell.itemimage.loadInBackground({ (image: UIImage?, error: NSError?) -> Void in
            if error == nil {
                cell.itemimage.image = image
            }
            else {
                println(error?.description)
            }
        })*/

        
        cell.addbutton.addTarget(self, action: "showPopup", forControlEvents: UIControlEvents.TouchUpInside)
        
        
        return cell
    }
    
    override func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        
    }
    
    
    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 5
    }
    
    @IBAction func backbutton(sender: AnyObject) {
        self.navigationController?.popViewControllerAnimated(true)
    }
    
}
