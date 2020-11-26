//
//  OrderlistCell.swift
//  Myint Thidar Customer
//
//  Created by Kaung Khant Shar on 21/08/2020.
//  Copyright © 2020 Nanolabs. All rights reserved.
//

import UIKit

class OrderlistCell: UITableViewCell {

    @IBOutlet weak var date: UILabel!
    @IBOutlet weak var user_group: UILabel!
    @IBOutlet weak var voucher_no: UILabel!
    @IBOutlet weak var gram: UILabel!
    @IBOutlet weak var quantity: UILabel!
    @IBOutlet weak var point_eight: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
