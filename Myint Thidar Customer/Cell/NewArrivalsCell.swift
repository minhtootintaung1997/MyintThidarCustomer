//
//  NewArrivalsCell.swift
//  Myint Thidar Customer
//
//  Created by Kaung Khant Shar on 17/07/2020.
//  Copyright © 2020 Nanolabs. All rights reserved.
//

import UIKit

protocol SeemoreNewarrivalClickAction {
    func wishClick(btn1 : UIButton, btn2 : UIButton)
}
class NewArrivalsCell: UICollectionViewCell {
    
    @IBOutlet weak var newarrival_image: UIImageView!
    @IBOutlet weak var newarrival_name: UILabel!
    @IBOutlet weak var newarrival_type: UILabel!
  
    @IBOutlet weak var btn1: UIButton!
    @IBOutlet weak var btn2: UIButton!
    
     var delegatebtn : SeemoreNewarrivalClickAction!
    
  
    @IBAction func btn1Action(_ sender: Any) {
    
    delegatebtn.wishClick(btn1: btn1, btn2: btn2)
    }
   
    @IBAction func btn2Action(_ sender: Any) {
    
    delegatebtn.wishClick(btn1: btn1, btn2: btn2)
    }
    
  
   
    
}
