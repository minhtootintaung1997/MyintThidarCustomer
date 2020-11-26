//
//  DetailDiamondCategories.swift
//  Myint Thidar Customer
//
//  Created by Kaung Khant Shar on 29/07/2020.
//  Copyright © 2020 Nanolabs. All rights reserved.
//

import Foundation
import UIKit

class DetailDiamondCategories {
    
    var diamond_item_id : String
    var image : String
    var item_code : String
    var price : String
    var gram : String
    var quality : String
    var diamond_quality : String
    var category_id : String
    var product_id : String
    var type : String = "diamond"
    var isselected : Bool = false
    var diamond_kyat : String
    var diamond_pal : String
    var diamond_yae : String
    var diamond_number : String
    var diamond_alone : String
    
    
    init(diamond_item_id : String, image : String, item_code : String, price : String, gram : String, quality : String, diamond_quality : String, category_id : String, product_id : String, type : String, isselected : Bool, diamond_kyat : String, diamond_pal : String, diamond_yae : String, diamond_number : String, diamond_alone : String) {
        self.diamond_item_id = diamond_item_id
        self.image = image
        self.item_code = item_code
        self.price = price
        self.gram = gram
        self.quality = quality
        self.diamond_quality = diamond_quality
        self.category_id = category_id
        self.product_id = product_id
        self.type = type
        self.isselected = isselected
        self.diamond_kyat = diamond_kyat
        self.diamond_pal = diamond_pal
        self.diamond_yae = diamond_yae
        self.diamond_number = diamond_number
        self.diamond_alone = diamond_alone
    }
}
