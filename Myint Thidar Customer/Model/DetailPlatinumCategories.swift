//
//  DetailPlatinumCategories.swift
//  Myint Thidar Customer
//
//  Created by Kaung Khant Shar on 30/07/2020.
//  Copyright © 2020 Nanolabs. All rights reserved.
//

import Foundation
import UIKit

class DetailPlatinumCategories {
    
    var platinum_item_id : String
    var image : String
    var item_code : String
    var price : String
    var gram : String
    var sale_price : String
    var quality : String
    var platinum_quality : String
    var category_id : String
    var product_id : String = ""
    var type : String = "platinum"
    var isselected : Bool = false
    var note : String = ""
    
    init(platinum_item_id : String, image : String, item_code : String, price : String, gram : String, sale_price : String, quality : String, platinum_quality : String, category_id : String, product_id : String, type : String, isselected : Bool, note : String) {
        
        self.platinum_item_id = platinum_item_id
        self.image = image
        self.item_code = item_code
        self.price = price
        self.gram = gram
        self.sale_price = sale_price
        self.quality = quality
        self.platinum_quality = platinum_quality
        self.category_id = category_id
        self.product_id = product_id
        self.type = type
        self.isselected = isselected
        self.note = note
    }
    
}
