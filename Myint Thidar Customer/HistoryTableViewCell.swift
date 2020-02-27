//
//  HistoryTableViewCell.swift
//  Myint Thidar Customer
//
//  Created by Min Htoo Tint Aung on 2/27/20.
//  Copyright © 2020 Nanolabs. All rights reserved.
//

import UIKit

class HistoryTableViewCell: UITableViewCell {

    @IBOutlet weak var salenamelb: UILabel!
    @IBOutlet weak var voucherlb: UILabel!
    @IBOutlet weak var quantitylb: UILabel!
    @IBOutlet weak var pointeightlb: UILabel!
  
    @IBOutlet weak var gramlb: UILabel!
    @IBOutlet weak var datelb: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
