//
//  UIViewExtensions.swift
//  bankStoreMIni
//
//  Created by 최 봉식 on 2018. 6. 27..
//  Copyright © 2018년 jake. All rights reserved.
//

import UIKit

let imageCache = NSCache<NSString, AnyObject>()

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

extension UIImageView {
    func loadImageUsingCache(withUrl urlString : String) {
        let url = URL(string: urlString)
        self.image = nil
        if let mCacheImage = loadMemoyCache(withKey: urlString){
            self.image = mCacheImage
        }else{
            URLSession.shared.dataTask(with: url!, completionHandler: { (data, response, error) in
                if error != nil {
                    print(error!)
                    return
                }
                DispatchQueue.main.async {
                    if let image = UIImage(data: data!) {
                        self.saveMemoyCache(withKey: urlString, withImage: image)
                        self.image = image
                    }
                }
                
            }).resume()
        }
    }
    func loadMemoyCache(withKey key:String) -> UIImage? {
        return imageCache.object(forKey: key as NSString) as? UIImage
    }
    func saveMemoyCache(withKey key:String, withImage image:UIImage) {
        imageCache.setObject(image, forKey: key as NSString)
    }
}
