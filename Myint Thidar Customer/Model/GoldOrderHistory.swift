//
//  GoldOrderHistory.swift
//  Myint Thidar Customer
//
//  Created by Kaung Khant Shar on 28/09/2020.
//  Copyright © 2020 Nanolabs. All rights reserved.
//

import Foundation
import UIKit

class GoldOrderHistory {
    
    var order_id : String
    var total_price : String
    var qty : String
    var current_price  : String
    var status : String
    var description : String
    
    var image : String
    var item_code : String
    var gram : String
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
    var note : String
    var created_at : String
    
    init(order_id : String, total_price : String, qty : String, current_price : String, status : String, description : String, image : String, item_code : String, gram : String, gold_kyat : String, gold_pal : String, gold_yae : String, ayot_kyat : String, ayot_pal : String, ayot_yae : String, stone_kyat : String, stone_pal : String, stone_yae : String, stone_value : String, gold_quality : String, note : String, created_at : String) {
        self.order_id = order_id
        self.total_price = total_price
        self.qty = qty
        self.current_price = current_price
        self.status = status
        self.description = description
        self.image = image
        self.item_code = item_code
        self.gram = gram
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
        self.note = note
        self.created_at = created_at
    }
    
}
