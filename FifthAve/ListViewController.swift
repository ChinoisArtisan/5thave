//
//  ListViewController.swift
//  5thAve
//
//  Created by WANG Michael on 05/05/2015.
//  Copyright (c) 2015 emagid. All rights reserved.
//

import Foundation
import UIKit


enum typeOfCell
{
    case delete
    case texte
    case image
}

protocol listprotocol
{
    func deletecellwithid(id:Int)
}

class ListViewController: UIViewController, UICollectionViewDataSource, UICollectionViewDelegate, UICollectionViewDelegateFlowLayout, listprotocol{
    
    @IBOutlet weak var itemcollection: UICollectionView!
    @IBOutlet weak var privateswitch: UISwitch!
    @IBOutlet weak var privacyheigth: NSLayoutConstraint!
    @IBOutlet weak var listStatusLabel: UILabel!
    
    
    var isMyAccount : Bool = true
    var isPrivate: Bool = true
    
    var celltype: typeOfCell = .delete
    var navtitle: String = ""
    var data: [String] = ["", "", "", "", ""]
    let sectionInsets = UIEdgeInsets(top: 10.0, left: 0.0, bottom: 0.0, right: 0.0)
    let spacing: CGFloat = 3.0
    
    
    var brandcontainerVC: BrandCartContainerView?
    
    var id: Int = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        if (!isMyAccount) {
            privacyheigth.constant = 0
            listStatusLabel.hidden = true
            privateswitch.hidden = true
        }
        privateswitch.on = self.isPrivate
        changeStatus()
    }
    
    override func viewWillDisappear(animated: Bool) {
        super.viewWillDisappear(animated)
    }
    
    override func viewDidAppear(animated: Bool) {
        super.viewDidAppear(animated)
        createpop()
    }
    
    @IBAction func changeListStatus(sender: AnyObject) {
        changeStatus()
    }
    
    func changeStatus ()
    {
        if privateswitch.on
        {
            listStatusLabel.text = "PUBLIC LIST"
        }
        else
        {
            listStatusLabel.text = "PRIVATE LIST"
        }
    }
    
    func setNavBarTitle(title:String)
    {
        let tmplabel = UILabel()
        tmplabel.text = title
        tmplabel.font = UIFont(name: "Montserrat-Bold", size: 20)
        tmplabel.textColor = UIColor.whiteColor()
        tmplabel.backgroundColor = UIColor.clearColor()
        
        self.navigationItem.titleView = tmplabel
        tmplabel.sizeToFit()
    }
    
    func collectionView(collectionView: UICollectionView, cellForItemAtIndexPath indexPath: NSIndexPath) -> UICollectionViewCell {
        
        if (self.celltype == .delete)
        {
            let cell: CollectionCellCanDelete = collectionView.dequeueReusableCellWithReuseIdentifier(CollectionCellCanDeleteID, forIndexPath: indexPath) as! CollectionCellCanDelete
            
            //Complete the data in the cell
            cell.cellimage.image = UIImage(named: "EFM_Launch.jpg")
            cell.cellprice.text = Tools.sharedInstance.priceFormat(10.0)
            
            cell.cellid = indexPath.row
            cell.delegate = self
            
            return cell
        }
        else if (self.celltype == .texte)
        {
            let cell: CollectionCellWithPrice = collectionView.dequeueReusableCellWithReuseIdentifier(CollectionCellWithPriceID, forIndexPath: indexPath) as! CollectionCellWithPrice
            
            //Complete the data in the cell
            cell.cellimage.image = UIImage(named: "EFM_Launch.jpg")
            cell.cellname.text = "SLIM FIT PANTS"
            cell.cellprice.text = Tools.sharedInstance.priceFormat(10.0)
            
            
            return cell
        }
        else
        {
            let cell: CollectionCellOnlyImage = collectionView.dequeueReusableCellWithReuseIdentifier(CollectionCellOnlyImageID, forIndexPath: indexPath) as! CollectionCellOnlyImage
            
            //Complete the data in the cell
            cell.cellimage.image = UIImage(named: "EFM_Launch.jpg")
            
            
            return cell
        }
    }
    
    
    func collectionView(collectionView: UICollectionView, didSelectItemAtIndexPath indexPath: NSIndexPath) {
        if celltype == .delete
        {
            id = indexPath.row
            showPopup()
        }
    }
    
    
    func collectionView(collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return data.count
    }
    
    
    
    
    //Flow Collection
    func collectionView(collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAtIndexPath indexPath: NSIndexPath) -> CGSize {
        
        var cellwidth = (self.itemcollection.bounds.size.width - 3 * spacing) / 3
        
        if celltype == .image
        {
            var cellwidth = (self.itemcollection.bounds.size.width - 2 * spacing) / 2
        }
        
        return CGSize(width:cellwidth , height: cellwidth)
    }
    
    func collectionView(collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAtIndex section: Int) -> UIEdgeInsets {
        return sectionInsets
    }
    
    func collectionView(collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAtIndex section: Int) -> CGFloat {
        return spacing
    }
    
    func collectionView(collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAtIndex section: Int) -> CGFloat {
        return spacing
    }
    
    override func touchesBegan(touches: Set<NSObject>, withEvent event: UIEvent) {
        brandcontainerVC!.removeFromParentViewController()
        brandcontainerVC!.view.removeFromSuperview()
    }
    
    //listprotocol
    func deletecellwithid(id:Int)
    {
        self.data.removeAtIndex(id)
        self.itemcollection.reloadData()
    }
    
    @IBAction func backPushed(sender: AnyObject) {
        self.navigationController?.popViewControllerAnimated(true)
    }
    
    
    // MARK - Popup Cart
    
    func createpop()
    {
        brandcontainerVC = storyboard?.instantiateViewControllerWithIdentifier("BrandCartContainerView") as? BrandCartContainerView
        brandcontainerVC!.view.frame = self.view.bounds
        brandcontainerVC!.wishenable = false
    }
    
    func showPopup()
    {
        addChildViewController(brandcontainerVC!)
        self.view.addSubview(brandcontainerVC!.view)
        brandcontainerVC!.itemimage.image = UIImage(named: "EFM_Launch.jpg")
        brandcontainerVC!.itemname.text = "SLIM JEANS"
        brandcontainerVC!.itemmodel.text = "Model 4242"
        brandcontainerVC!.itemprice.text = Tools.sharedInstance.priceFormat(49.0)
        
        
        brandcontainerVC!.CloseButton.addTarget(self, action: "doneButtonTapped", forControlEvents: .TouchUpInside)
        brandcontainerVC!.didMoveToParentViewController(self)
    }
    
    
    func doneButtonTapped () {
        deletecellwithid(self.id)
        brandcontainerVC!.removeFromParentViewController()
        brandcontainerVC!.view.removeFromSuperview()
    }
    
}