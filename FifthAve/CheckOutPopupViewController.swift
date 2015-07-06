//
//  CheckOutPopupViewController.swift
//  5thAve
//
//  Created by WANG Michael on 11/05/2015.
//  Copyright (c) 2015 emagid. All rights reserved.
//

import Foundation
import UIKit

class CheckOutPopupViewController: UIViewController {
    
    var delegate: ShoppingStep?
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    @IBAction func confirm(sender: AnyObject) {
        self.delegate?.RemovePopup()
    }
    
    @IBAction func cancel(sender: AnyObject) {
        self.delegate?.RemovePopup()
    }
}