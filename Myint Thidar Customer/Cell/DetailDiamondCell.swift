//
//  DetailDiamondCell.swift
//  Myint Thidar Customer
//
//  Created by Kaung Khant Shar on 29/07/2020.
//  Copyright © 2020 Nanolabs. All rights reserved.
//

import UIKit

protocol SeemoreDiamondClickAction {
    func wishClick(btn1 : UIButton, btn2 : UIButton)
}
class DetailDiamondCell: UICollectionViewCell {
    
    @IBOutlet weak var diamond_image: UIImageView!
    @IBOutlet weak var diamond_name: UILabel!
    @IBOutlet weak var btn1: UIButton!
    @IBOutlet weak var btn2: UIButton!
  
    
    @IBOutlet weak var eleView: UIView!
    var delegatebtn : SeemoreDiamondClickAction!
    
   
    @IBAction func btn1Action(_ sender: Any) {
    
    delegatebtn.wishClick(btn1: btn1, btn2: btn2)
    }
   
    @IBAction func btn2Action(_ sender: Any) {
    
    delegatebtn.wishClick(btn1: btn1, btn2: btn2)
    }
    
    override func awakeFromNib() {
eleView.layer.cornerRadius = 10.0
           eleView.layer.shadowColor = UIColor.gray.cgColor
           eleView.layer.shadowOffset = CGSize(width: 0.0, height: 0.0)
           eleView.layer.shadowRadius = 6.0
  //  eleView.layer.shadowOpacity = 0.2
           eleView.layer.backgroundColor = UIColor.white.cgColor
        
//        heartView.layer.cornerRadius = 20.0
//              heartView.layer.shadowColor = UIColor.gray.cgColor
//              heartView.layer.shadowOffset = CGSize(width: 0.0, height: 0.0)
//              heartView.layer.shadowRadius = 6.0
//              heartView.layer.shadowOpacity = 2.0
//              heartView.layer.backgroundColor = UIColor.white.cgColor
    }
}
