//
//  Orderlist.swift
//  Myint Thidar Customer
//
//  Created by Kaung Khant Shar on 21/08/2020.
//  Copyright © 2020 Nanolabs. All rights reserved.
//

import Foundation
import UIKit

class Orderlist {
      var sale_user_name : String
      var gram : String
      var point_eight : String
      var sale_date : String
      var voucher_number : String
      var total_quantity : String
      
      init(sale_user_name : String, gram : String, point_eight : String, sale_date : String, voucher_number : String, total_quantity : String) {
          self.sale_user_name = sale_user_name
          self.gram = gram
          self.point_eight = point_eight
          self.sale_date = sale_date
          self.voucher_number = voucher_number
          self.total_quantity = total_quantity
      }
}
