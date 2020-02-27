//
//  GroupResponse.swift
//  Myint Thidar Customer
//
//  Created by Min Htoo Tint Aung on 2/26/20.
//  Copyright © 2020 Nanolabs. All rights reserved.
//

import Foundation

class GroupResponse:Codable{
    init(status:String) {
        self.status=status
    }
    var status:String = ""
}
