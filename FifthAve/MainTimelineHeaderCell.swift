//
//  MainTimelineHeaderCell.swift
//  5thAve
//
//  Created by WANG Michael on 29/04/2015.
//  Copyright (c) 2015 Beyond 2021. All rights reserved.
//

import Foundation
import UIKit


class MainTimelineHeaderCell: UITableViewCell
{
    @IBOutlet weak var ProfilPicture: PFImageView!
    @IBOutlet weak var Username: UILabel!
    @IBOutlet weak var PostTime: UILabel!
    
    
    var delegate: TimelineTableViewController?
    var index: Int = 0
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        if let recognizers = self.Username.gestureRecognizers {
            for recognizer in recognizers {
                self.Username.removeGestureRecognizer(recognizer as! UIGestureRecognizer)
            }
        }
        if let recognizers = self.ProfilPicture.gestureRecognizers {
            for recognizer in recognizers {
                self.ProfilPicture.removeGestureRecognizer(recognizer as! UIGestureRecognizer)
            }
        }
        
        
        var tapname: UITapGestureRecognizer?
        var tapprofilpicture: UITapGestureRecognizer?
        tapname = UITapGestureRecognizer(target: self, action: "tapActionProfil:")
        tapprofilpicture = UITapGestureRecognizer(target: self, action: "tapActionProfil:")
        self.Username.addGestureRecognizer(tapname!)
        self.ProfilPicture.addGestureRecognizer(tapprofilpicture!)
        
        
        
        self.Username.userInteractionEnabled = true
        self.ProfilPicture.userInteractionEnabled = true
    }
    
    
    // UIGEsture Control
    func tapActionProfil(sender:UITapGestureRecognizer)
    {
        self.delegate?.showProfile(index)
        
    }
    
    
    
}