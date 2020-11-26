//
//  AddtobasketGold.swift
//  Myint Thidar Customer
//
//  Created by Kaung Khant Shar on 31/07/2020.
//  Copyright © 2020 Nanolabs. All rights reserved.
//

import Foundation
import UIKit

class AddtobasketGold {
    
    var id : Int = 0
    var gold_item_id : Int
    var image : String
    var itemCode : String
    var  category_id : Int
    var quantity : String
    var total_price : Double
    var qty : Int
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
    var currentSalePrice : String
    var order_type : String
    var realtotal_price : Double
    
    init(id : Int, gold_item_id : Int, image : String, itemCode : String, category_id : Int, quantity : String, total_price : Double, qty : Int, gold_stone_kyat : String, gold_stone_pal : String, gold_stone_yae : String, ayot_kyat : String, ayot_pal : String, ayot_yae : String, stone_kyat : String, stone_pal : String, stone_yae : String, stone_value : String, currentSalePrice : String, order_type : String, realtotal_price : Double) {
       
        self.id = id
        self.gold_item_id = gold_item_id
        self.image = image
        self.itemCode = itemCode
        self.category_id = category_id
        self.quantity = quantity
        self.total_price = total_price
        self.qty = qty
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
        self.currentSalePrice = currentSalePrice
        self.order_type = order_type
        self.realtotal_price = realtotal_price
    }
    
    
    
}
