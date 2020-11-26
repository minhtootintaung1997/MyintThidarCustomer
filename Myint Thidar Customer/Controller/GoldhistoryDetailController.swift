//
//  GoldhistoryDetailController.swift
//  Myint Thidar Customer
//
//  Created by Kaung Khant Shar on 27/08/2020.
//  Copyright © 2020 Nanolabs. All rights reserved.
//

import Foundation
import UIKit
import ImageSlideshow
import Kingfisher

class GoldhistoryDetailController : UIViewController, ImageSlideshowDelegate {
    
    @IBOutlet weak var image: ImageSlideshow!
    @IBOutlet weak var item_code: UILabel!
    @IBOutlet weak var price: UILabel!
    @IBOutlet weak var shwe_yi: UILabel!
    @IBOutlet weak var shwe_kyat: UITextField!
    @IBOutlet weak var shwe_pl: UITextField!
    @IBOutlet weak var shwe_yway: UITextField!
    @IBOutlet weak var york_kyat: UITextField!
    @IBOutlet weak var york_pl: UITextField!
    @IBOutlet weak var york_yway: UITextField!
    @IBOutlet weak var kyauk_poe: UITextField!
    @IBOutlet weak var kyauk_kyat: UITextField!
    @IBOutlet weak var kyauk_pl: UITextField!
    @IBOutlet weak var kyauk_yway: UITextField!
    @IBOutlet weak var quantity: UILabel!
    @IBOutlet weak var total_price: UITextField!
    @IBOutlet weak var curveView: UIView!
    @IBOutlet weak var notetf: UILabel!
    
    var imgS : String = ""
    var itemcodeS : String = ""
    var priceS : String = ""
    var shwe_yiS : String = ""
    var shwekyatS : String = ""
    var shwePlS : String = ""
    var shweywayS : String = ""
    var yorkkyat_S : String = ""
    var yorkpll_S : String = ""
    var yorkyway_S : String = ""
    var kyaukpoeS : String = ""
    var kyaukkyatS : String = ""
    var kyaukpllS : String = ""
    var kyaukywayS : String = ""
    var quantityS : String = ""
    var totalpriceS : String = ""
    var note : String = ""
     var almofireSource:[InputSource]=[]
    
    @IBOutlet weak var scrollView: UIScrollView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        scrollView.bounces = false
        print("imagename\(imgS)")
        almofireSource = [ AlamofireSource(urlString: "http://api.myinthidarjewellery.com/uploads/gold/\(imgS)")!]
        item_code.text = itemcodeS
        price.text = "\(priceS) ကျပ်"
        shwe_kyat.text = shwekyatS
        shwe_pl.text = shwePlS
        shwe_yway.text = shweywayS
        york_kyat.text = yorkkyat_S
        york_pl.text = yorkpll_S
        york_yway.text = yorkyway_S
        kyauk_poe.text = kyaukpoeS
        kyauk_kyat.text = kyaukkyatS
        kyauk_pl.text = kyaukpllS
        kyauk_yway.text = kyaukywayS
        quantity.text = quantityS
        total_price.text = totalpriceS
        notetf.text = note
        imagetoload()
        curveView.clipsToBounds = true
        curveView.layer.cornerRadius = 30
        curveView.layer.maskedCorners = [.layerMaxXMinYCorner, .layerMinXMinYCorner]
    }
    
    func imagetoload() {
            image.slideshowInterval = 3.0
                                        image.pageIndicatorPosition = .init(horizontal: .center, vertical: .under)
                                    image.contentScaleMode = UIViewContentMode.scaleAspectFill

//                                        let pageControl = UIPageControl()
//                                        pageControl.currentPageIndicatorTintColor = UIColor.red
//                                        pageControl.pageIndicatorTintColor = UIColor.lightGray
//                                        image.pageIndicator = pageControl

                                        // optional way to show activity indicator during image load (skipping the line will show no activity indicator)
                                        image.activityIndicator = DefaultActivityIndicator()
                                        image.delegate = self

                                        
                                       
                                        self.image.setImageInputs(almofireSource)
                                        let recognizer = UITapGestureRecognizer(target: self, action: #selector(didTap))
                                        image.addGestureRecognizer(recognizer)
                   
       }
       
       @objc func didTap() {
                          let fullScreenController = image.presentFullScreenController(from: self)
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
    
}
