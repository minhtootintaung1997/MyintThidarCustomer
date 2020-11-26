//
//  AddtobasketDiamond.swift
//  Myint Thidar Customer
//
//  Created by Kaung Khant Shar on 10/08/2020.
//  Copyright © 2020 Nanolabs. All rights reserved.
//

import Foundation
import UIKit

class AddtobasketDiamond {
    var id : Int = 0
    var diamond_item_id : Int = 0
    var category_id : Int
    var itemCode : String
    var price : Double
    var total_price : Double
    var gram : Double
    var quality :String
    var image : String
    var qty : Int
    var diamond_alone : String
    var diamond_number : String
    var yati : String
    
    init(id : Int, diamond_item_id : Int, category_id : Int, itemCode : String, price : Double, total_price : Double, gram : Double, quality : String, image : String, qty : Int, diamond_alone : String, diamond_number : String, yati : String) {
        self.id = id
        self.diamond_item_id = diamond_item_id
        self.category_id = category_id
        self.itemCode = itemCode
        self.price = price
        self.total_price = total_price
        self.gram = gram
        self.quality = quality
        self.image = image
        self.qty = qty
        self.diamond_alone = diamond_alone
        self.diamond_number = diamond_number
        self.yati = yati
    }
}
