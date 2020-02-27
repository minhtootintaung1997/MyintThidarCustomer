//
//  HistoryModel.swift
//  Myint Thidar Customer
//
//  Created by Min Htoo Tint Aung on 2/27/20.
//  Copyright © 2020 Nanolabs. All rights reserved.
//

import Foundation
class HistoryModel {
    init(date:String,salename:String,vn:String,gr:String,qt:String,pe:String) {
        self.date=date
        self.salename=salename
        self.voucherno=vn
        self.gram=gr
        self.quantity=qt
        self.pointeight=pe
    }
    var date:String
    var salename:String
    var voucherno:String
    var gram:String
    var quantity:String
    var pointeight:String

}
