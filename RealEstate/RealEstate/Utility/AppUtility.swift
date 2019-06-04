//
//  AppUtility.swift
//  RealEstate
//
//  Created by ashish on 6/4/19.
//  Copyright © 2019 Technical. All rights reserved.
//

import UIKit
import RealmSwift

class AppUtility: NSObject
{
    class var sharedInstance: AppUtility
    {
        struct Static
        {
            static let instance : AppUtility = AppUtility()
        }
        return Static.instance
    }
    
    lazy var realmInstance:Realm = {
        return try! Realm()
    }()
    
}

//@IBDesignable extension UIView {
//    @IBInspectable var ImageBorderColor:UIColor? {
//        set {
//            layer.borderColor = newValue!.cgColor
//        }
//        get {
//            if let color = layer.borderColor {
//                return UIColor(cgColor: color)
//            }
//            else {
//                return nil
//            }
//        }
//    }
//    @IBInspectable var ImageBorderWidth:CGFloat {
//        set {
//            layer.borderWidth = newValue
//        }
//        get {
//            return layer.borderWidth
//        }
//    }
//    @IBInspectable var ImageCornerRadius:CGFloat {
//        set {
//            layer.cornerRadius = newValue
//            clipsToBounds = newValue > 0
//        }
//        get {
//            return layer.cornerRadius
//        }
//    }
//}

extension UIView {
    
    @IBInspectable var cornerRadius: CGFloat {
        get {
            return layer.cornerRadius
        }
        set {
            layer.cornerRadius = newValue
            layer.masksToBounds = newValue > 0
        }
    }
    
    @IBInspectable var borderWidth: CGFloat {
        get {
            return layer.borderWidth
        }
        set {
            layer.borderWidth = newValue
        }
    }
    
    @IBInspectable var borderColor: UIColor? {
        get {
            return UIColor(cgColor: layer.borderColor!)
        }
        set {
            layer.borderColor = newValue?.cgColor
        }
    }
    
    @IBInspectable
    var shadowRadius: CGFloat {
        get {
            return layer.shadowRadius
        }
        set {
            layer.shadowRadius = newValue
        }
    }
    
    @IBInspectable
    var shadowOpacity: Float {
        get {
            return layer.shadowOpacity
        }
        set {
            layer.shadowOpacity = newValue
        }
    }
    
    @IBInspectable
    var shadowOffset: CGSize {
        get {
            return layer.shadowOffset
        }
        set {
            layer.shadowOffset = newValue
        }
    }
    
    @IBInspectable
    var shadowColor: UIColor? {
        get {
            if let color = layer.shadowColor {
                return UIColor(cgColor: color)
            }
            return nil
        }
        set {
            if let color = newValue {
                layer.shadowColor = color.cgColor
            } else {
                layer.shadowColor = nil
            }
        }
    }
}

