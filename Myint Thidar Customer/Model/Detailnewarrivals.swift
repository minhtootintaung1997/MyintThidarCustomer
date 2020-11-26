//
//  Detailnewarrivals.swift
//  Myint Thidar Customer
//
//  Created by Kaung Khant Shar on 16/08/2020.
//  Copyright © 2020 Nanolabs. All rights reserved.
//

import Foundation
import UIKit

class Detailnewarrivals {
       var newarrival_image : String  
       var item_code : String
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
       var qty : String
       var gold_quality : String
       var item_type : String
       var isselected : Bool = false
       var product_id : String = ""
       var type : String = ""
       
       init(newarrival_image : String, item_code : String, gold_stone_kyat : String,gold_stone_pal : String, gold_stone_yae : String, ayot_kyat : String, ayot_pal : String, ayot_yae : String, stone_kyat : String, stone_pal : String, stone_yae : String,stone_value : String, qty : String, gold_quality : String, item_type : String, isselected : Bool, product_id : String, type : String) {
           self.newarrival_image = newarrival_image
           self.item_code = item_code
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
           self.qty = qty
           self.gold_quality = gold_quality
           self.item_type = item_type
           self.isselected = isselected
           self.product_id = product_id
           self.type = type
          
       }
}
