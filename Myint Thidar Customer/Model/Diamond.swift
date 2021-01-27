//
//  Diamond.swift
//  Myint Thidar Customer
//
//  Created by Kaung Khant Shar on 21/07/2020.
//  Copyright © 2020 Nanolabs. All rights reserved.
//

import Foundation
import UIKit

class Diamond {
    var diamond_image : String
    var diamond_name : String
    var diamondproduct:[DetailDiamondCategories]=[]
    
    init(diamond_image : String, diamond_name : String, diamondproduct:[DetailDiamondCategories]) {
        self.diamond_image = diamond_image
        self.diamond_name = diamond_name
        self.diamondproduct = diamondproduct
    }
}
