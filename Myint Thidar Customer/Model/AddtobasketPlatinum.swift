//
//  AddtobasketPlatinum.swift
//  Myint Thidar Customer
//
//  Created by Kaung Khant Shar on 10/08/2020.
//  Copyright © 2020 Nanolabs. All rights reserved.
//

import Foundation
import UIKit

class AddtobasketPlatinum {
    var id : Int = 0
    var platinum_item_id : Int = 0
    var category_id : Int
    var itemCode : String
    var price : Double
    var total_price : Double
    var gram : Double
    var quality :String
    var image : String
    var qty : Int
    
    init(id : Int, platinum_item_id : Int, category_id : Int, itemCode : String, price : Double, total_price : Double, gram : Double, quality : String, image : String, qty : Int) {
        self.id = id
        self.platinum_item_id = platinum_item_id
        self.category_id = category_id
        self.itemCode = itemCode
        self.price = price
        self.total_price = total_price
        self.gram = gram
        self.quality = quality
        self.image = image
        self.qty = qty
    }
    
}
