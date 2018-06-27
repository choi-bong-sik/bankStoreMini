//
//  UIViewExtensions.swift
//  bankStoreMIni
//
//  Created by 최 봉식 on 2018. 6. 27..
//  Copyright © 2018년 jake. All rights reserved.
//

import UIKit

class UIViewExtensions: NSObject {

}

extension UIView {
    @IBInspectable var cornerRadius: CGFloat {
        
        get{
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
            layer.borderColor = borderColor?.cgColor
        }
    }
}
