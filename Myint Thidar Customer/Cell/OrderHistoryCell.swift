//
//  OrderHistoryCell.swift
//  Myint Thidar Customer
//
//  Created by Kaung Khant Shar on 12/08/2020.
//  Copyright © 2020 Nanolabs. All rights reserved.
//

import UIKit

class OrderHistoryCell: UITableViewCell {

//    @IBOutlet weak var ordered_id: UILabel!
//    @IBOutlet weak var ordered_date: UILabel!
//    @IBOutlet weak var ordered_price: UILabel!
//    @IBOutlet weak var ordered_status: UILabel!
//    @IBOutlet weak var ordered_image: UIImageView!
    
    @IBOutlet weak var ordered_id: UILabel!
    @IBOutlet weak var ordered_date: UILabel!
    @IBOutlet weak var ordered_price: UILabel!
    @IBOutlet weak var ordered_image: UIImageView!
    @IBOutlet weak var ordered_status: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
