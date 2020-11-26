//
//  GoldcustomhistorydetailController.swift
//  Myint Thidar Customer
//
//  Created by Kaung Khant Shar on 28/08/2020.
//  Copyright © 2020 Nanolabs. All rights reserved.
//

import Foundation
import UIKit
import ImageSlideshow
import Kingfisher
class GoldcustomhistorydetailController : UIViewController {
    @IBOutlet weak var img: UIImageView!
    @IBOutlet weak var itemcode: UILabel!
    @IBOutlet weak var price: UILabel!
    @IBOutlet weak var shwe_yi: UILabel!
    @IBOutlet weak var quantity: UILabel!
    @IBOutlet weak var shwelay: UITextField!
    @IBOutlet weak var shwelay_pl: UITextField!
    @IBOutlet weak var shwelay_yway: UITextField!
    @IBOutlet weak var atai: UITextField!
    @IBOutlet weak var note: UITextField!
    @IBOutlet weak var scrollView: UIScrollView!
    
    var imgs : String = ""
    var itemcodes : String = ""
    var prices : String = ""
    var shweyis : String = ""
    var quantitys : String = ""
    var shwelays : String = ""
    var shwelaypls : String = ""
    var shwelayyways : String = ""
    var atais : String = ""
    var notes : String = ""
    
    override func viewDidLoad() {
        super.viewDidLoad()
        scrollView.bounces = false
        self.img.kf.setImage(with: URL(string: "http://api.myinthidarjewellery.com/uploads/gold/\(imgs)"), placeholder: UIImage(named: "gold_ring"), options: nil, progressBlock: nil, completionHandler: nil)
       
        itemcode.text = itemcodes
        price.text = prices
        shwe_yi.text = shweyis
        quantity.text = quantitys
        shwelay.text = shwelays
        shwelay_pl.text = shwelaypls
        shwelay_yway.text = shwelayyways
        atai.text = atais
        note.text = notes
        
    }
    @IBAction func backAction(_ sender: Any) {
        navigationController?.popViewController(animated: true)
        dismiss(animated: true, completion: nil)
    }
}
