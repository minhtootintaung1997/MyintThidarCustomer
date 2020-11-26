//
//  DiamondInstockController.swift
//  Myint Thidar Customer
//
//  Created by Kaung Khant Shar on 30/07/2020.
//  Copyright © 2020 Nanolabs. All rights reserved.
//

import Foundation
import UIKit
import BadgeControl
import ImageSlideshow
class DiamondInstockController : UIViewController, ImageSlideshowDelegate {
    
  
    @IBOutlet weak var imageV: ImageSlideshow!
    @IBOutlet weak var curveView: UIView!
    @IBOutlet weak var diamondPrice: UITextField!
    @IBOutlet weak var itemcode_tf: UILabel!
    @IBOutlet weak var diamondkyat_tf: UITextField!
    @IBOutlet weak var diamondpal_tf: UITextField!
    @IBOutlet weak var diamondyway_tf: UITextField!
    @IBOutlet weak var diamondnumber_tf: UITextField!
    @IBOutlet weak var diamondalone_tf: UITextField!
    
    @IBOutlet weak var shweyi_tf: UILabel!
    @IBOutlet weak var quantity: UILabel!
    @IBOutlet weak var grand_total: UITextField!
    @IBOutlet weak var basketBtn: UIButton!
    @IBOutlet weak var topbasketbtn: UIButton!
    @IBOutlet weak var smallbasketbtn: UIButton!
    @IBOutlet weak var increase: UIButton!
    @IBOutlet weak var decrease: UIButton!
    @IBOutlet weak var gramtf: UITextField!
    
    var imagev : String = ""
    var price : String = ""
    var item_code : String = ""
    var gram : String = ""
    var quality : String = ""
    var diamond_quality : String = ""
    var value : Double = 1.0
    var countforbadge : Int = 0
    var category_id : String = ""
    var diamond_item_id : String = ""
    var total : Double = 0.0
    var diamond_kyat : String = ""
    var diamond_pal : String = ""
    var diamond_yae : String = ""
    var diamond_number : String = ""
    var diamond_alone : String = ""
    var almofireSource:[InputSource]=[]
    private var upperLeftBadge: BadgeController!
    var db:DBHelper = DBHelper()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        increase.layer.cornerRadius = 8.0
        increase.layer.borderWidth = 1.0
        increase.layer.borderColor = UIColor.gray.cgColor
        decrease.layer.cornerRadius = 8.0
        decrease.layer.borderWidth = 1.0
        decrease.layer.borderColor = UIColor.gray.cgColor
         total = (Double(price)! * value )
        grand_total.text = String(Int(total))
        let fmt = NumberFormatter()
        fmt.numberStyle = .decimal
        
       // diamondPrice.text = fmt.string(from: NSNumber(value: Int(price)!))!
        diamondPrice.text = price
        itemcode_tf.text = item_code
        shweyi_tf.text = diamond_quality
        gramtf.text = gram
        diamondkyat_tf.text = diamond_kyat
        diamondpal_tf.text = diamond_pal
        diamondyway_tf.text = diamond_yae
        diamondnumber_tf.text = diamond_number
        diamondalone_tf.text = diamond_alone
        almofireSource = [ AlamofireSource(urlString: "http://api.myinthidarjewellery.com/uploads/diamond/\(imagev)")!]
      imagetoload()
        curveView.clipsToBounds = true
        curveView.layer.cornerRadius = 50
        curveView.layer.maskedCorners = [.layerMaxXMinYCorner, .layerMinXMinYCorner]
        
    }
    
    func imagetoload() {
         imageV.slideshowInterval = 3.0
                                     imageV.pageIndicatorPosition = .init(horizontal: .center, vertical: .under)
                                     imageV.contentScaleMode = UIViewContentMode.scaleAspectFill

//                                     let pageControl = UIPageControl()
//                                     pageControl.currentPageIndicatorTintColor = UIColor.red
//                                     pageControl.pageIndicatorTintColor = UIColor.lightGray
//                                     imageV.pageIndicator = pageControl
//
//                                     // optional way to show activity indicator during image load (skipping the line will show no activity indicator)
                                    imageV.activityIndicator = DefaultActivityIndicator()
                                    imageV.delegate = self

                                     // can be used with other sample sources as `afNetworkingSource`, `alamofireSource` or `sdWebImageSource` or `kingfisherSource`
                                    
        self.imageV.setImageInputs(almofireSource)
                                     let recognizer = UITapGestureRecognizer(target: self, action: #selector(didTap))
                                     imageV.addGestureRecognizer(recognizer)
                
    }
    
    @objc func didTap() {
                       let fullScreenController = imageV.presentFullScreenController(from: self)
                       // set the activity indicator for full screen controller (skipping the line will show no activity indicator)
                       fullScreenController.slideshow.activityIndicator = DefaultActivityIndicator(style: .white, color: nil)
                   }
       
       func imageSlideshow(_ imageSlideshow: ImageSlideshow, didChangeCurrentPageTo page: Int) {
                  //print("current page:", page)
              }
   
   
    @IBAction func backAction(_ sender: Any) {
    
    navigationController?.popViewController(animated: true)
        dismiss(animated: true, completion: nil)
    }
    @IBAction func increaseAction(_ sender: Any) {
    
    
        value = value + 1
        quantity.text = String(Int(value))
         total = (Double(price)! * value )
        let fmt = NumberFormatter()
               fmt.numberStyle = .decimal
               
               grand_total.text = fmt.string(from: NSNumber(value: Int(total)))!
       
        
    }
   
    @IBAction func decreaseAction(_ sender: Any) {
    
    if value > 0 {
        value = value - 1
        quantity.text = String(Int(value))
         total = (Double(price)! * value )
        let fmt = NumberFormatter()
        fmt.numberStyle = .decimal
        
        grand_total.text = fmt.string(from: NSNumber(value: Int(total)))!
    }
}
   
    @IBAction func addtocartAction(_ sender: Any) {
    
    
              upperLeftBadge = BadgeController(for: topbasketbtn, in: .upperRightCorner, badgeBackgroundColor: UIColor.red,  badgeTextColor: UIColor.white, borderWidth: 0.5, badgeHeight: 15)

              upperLeftBadge.addOrReplaceCurrent(with: "1", animated: true)

                  upperLeftBadge.animateOnlyWhenBadgeIsNotYetPresent = true
                  upperLeftBadge.animation = BadgeAnimations.rolling
              
              
              countforbadge+=1
        if db.sumbydiamondid(id: (diamond_item_id as NSString).integerValue) == Int(diamond_item_id) {
            self.view.makeToast("Already added")
        } else {
            print("total_price \(total)")
            print("price \(price)")
        db.insertDiamond(id: (diamond_item_id as NSString).integerValue, diamond_item_id: (diamond_item_id as NSString).integerValue, category_id: (category_id as NSString).integerValue, itemCode: item_code, price: (price as NSString).doubleValue, total_price: total, gram: (gram as NSString).doubleValue, quality: quality, image: imagev, qty: Int(value), diamond_alone: diamond_alone, diamond_number: diamond_number, yati: "")
        db.readDiamond()
        
    }
}

}
