//
//  BrandProfilCollectionView.swift
//  5thAve
//
//  Created by WANG Michael on 07/05/2015.
//  Copyright (c) 2015 emagid. All rights reserved.
//

import Foundation
import UIKit

class BrandProfilCollectionView: UICollectionViewController {
    
    let sectionInsets = UIEdgeInsets(top: 5.0, left: 0.0, bottom: 5.0, right: 0.0)
    let spacing: CGFloat = 3.0
    var isCart: Bool = false
    
    var data: [String] = ["", "", ""]
    var selected: [Bool] = [false, false, false]
    
    var brandcontainerVC: BrandCartContainerView?
    
    @IBOutlet var collection: UICollectionView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func collectionView(collectionView: UICollectionView, cellForItemAtIndexPath indexPath: NSIndexPath) -> UICollectionViewCell {
        
        if (isCart)
        {
            let cell: BrandCollectionCellCart = collectionView.dequeueReusableCellWithReuseIdentifier(BrandCollectionCellCartID, forIndexPath: indexPath) as! BrandCollectionCellCart
            cell.itemimage.image = UIImage(named: "EFM_Launch.jpg")
            cell.id = indexPath.row
            cell.delegate = self
            cell.itemprice.text = Tools.sharedInstance.priceFormat(185.0)
            
            if selected[indexPath.row]
            {
                cell.message.hidden = false
                cell.cartbutton.backgroundColor = UIColor.blackColor()
            }
            else
            {
                cell.message.hidden = true
                cell.cartbutton.backgroundColor = AppColor.lightBlueColorApp()
            }
            
            return cell
        }
        else
        {
            let cell: BrandCollectionImage = collectionView.dequeueReusableCellWithReuseIdentifier(BrandCollectionImageID, forIndexPath: indexPath) as! BrandCollectionImage
            cell.postimage.image = UIImage(named: "EFM_Launch.jpg")
            
            return cell
        }
    }
    
    
    func showDetail()
    {
        brandcontainerVC = storyboard?.instantiateViewControllerWithIdentifier("BrandCartContainerView") as? BrandCartContainerView
        brandcontainerVC!.view.frame = self.view.bounds
        
        addChildViewController(brandcontainerVC!)
        self.view.addSubview(brandcontainerVC!.view)
        brandcontainerVC!.itemimage.image = UIImage(named: "EFM_Launch.jpg")
        brandcontainerVC!.itemname.text = "SLIM JEANS"
        brandcontainerVC!.itemmodel.text = "Model 4242"
        brandcontainerVC!.itemprice.text = Tools.sharedInstance.priceFormat(130.0)
        
        brandcontainerVC!.CloseButton.addTarget(self, action: "doneButtonTapped", forControlEvents: .TouchUpInside)
        brandcontainerVC!.didMoveToParentViewController(self)
    }
    
    func doneButtonTapped () {
        
        brandcontainerVC!.removeFromParentViewController()
        brandcontainerVC!.view.removeFromSuperview()
    }
    
    override func collectionView(collectionView: UICollectionView, didSelectItemAtIndexPath indexPath: NSIndexPath) {
        if !selected[indexPath.row] && isCart
        {
            self.showDetail()
        }
    }
    
    
    override func collectionView(collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return data.count
    }
    
    
    
    
    //Flow Collection
    func collectionView(collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAtIndexPath indexPath: NSIndexPath) -> CGSize {
        
        var cellwidth = (self.view.bounds.size.width - 3 * spacing) / 3
        
        if isCart
        {
            var cellwidth = (self.view.bounds.size.width - 2 * spacing) / 2
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
    
}