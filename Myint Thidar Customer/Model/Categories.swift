//
//  Categories.swift
//  Myint Thidar Customer
//
//  Created by Kaung Khant Shar on 17/07/2020.
//  Copyright © 2020 Nanolabs. All rights reserved.
//

import Foundation
import UIKit

class Categories {
    
    var category_image : String
    var category_name : String
     var product:[DetailCategories]=[]
   
    
    init(category_image : String, category_name : String,product:[DetailCategories]) {
        self.category_image = category_image
        self.category_name = category_name
        self.product = product
       
        
        
    }
}
