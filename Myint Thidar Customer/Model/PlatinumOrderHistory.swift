//
//  PlatinumOrderHistory.swift
//  Myint Thidar Customer
//
//  Created by Kaung Khant Shar on 28/09/2020.
//  Copyright © 2020 Nanolabs. All rights reserved.
//

import Foundation
import UIKit

class PlatinumOrderHistory {
    
    var order_id : String
    var price : String
    var qty : String
    var status : String
    var description : String
    var created_at : String
    
    init(order_id : String, price : String, qty : String, status : String, description : String, created_at : String) {
        self.order_id = order_id
        self.price = price
        self.qty = qty
        self.status = status
        self.description = description
        self.created_at = created_at
    }
}
