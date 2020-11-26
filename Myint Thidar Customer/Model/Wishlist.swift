//
//  Wishlist.swift
//  Myint Thidar Customer
//
//  Created by Kaung Khant Shar on 17/07/2020.
//  Copyright © 2020 Nanolabs. All rights reserved.
//

import Foundation
import UIKit

class Wishlist {
    var product_id : String
    var type : String 
    var newarrival_image : String
      var newarrival_name : String
      var newarrival_type : String
      var newarrival_price : String
    var product_type : String
      
    init(product_id : String, type : String, newarrival_image : String, newarrival_name : String, newarrival_type : String, newarrival_price : String, product_type : String) {
        self.product_id = product_id
        self.type = type
          self.newarrival_image = newarrival_image
          self.newarrival_name = newarrival_name
          self.newarrival_type = newarrival_type
          self.newarrival_price = newarrival_price
        self.product_type = product_type
      }
}
