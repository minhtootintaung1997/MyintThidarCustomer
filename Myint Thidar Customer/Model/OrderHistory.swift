//
//  OrderHistory.swift
//  Myint Thidar Customer
//
//  Created by Kaung Khant Shar on 12/08/2020.
//  Copyright © 2020 Nanolabs. All rights reserved.
//

import Foundation
import UIKit

class OrderHistory {
   var ordered_image : String
   var ordered_id : String
   var ordered_date : String
   var ordered_price : String
   var ordered_status : String
    var goldorder_type : String
    var item_code : String
    var gold_kyat : String
    var gold_pal : String
    var gold_yae : String
    var ayot_kyat : String
    var ayot_pal : String
    var ayot_yae : String
    var stone_kyat : String
    var stone_pal : String
    var stone_yae : String
    var stone_value : String
    var gold_quality : String
    var currentSalePrice : String
    var qty : String
    var note : String
    var description : String
    var gold_stone_kyat : String
    var gold_stone_pal : String
    var gold_stone_yae : String
    
    
    var diamond_quality : String
    var diamond_kyat : String
    var diamond_pal : String
    var diamond_yae : String
    var diamond_number : String
    var yati : String
    var diamond_alone : String
    var price : String
    var current_price : String
    var gram : String
    var platinum_quality : String

    
    init(ordered_image : String, ordered_id : String, ordered_date : String, ordered_price : String, ordered_status : String, goldorder_type : String,item_code : String, gold_kyat : String, gold_pal : String,gold_yae : String, ayot_kyat : String, ayot_pal : String, ayot_yae : String, stone_kyat : String, stone_pal : String, stone_yae : String, stone_value : String, gold_quality : String, currentSalePrice : String, qty : String, note : String, description : String, gold_stone_kyat : String, gold_stone_pal : String, gold_stone_yae : String, diamond_quality : String, diamond_kyat : String, diamond_pal : String, diamond_yae : String, diamond_number : String, yati : String, diamond_alone : String, price : String, current_price : String, gram : String, platinum_quality : String) {
        self.ordered_image = ordered_image
        self.ordered_id = ordered_id
        self.ordered_date = ordered_date
        self.ordered_price = ordered_price
        self.ordered_status = ordered_status
        self.goldorder_type = goldorder_type
        self.item_code = item_code
        self.gold_kyat = gold_kyat
        self.gold_pal = gold_pal
        self.gold_yae = gold_yae
        self.ayot_kyat = ayot_kyat
        self.ayot_pal = ayot_pal
        self.ayot_yae = ayot_yae
        self.stone_kyat = stone_kyat
        self.stone_pal = stone_pal
        self.stone_yae = stone_yae
        self.stone_value = stone_value
        self.gold_quality = gold_quality
        self.currentSalePrice = currentSalePrice
        self.qty = qty
        self.note = note
        self.description = description
        self.gold_stone_kyat = gold_stone_kyat
        self.gold_stone_pal = gold_stone_pal
        self.gold_stone_yae = gold_stone_yae
        
        self.diamond_quality = diamond_quality
        self.diamond_kyat = diamond_kyat
        self.diamond_pal = diamond_pal
        self.diamond_yae = diamond_yae
        self.diamond_number = diamond_number
        self.yati = yati
        self.diamond_alone = diamond_alone
        self.price = price
        self.current_price = current_price
        
        self.gram = gram
        self.platinum_quality = platinum_quality
    }
}
