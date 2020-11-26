//
//  PlatinumInstockController.swift
//  Myint Thidar Customer
//
//  Created by Kaung Khant Shar on 30/07/2020.
//  Copyright © 2020 Nanolabs. All rights reserved.
//

import Foundation
import UIKit
import Kingfisher
import BadgeControl
import ImageSlideshow

class PlatinumInstockController : UIViewController, ImageSlideshowDelegate {
    
    @IBOutlet weak var imageV: ImageSlideshow!
    @IBOutlet weak var image: UIImageView!
    @IBOutlet weak var itemcode_tf: UILabel!
    @IBOutlet weak var notetf: UILabel!
    @IBOutlet weak var saleprice_tf: UITextField!
    
    @IBOutlet weak var platinumquality_tf: UILabel!
    @IBOutlet weak var shweyi_tf: UILabel!
    @IBOutlet weak var quantity: UILabel!
    @IBOutlet weak var curveView: UIView!
    @IBOutlet weak var gramtf: UITextField!
    
    @IBOutlet weak var grandtotal_tf: UITextField!
    @IBOutlet weak var topbasketbtn: UIButton!
    @IBOutlet weak var increase: UIButton!
    @IBOutlet weak var decrease: UIButton!
    
   
      var imagev : String = ""
      var price : String = ""
      var item_code : String = ""
      var gram : String = ""
      var quality : String = ""
      var platinum_quality : String = ""
    var platinum_item_id : String = ""
    var category_id : String = ""
    var value : Double = 1.0
    var countforbadge : Int = 0
    var total : Double = 0.0
    var note : String = ""
    var sale_price : String = ""
    var db : DBHelper = DBHelper()
    var almofireSource:[InputSource]=[]
    private var upperLeftBadge: BadgeController!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        increase.layer.cornerRadius = 8.0
        increase.layer.borderWidth = 1.0
        increase.layer.borderColor = UIColor.gray.cgColor
        decrease.layer.cornerRadius = 8.0
        decrease.layer.borderWidth = 1.0
        decrease.layer.borderColor = UIColor.gray.cgColor
         total = (Double(sale_price)! * value )
        grandtotal_tf.text = String(Int(total))

        let fmt = NumberFormatter()
        fmt.numberStyle = .decimal
        
     //   diamondprice_tf.text = fmt.string(from: NSNumber(value: Int(price)!))!
        platinumquality_tf.text = price
        notetf.text = note
        gramtf.text = gram
        saleprice_tf.text = sale_price
        itemcode_tf.text = item_code
        shweyi_tf.text = platinum_quality
        almofireSource = [ AlamofireSource(urlString: "http://api.myinthidarjewellery.com/uploads/platinum/\(imagev)")!]
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
         total = (Double(sale_price)! * value )
        let fmt = NumberFormatter()
               fmt.numberStyle = .decimal
               
               grandtotal_tf.text = fmt.string(from: NSNumber(value: Int(total)))!
    }
    @IBAction func decreaseAction(_ sender: Any) {
    
    
        if value > 0 {
            value = value - 1
            quantity.text = String(Int(value))
             total = (Double(sale_price)! * value )
                   let fmt = NumberFormatter()
                          fmt.numberStyle = .decimal
                          
                          grandtotal_tf.text = fmt.string(from: NSNumber(value: Int(total)))!
        }
    }
    @IBAction func addtocartaction(_ sender: Any) {
        
        upperLeftBadge = BadgeController(for: topbasketbtn, in: .upperRightCorner, badgeBackgroundColor: UIColor.red,  badgeTextColor: UIColor.white, borderWidth: 0.5, badgeHeight: 15)

                    upperLeftBadge.addOrReplaceCurrent(with: "1", animated: true)
                    upperLeftBadge.animateOnlyWhenBadgeIsNotYetPresent = true
                    upperLeftBadge.animation = BadgeAnimations.rolling
                    countforbadge+=1
        if db.sumbyplatinumid(id: (platinum_item_id as NSString).integerValue) == Int(platinum_item_id) {
            self.view.makeToast("Already added")
        } else {
        
        db.insertPlatinum(id: (platinum_item_id as NSString).integerValue, platinum_item_id: (platinum_item_id as NSString).integerValue, category_id: (category_id as NSString).integerValue, itemCode: item_code, price: (sale_price as NSString).doubleValue, total_price: total, gram: (gram as NSString).doubleValue, quality: platinum_quality, image: imagev, qty: Int(value))
    }
    }
    
}
