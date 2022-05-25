//
//  Extension.swift
//  homeWork_1
//
//  Created by User on 30.09.2018.
//  Copyright © 2018 User. All rights reserved.
//

import UIKit

class Session {
    
    static let instance = Session()
    
    private init(){}
    
    var token = ""
    var userId = 0
}


struct GlobalConstants {
    
    static var titles = [String]()

    static let defaults = UserDefaults.standard
    
    static let vkApi = "https://api.vk.com/method/"

}


//@IBDesignable extension UIView {
extension UIView {
    
    @IBInspectable var shadowColor: UIColor? {
        set {
            layer.shadowColor = newValue!.cgColor
        }
        get {
            if let color = layer.shadowColor {
                return UIColor(cgColor:color)
            }
            else {
                return nil
            }
        }
    }
    
    
    @IBInspectable var shadowOpacity: Float {
        set {
            layer.shadowOpacity = newValue
        }
        get {
            return layer.shadowOpacity
        }
    }
    
    
    @IBInspectable var shadowOffset: CGPoint {
        set {
            layer.shadowOffset = CGSize(width: newValue.x, height: newValue.y)
        }
        get {
            return CGPoint(x: layer.shadowOffset.width, y:layer.shadowOffset.height)
        }
    }
    
    
    @IBInspectable var shadowRadius: CGFloat {
        set {
            layer.shadowRadius = newValue
        }
        get {
            return layer.shadowRadius
        }
    }
    
    
    @IBInspectable var borderColor: UIColor? {
        set {
            layer.borderColor = newValue!.cgColor
        }
        get {
            return nil
        }
    }
    
    
    @IBInspectable var borderWidth: CGFloat {
        set {
            layer.borderWidth = newValue
        }
        get {
            return layer.borderWidth
        }
    }
    
    
    @IBInspectable var cornerRadius: CGFloat {
        set {
            layer.cornerRadius = newValue
        }
        get {
            return layer.cornerRadius
        }
    }
    
}


extension UIColor {
    struct VkColor {
        static let main = UIColor.init(red: 65/255, green: 107/255, blue: 158/255, alpha: 1)
        static let brandBlack = UIColor(red: 0, green: 0, blue: 0, alpha: 0.1)
        static let brandBlue = UIColor(red: 24/255, green: 139/255, blue: 243/255, alpha: 1)
        static let brandWhite = UIColor(red: 238/255, green: 243/255, blue: 251/255, alpha: 1)
        static let brandLightBlue = UIColor(red: 92/255, green: 175/255, blue: 248/255, alpha: 1)
    }
}

extension UIFont {
    struct VkFont {
        static let fontNormal = UIFont(name: "HelveticaNeue", size: 17)
        static let fontSelect = UIFont(name: "HelveticaNeue-Medium", size: 17)
    }
}

extension CGFloat {
    func toRadians() -> CGFloat {
        return self * .pi / 180.0
    }
}


