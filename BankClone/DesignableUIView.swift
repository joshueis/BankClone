//
//  DesignableUIView.swift
//  BankClone
//
//  Created by Israel Carvajal on 9/20/17.
//  Copyright © 2017 Parse. All rights reserved.
//

import UIKit

@IBDesignable class DesignableImageView: UIView{}
@IBDesignable class DesignableLabel: UILabel {}
@IBDesignable class DesignableTextField: UITextField {
    
    
    //inspectable allows users to change this values in storyboard attribute inspector
    //inspectable require assigned default value
    @IBInspectable
    var placeholderTextColor: UIColor = UIColor.lightGray {
        didSet{
            guard let placeholder = placeholder else{
                return
            }
            attributedPlaceholder = NSAttributedString(string: placeholder, attributes:
                [NSForegroundColorAttributeName: placeholderTextColor])
        }
    }
}
@IBDesignable class DesignableButton: UIButton {}

extension UIView{

    @IBInspectable
    var borderWidth: CGFloat{
        get{
            return layer.borderWidth
        }
        set{
            layer.borderWidth = newValue
        }
    }
    
    @IBInspectable
    var borderColor: UIColor?{
        get{
            return layer.borderColor != nil ? UIColor(cgColor: layer.borderColor!) : nil
        }
        set(newBorderColor){
            layer.borderColor = newBorderColor?.cgColor
        }
    }
    
    @IBInspectable
    var cornerRadius: CGFloat{
        get{
            return layer.cornerRadius
        }
        set{
            layer.cornerRadius = newValue
            layer.masksToBounds = newValue != 0
        }
    }
    
    @IBInspectable
    var makeCircular: Bool? {
        get{
            return nil
        }
        set{
            if let makeCircular = newValue, makeCircular{
                cornerRadius = min(bounds.width, bounds.height) / 2.0
            }
            
        }
    }
    
}
