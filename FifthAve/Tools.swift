//
//  Tools.swift
//  FifthAve
//
//  Created by WANG Michael on 14/05/2015.
//  Copyright (c) 2015 emagid. All rights reserved.
//

import Foundation
import UIKit

class Tools {
    class var sharedInstance: Tools {
        struct Static {
            static var instance: Tools?
            static var token: dispatch_once_t = 0
        }
        
        dispatch_once(&Static.token) {
            Static.instance = Tools()
        }
        
        return Static.instance!
    }
    
    func roundImageView(image:UIImageView, borderWitdh: CGFloat)
    {
        image.layer.borderWidth = 0.7
        image.layer.masksToBounds = false
        image.layer.borderColor = imagebordercolor
        image.layer.cornerRadius = image.bounds.size.width / 2
        image.clipsToBounds = true
    }
    
    func roundImageView(image:UIImageView, borderWitdh: CGFloat, cornerRadius: CGFloat)
    {
        image.layer.borderWidth = 0.7
        image.layer.masksToBounds = false
        image.layer.borderColor = imagebordercolor
        image.layer.cornerRadius = cornerRadius
        image.clipsToBounds = true
    }
    
    func roundButton (button: UIButton, borderWidth: CGFloat)
    {
        button.layer.cornerRadius = button.bounds.size.width / 2
        button.layer.borderWidth = 0
        button.layer.borderColor = UIColor.blackColor().CGColor
    }
    
    func diffTime (time: String) -> String
    {
        //Convert the string to a date
        let dateFormatter = NSDateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ss.SSS'Z'"
        let date = dateFormatter.dateFromString(time)
        
        // Get the current date
        let currentime: NSDate = NSDate()
        
        //Make the diff between them
        return (currentime.offsetFrom(date!))
    }
    
    func diff (date: NSDate) -> String{
        // Get the current date
        let currentime: NSDate = NSDate()
        
        //Make the diff between them
        return (currentime.offsetFrom(date))
    }
    
    func priceFormat (price: Double) -> String
    {
        let format = ".2"
        return String(format: "$ %.2f", price)
    }
    
    
    func createpicker(view: UIViewController) -> UIPickerView
    {
        var picker = UIPickerView()
        picker.setTranslatesAutoresizingMaskIntoConstraints(false)
        picker.backgroundColor = UIColor.whiteColor()
        picker.hidden = true
        picker.delegate = view as? UIPickerViewDelegate
        picker.dataSource = view as? UIPickerViewDataSource
        view.view.addSubview(picker)
        
        let views = ["view": view.view, "picker": picker]
        
        view.view.addConstraint(NSLayoutConstraint(item: picker, attribute: .Bottom, relatedBy: .Equal, toItem: view.view, attribute: .Bottom, multiplier: 1, constant: 0))
        view.view.addConstraint(NSLayoutConstraint(item: picker, attribute: .CenterX, relatedBy: .Equal, toItem: view.view, attribute: .CenterX, multiplier: 1, constant: 0))
        view.view.addConstraint(NSLayoutConstraint(item: picker, attribute: .Width, relatedBy: .Equal, toItem: view.view, attribute: .Width, multiplier: 1, constant: 0))
        
        return picker
    }
    
}

extension NSDate {
    func yearsFrom(date:NSDate) -> Int{
        return NSCalendar.currentCalendar().components(NSCalendarUnit.CalendarUnitYear, fromDate: date, toDate: self, options: nil).year
    }
    func monthsFrom(date:NSDate) -> Int{
        return NSCalendar.currentCalendar().components(NSCalendarUnit.CalendarUnitMonth, fromDate: date, toDate: self, options: nil).month
    }
    func weeksFrom(date:NSDate) -> Int{
        return NSCalendar.currentCalendar().components(NSCalendarUnit.CalendarUnitWeekOfYear, fromDate: date, toDate: self, options: nil).weekOfYear
    }
    func daysFrom(date:NSDate) -> Int{
        return NSCalendar.currentCalendar().components(NSCalendarUnit.CalendarUnitDay, fromDate: date, toDate: self, options: nil).day
    }
    func hoursFrom(date:NSDate) -> Int{
        return NSCalendar.currentCalendar().components(NSCalendarUnit.CalendarUnitHour, fromDate: date, toDate: self, options: nil).hour
    }
    func minutesFrom(date:NSDate) -> Int{
        return NSCalendar.currentCalendar().components(NSCalendarUnit.CalendarUnitMinute, fromDate: date, toDate: self, options: nil).minute
    }
    func secondsFrom(date:NSDate) -> Int{
        return NSCalendar.currentCalendar().components(NSCalendarUnit.CalendarUnitSecond, fromDate: date, toDate: self, options: nil).second
    }
    func offsetFrom(date:NSDate) -> String {
        if yearsFrom(date)   > 0 { return "\(yearsFrom(date)) year"   }
        if monthsFrom(date)  > 0 { return "\(monthsFrom(date)) month"  }
        //if weeksFrom(date)   > 0 { return "\(weeksFrom(date)) week"   }
        if daysFrom(date)    > 0 { return "\(daysFrom(date)) day"    }
        if hoursFrom(date)   > 0 { return "\(hoursFrom(date)) hour"   }
        if minutesFrom(date) > 0 { return "\(minutesFrom(date)) min" }
        //if secondsFrom(date) > 0 { return "\(secondsFrom(date)) sec" }
        return "Now"
    }
}