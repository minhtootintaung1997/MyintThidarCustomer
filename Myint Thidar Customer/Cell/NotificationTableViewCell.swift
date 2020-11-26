//
//  NotificationTableViewCell.swift
//  Myint Thidar Customer
//
//  Created by Min Htoo Tint Aung on 2/25/20.
//  Copyright © 2020 Nanolabs. All rights reserved.
//

import UIKit

class NotificationTableViewCell: UITableViewCell {

    @IBOutlet weak var datelbl: UILabel!
    @IBOutlet weak var titlelabel: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
