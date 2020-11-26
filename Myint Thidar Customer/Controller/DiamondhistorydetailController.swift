//
//  DiamondhistorydetailController.swift
//  Myint Thidar Customer
//
//  Created by Kaung Khant Shar on 28/08/2020.
//  Copyright © 2020 Nanolabs. All rights reserved.
//

import Foundation
import UIKit
import ImageSlideshow

class DiamondhistorydetailController : UIViewController, ImageSlideshowDelegate {
    
    @IBOutlet weak var imageV: ImageSlideshow!
    @IBOutlet weak var itemcode: UILabel!
    @IBOutlet weak var shweyi: UILabel!
    @IBOutlet weak var weight_kyat: UITextField!
    @IBOutlet weak var weight_pl: UITextField!
    @IBOutlet weak var weight_yway: UITextField!
    @IBOutlet weak var diamondnumbertf: UITextField!
    
    @IBOutlet weak var gramtf: UITextField!
    @IBOutlet weak var diamondalonetf: UITextField!
    
    @IBOutlet weak var scrollView: UIScrollView!
    @IBOutlet weak var quantity: UILabel!
    @IBOutlet weak var total_price: UITextField!
    @IBOutlet weak var grandtotal_price: UITextField!
    @IBOutlet weak var curveView: UIView!
    @IBOutlet weak var alonecee: UITextField!
    
    var imgs : String = ""
    var itemcodes : String = ""
    var shweyis : String = ""
    var weightkyats : String = ""
    var weightpls : String = ""
    var weightyways : String = ""
    var apwintyays : String = ""
    var yatis : String = ""
    var quantitys : String = ""
    var totalprices : String = ""
    var grandtotal_prices : String = ""
    var alonecees : String = ""
    var almofireSource:[InputSource]=[]
    var diamondalone : String = ""
    override func viewDidLoad() {
        super.viewDidLoad()
        scrollView.bounces = false
        curveView.clipsToBounds = true
        curveView.layer.cornerRadius = 30
        curveView.layer.maskedCorners = [.layerMaxXMinYCorner, .layerMinXMinYCorner]
        almofireSource = [ AlamofireSource(urlString: "http://api.myinthidarjewellery.com/uploads/diamond/\(imgs)")!]
        imagetoload()
        itemcode.text = itemcodes
        shweyi.text = shweyis
        weight_kyat.text = weightkyats
        weight_pl.text = weightpls
        weight_yway.text = weightyways
        gramtf.text = apwintyays
        diamondnumbertf.text = yatis
        diamondalonetf.text = diamondalone
        quantity.text = quantitys
        total_price.text = totalprices
        grandtotal_price.text = grandtotal_prices
        //alonecee.text = alonecees
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
}
