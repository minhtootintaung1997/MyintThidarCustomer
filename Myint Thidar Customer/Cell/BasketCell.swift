//
//  BasketCell.swift
//  Myint Thidar Customer
//
//  Created by Kaung Khant Shar on 30/07/2020.
//  Copyright © 2020 Nanolabs. All rights reserved.
//

import UIKit

protocol DeleteCard {
    func deletecard(uibtn : UIButton)
}

protocol CounterDelegatePlus {
    func sendCountPlus(uibtn : UIButton)
   
}

protocol CounterDelegateMinus {
    func sendCountMinus(uibtn : UIButton)
}

class BasketCell: UITableViewCell {

    @IBOutlet weak var item_image: UIImageView!
    @IBOutlet weak var item_code: UILabel!
    @IBOutlet weak var type: UILabel!
    @IBOutlet weak var shwe_yi: UILabel!
    @IBOutlet weak var price: UILabel!
    @IBOutlet weak var plus: UIButton!
    @IBOutlet weak var count: UILabel!
    @IBOutlet weak var minus: UIButton!
    @IBOutlet weak var deletecard: UIButton!
    @IBOutlet weak var eleView: UIView!
    var delegatePlus : CounterDelegatePlus?
    var delegateminus : CounterDelegateMinus?
    var deletedelegate : DeleteCard?
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        eleView.layer.cornerRadius = 10.0
                 eleView.layer.shadowColor = UIColor.gray.cgColor
                 eleView.layer.shadowOffset = CGSize(width: 0.0, height: 0.0)
                 eleView.layer.shadowRadius = 6.0
        eleView.layer.shadowOpacity = 0.2
                 eleView.layer.backgroundColor = UIColor.white.cgColor
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    @IBAction func plusAction(_ sender: Any) {
        delegatePlus?.sendCountPlus(uibtn: plus)
        print("plus")
    }
    
    @IBAction func minusAction(_ sender: Any) {
        delegateminus?.sendCountMinus(uibtn: minus)
        print("minus")
    }
    @IBAction func deleteAction(_ sender: Any) {
        deletedelegate?.deletecard(uibtn: deletecard)
    }
    

}
