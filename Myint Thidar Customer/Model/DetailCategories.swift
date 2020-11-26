//
//  DetailCategories.swift
//  Myint Thidar Customer
//
//  Created by Kaung Khant Shar on 22/07/2020.
//  Copyright © 2020 Nanolabs. All rights reserved.
//

import Foundation
import UIKit

class DetailCategories {
    var gold_item_id : String
    var detailcategories_image : String
    var detailcategories_name : String
    var gold_stone_kyat : String
    var gold_stone_pal : String
    var gold_stone_yae : String
    var ayot_kyat : String
    var ayot_pal : String
    var ayot_yae : String
    var stone_kyat : String
    var stone_pal : String
    var stone_yae : String
    var stone_value : String
    var gold_quality : String
    var category_id : String
    var product_id : String
    var type : String = "gold"
    var isselected : Bool = false
    var currentprice : String
    var note : String
    
    
    init(category_id : String, gold_item_id : String,detailcategories_image : String, detailcategories_name : String, gold_stone_kyat : String, gold_stone_pal : String, gold_stone_yae : String, ayot_kyat : String, ayot_pal : String, ayot_yae : String, stone_kyat : String, stone_pal : String, stone_yae : String, stone_value : String, gold_quality : String, product_id :String, type : String, isselected : Bool, currentprice : String, note : String) {
        self.category_id = category_id
        self.gold_item_id = gold_item_id
        self.detailcategories_image = detailcategories_image
        self.detailcategories_name = detailcategories_name
        self.gold_stone_kyat = gold_stone_kyat
        self.gold_stone_pal = gold_stone_pal
        self.gold_stone_yae = gold_stone_yae
        self.ayot_kyat = ayot_kyat
        self.ayot_pal = ayot_pal
        self.ayot_yae = ayot_yae
        self.stone_kyat = stone_kyat
        self.stone_pal = stone_pal
        self.stone_yae = stone_yae
        self.stone_value = stone_value
        self.gold_quality = gold_quality
        self.product_id = product_id
        self.type = type
        self.isselected = isselected
        self.currentprice = currentprice
        self.note = note
    }
}
