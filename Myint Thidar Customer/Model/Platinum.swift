//
//  Platinum.swift
//  Myint Thidar Customer
//
//  Created by Kaung Khant Shar on 21/07/2020.
//  Copyright © 2020 Nanolabs. All rights reserved.
//

import Foundation
import UIKit

class Platinum {
    var platinum_image : String
    var platinum_name : String
    var platinumProduct : [DetailPlatinumCategories]
    init(platinum_image : String, platinum_name : String,platinumProduct : [DetailPlatinumCategories]) {
        self.platinum_image = platinum_image
        self.platinum_name = platinum_name
        self.platinumProduct = platinumProduct
    }
}
