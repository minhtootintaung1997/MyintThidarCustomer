//
//  WishlistCell.swift
//  Myint Thidar Customer
//
//  Created by Kaung Khant Shar on 17/07/2020.
//  Copyright © 2020 Nanolabs. All rights reserved.
//

import UIKit
protocol WishRemoveAction {
    func wishremoveClick(btn2 : UIButton)
}
class WishlistCell: UICollectionViewCell {
    
    @IBOutlet weak var wish_image: UIImageView!
    @IBOutlet weak var wish_itemcode: UILabel!
    @IBOutlet weak var wish_type: UILabel!
    @IBOutlet weak var wish_price: UILabel!
    @IBOutlet weak var deletewishlistbtn: UIButton!
    
   
    var delegatebtnremove : WishRemoveAction!
   
   
    @IBAction func deleteAction(_ sender: Any) {
    
    delegatebtnremove.wishremoveClick(btn2: deletewishlistbtn)
    }
    @IBOutlet weak var eleView: UIView!
    
    override func awakeFromNib() {
        eleView.layer.cornerRadius = 10.0
        eleView.layer.shadowColor = UIColor.gray.cgColor
        eleView.layer.shadowOffset = CGSize(width: 0.0, height: 0.0)
        eleView.layer.shadowRadius = 6.0
        eleView.layer.shadowOpacity = 2.0
        eleView.layer.backgroundColor = UIColor.white.cgColor
        
    }
    
}
