//
//  PlatinumBasket.swift
//  Myint Thidar Customer
//
//  Created by Kaung Khant Shar on 07/08/2020.
//  Copyright © 2020 Nanolabs. All rights reserved.
//

import Foundation
import UIKit

class PlatinumBasket {
    
    var image : String
       var item_code : String
       var type : String
       var shwe_yi : String
       var price : String
       
       init(image : String, item_code : String, type : String, shwe_yi : String, price : String) {
           self.image = image
           self.item_code = item_code
           self.type = type
           self.shwe_yi = shwe_yi
           self.price = price
       }
}
