//
//  CardviewCustom.swift
//  Myint Thidar Customer
//
//  Created by Min Htoo Tint Aung on 3/6/20.
//  Copyright © 2020 Nanolabs. All rights reserved.
//

import UIKit

class CardviewCustom: UIView {

    var cornnerRadius : CGFloat = 5
    var shadowOfSetWidth : CGFloat = 0
    var shadowOfSetHeight : CGFloat = 1
    
    var shadowColour : UIColor = UIColor.gray
    var shadowOpacity : CGFloat = 0.3
    
    override func layoutSubviews() {
        layer.cornerRadius = cornnerRadius
        layer.shadowColor = shadowColour.cgColor
        layer.shadowOffset = CGSize(width: shadowOfSetWidth, height: shadowOfSetHeight)
        let shadowPath = UIBezierPath(roundedRect: bounds, cornerRadius: cornnerRadius)
        layer.shadowPath = shadowPath.cgPath
        layer.shadowOpacity = Float(shadowOpacity)
    }

}
