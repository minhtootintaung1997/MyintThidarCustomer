//
//  NotificationModel.swift
//  Myint Thidar Customer
//
//  Created by Min Htoo Tint Aung on 2/25/20.
//  Copyright © 2020 Nanolabs. All rights reserved.
//

import UIKit
class NotificationModel {
    var title:String = ""
    var date:String = ""
    var noti_one:String=""
    
    
    init(title:String,date:String,noti:String) {
        self.title=title
        self.noti_one=noti
        self.date=date
    }
}
