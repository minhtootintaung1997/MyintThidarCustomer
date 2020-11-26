//
//  GoldOnStockController.swift
//  Myint Thidar Customer
//
//  Created by Kaung Khant Shar on 23/07/2020.
//  Copyright © 2020 Nanolabs. All rights reserved.
//

import Foundation
import UIKit
import Alamofire
import SwiftyJSON
import Kingfisher
import BadgeControl
import ImageSlideshow
class GoldOnStockController : UIViewController, ImageSlideshowDelegate {
    
   
    @IBOutlet weak var notelbl: UILabel!
    @IBOutlet weak var shwe_kyat: UITextField!
    @IBOutlet weak var shwe_pll: UITextField!
    @IBOutlet weak var shwe_yway: UITextField!
    
    @IBOutlet weak var york_kyat: UITextField!
    @IBOutlet weak var york_pll: UITextField!
    @IBOutlet weak var york_yway: UITextField!
    
    @IBOutlet weak var kyauk_kyat: UITextField!
    @IBOutlet weak var kyauk_pll: UITextField!
    @IBOutlet weak var kyauk_yway: UITextField!
    
    @IBOutlet weak var kyauk_phoe: UITextField!
    @IBOutlet weak var quantity: UILabel!
    @IBOutlet weak var total_q: UITextField!
    @IBOutlet weak var shwe_yi: UILabel!
    
    @IBOutlet weak var item_type: UILabel!
    
    @IBOutlet weak var increaseBtn: UIButton!
    @IBOutlet weak var decreaseBtn: UIButton!
    @IBOutlet weak var paukzyy_price: UILabel!
    @IBOutlet weak var item_name: UILabel!
    @IBOutlet weak var basketbtn: UIButton!
    @IBOutlet weak var topbasketbtn: UIButton!
    @IBOutlet weak var scrollView: UIScrollView!
    
    //@IBOutlet weak var imageV: UIImageView!
    @IBOutlet weak var imageV: ImageSlideshow!
    @IBOutlet weak var curveView: UIView!
    var id : String = ""
    var image : String = ""
    var item_code : String = ""
    var gold_stone_kyat : String = ""
    var gold_stone_pae : String = ""
    var gold_stone_yae : String = ""
    var ayot_kyat : String = ""
    var ayot_pae : String = ""
    var ayot_yae : String = ""
    var stone_kyat : String = ""
    var stone_pae : String = ""
    var stone_yae : String = ""
    var stone_value : String = ""
    var qty : String = ""
    var category_id : String = ""
    var gold_quality : String = ""
    var final_total : Double = 0.0
    var currentprice : String = ""
    var fin : Double = 0.0
       var pauk_zyy : String = ""
       var value : Double = 0.0
       var total_pll : Double = 0.0
       var total_kyat : Double = 0.0
       var total_yway : Double = 0.0
       
    
       var yorkkyat : Double = 0.0
       var yorkpll : Double = 0.0
       var yorkyway : Double = 0.0
    
    var kyaukkyat : Double = 0.0
    var kyaukpll : Double = 0.0
    var kyaukyway : Double = 0.0
    
    var second_kyat : Double = 0.0
    var second_pll : Double = 0.0
    var second_yway : Double = 0.0
    
    var third_kyat : Double = 0.0
    var third_pll : Double = 0.0
    var third_yway : Double = 0.0
    
    var converttokyat : Double = 0.0
    
    var fourth_kyat : Double = 0.0
    
    var stonevalue : Double = 0.0
    var prestonevalue : String = ""
    var goldonstock : [DetailCategories] = []
    var item_typeS : String = ""
    var countforbadge : Int = 0
    var almofireSource:[InputSource]=[]
    private var upperLeftBadge: BadgeController!
    
    var pll : Double = 0.0
    var note : String = ""
    
    var db:DBHelper = DBHelper()
    override func viewDidLoad() {
        super.viewDidLoad()
        scrollView.bounces = false
        almofireSource = [ AlamofireSource(urlString: "http://api.myinthidarjewellery.com/uploads/gold/\(String(image))")!]
        imagetoload()
       // imageV.kf.setImage(with: URL(string: "http://api.myinthidarjewellery.com/uploads/gold/\(image)"), placeholder: UIImage(named: "gold_ring"), options: nil, progressBlock: nil, completionHandler: nil)
        curveView.clipsToBounds = true
        curveView.layer.cornerRadius = 30
        curveView.layer.maskedCorners = [.layerMaxXMinYCorner, .layerMinXMinYCorner]
      settexttoonstock()
       
        
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
         
    
    func settexttoonstock() {
       
        shwe_kyat.text = gold_stone_kyat
        shwe_pll.text = gold_stone_pae
        shwe_yway.text = gold_stone_yae
        york_kyat.text = ayot_kyat
        york_pll.text = ayot_pae
        york_yway.text = ayot_yae
        kyauk_kyat.text = stone_kyat
        kyauk_pll.text = stone_pae
        kyauk_yway.text = stone_yae
        kyauk_phoe.text = stone_value
        shwe_yi.text = gold_quality
        item_name.text = item_code
        paukzyy_price.text = "\(currentprice) ကျပ်"
        notelbl.text = note
        
        increaseBtn.layer.cornerRadius = 8.0
        increaseBtn.layer.borderWidth = 1.0
        increaseBtn.layer.borderColor = UIColor.gray.cgColor
        decreaseBtn.layer.cornerRadius = 8.0
        decreaseBtn.layer.borderWidth = 1.0
        decreaseBtn.layer.borderColor = UIColor.gray.cgColor
    }
    
    func CalculatePrice() {
        
        var calculateGoldStoneKyat : Int = 0
        var calculateGoldStonePal : Int = 0
        var calculateGoldStoneYae : Double = 0.0
        
        calculateGoldStoneKyat = Int(Double(shwe_kyat.text!)! * value)
        calculateGoldStonePal = Int(Double(shwe_pll.text!)! * value)
        calculateGoldStoneYae = (Double(shwe_yway.text!)! * value)
       
        
        var calculateAyotKyat : Int = 0
        var calculateAyotPal : Int = 0
        var calculateAyotYae : Double = 0.0
        
        calculateAyotKyat = Int(Double(york_kyat.text!)! * value)
        calculateAyotPal = Int(Double(york_pll.text!)! * value)
        calculateAyotYae = Double(york_yway.text!)! * value
       
        var calculateStoneKyat : Int = 0
        var calculateStonePal : Int = 0
        var calculateStoneYae : Double = 0.0
        
        calculateStoneKyat = Int(Double(kyauk_kyat.text!)! * value)
        calculateStonePal = Int(Double(kyauk_pll.text!)! * value)
        calculateStoneYae = Double(kyauk_yway.text!)! * value
        
        var calculateStoneValue : Int = 0
        
        calculateStoneValue = Int((Double(stone_value)! * value ))
        
        var resultGoldStonePlusAyotKyat : Int = 0
        var resultGoldStonePlusAyotPal : Int = 0
        var resultGoldStonePlusAyotYae : Double = 0.0
        
        var resultYae : Double = 0.0
        var resultPal : Int = 0
        var resultKyat : Int = 0
        
        resultYae = calculateGoldStoneYae + calculateAyotYae
        resultPal = calculateGoldStonePal + calculateAyotPal
        resultKyat = calculateGoldStoneKyat + calculateAyotKyat
        
        resultGoldStonePlusAyotKyat = resultKyat
        
        if (resultYae >= 8 ) {
                    resultGoldStonePlusAyotPal += Int (resultYae / 8)
            resultGoldStonePlusAyotYae = resultYae.truncatingRemainder(dividingBy: 8)
        
                } else {
                    resultGoldStonePlusAyotYae = resultYae
                }
        if (resultPal >= 16) {
                   resultGoldStonePlusAyotKyat += Int (resultPal / 16);
            resultGoldStonePlusAyotPal = Int(Double(resultPal).truncatingRemainder(dividingBy: 8))
               } else {
                   resultGoldStonePlusAyotPal += resultPal;
               }
        
        var resultGSMinusStoneKyat : Int = 0
        var resultGSMinusStonePal : Int = 0
        var resultGSMinusStoneYae : Double = 0.0
        
        if (resultGoldStonePlusAyotYae >= calculateStoneYae) {
                    resultGSMinusStoneYae = resultGoldStonePlusAyotYae - calculateStoneYae;
                } else {
                    resultGoldStonePlusAyotPal -= 1;
                    resultGSMinusStoneYae = (resultGoldStonePlusAyotYae + 8) - calculateStoneYae
                }
        if (resultGoldStonePlusAyotPal >= calculateStonePal) {
                   resultGSMinusStonePal = resultGoldStonePlusAyotPal - calculateStonePal;
               } else {
                   resultGoldStonePlusAyotKyat -= 1;
                   resultGSMinusStonePal = (resultGoldStonePlusAyotPal + 16) - calculateStonePal;
               }

        resultGSMinusStoneKyat = resultGoldStonePlusAyotKyat - calculateStoneKyat;
    
        let netYae : Double = (resultGSMinusStoneYae / 8)
        
        var totalKyat : Double = 0
        var totalPrice : Int = 0
        var rawPrice : Int = 0
        
       // totalKyat = ((netYae + resultGSMinusStonePal) / 16) + resultGSMinusStoneKyat;
        let final1 = netYae + Double(resultGSMinusStonePal)
        let final2 = final1 + Double(resultGSMinusStoneKyat)
        rawPrice = Int (final2 * Double(currentprice)! )
        totalPrice = rawPrice + calculateStoneValue
        let fmt = NumberFormatter()
        fmt.numberStyle = .decimal
        total_q.text = fmt.string(from: NSNumber(value: Int(totalPrice)))! + " ကျပ်"
        
        
    }
    func goldcal() {
        
        var shwekyaukyway : Double = 0.0
        var shwekyaukpll : Int = 0
        var shwekyaukkyat : Int = 0
        
        shwekyaukyway = (shwe_yway.text! as NSString).doubleValue * value
        shwekyaukpll = (shwe_pll.text! as NSString).integerValue * Int(value)
        shwekyaukkyat = (shwe_kyat.text! as NSString).integerValue * Int(value)
        
        var ayorkyway : Double = 0.0
        var ayorkpll : Int = 0
        var ayorkkyat : Int = 0
        
        ayorkyway = (york_yway.text! as NSString).doubleValue * value
        ayorkpll = (york_pll.text! as NSString).integerValue * Int(value)
        ayorkkyat = (york_kyat.text! as NSString).integerValue * Int(value)
        
        var shwekyaukplusyorkyway : Double = 0.0
        var shwekyaukplusyorkpll : Int = 0
        var shwekyaukplusyorkkyat : Int = 0
        
        shwekyaukplusyorkyway = shwekyaukyway + ayorkyway
        shwekyaukplusyorkpll = shwekyaukpll + ayorkpll
        shwekyaukplusyorkkyat = shwekyaukkyat + ayorkkyat
        
        var kyaukyway : Double = 0.0
        var kyaukpll : Int = 0
        var kyaukkyat : Int = 0
        
        kyaukyway = (kyauk_yway.text! as NSString).doubleValue * value
        kyaukpll = (kyauk_pll.text! as NSString).integerValue * Int(value)
        kyaukkyat = (kyauk_kyat.text! as NSString).integerValue * Int(value)
        
        var shwekyaukyorkpluskyaukchainyway : Double = 0.0
        var shwekyaukyorkpluskyaukchainpll : Int = 0
        var shwekyaukyorkpluskyaukchainkyat : Int = 0
        
        shwekyaukyorkpluskyaukchainyway = shwekyaukplusyorkyway - kyaukyway
        shwekyaukyorkpluskyaukchainpll = shwekyaukplusyorkpll - kyaukpll
        shwekyaukyorkpluskyaukchainkyat = shwekyaukplusyorkkyat - kyaukkyat
        
        var beforeyway : Double = 0.0
        var beforepll : Double = 0.0
        var beforekyat : Double = 0.0
        
        beforeyway = (shwekyaukyorkpluskyaukchainyway / 8 )
        beforepll = (beforeyway + Double(shwekyaukyorkpluskyaukchainpll)) / 16
        beforekyat = beforepll + Double(shwekyaukyorkpluskyaukchainkyat)
         fin = beforekyat * Double(currentprice)!
       let stoneV = (Double(stone_value)! * value )
        fin = fin + stoneV
        let fmt = NumberFormatter()
        fmt.numberStyle = .decimal
        total_q.text = fmt.string(from: NSNumber(value: Int(fin)))! + " ကျပ်"
    }
   
    @IBAction func increaseAction(_ sender: Any) {
    
       
        value = value + 1
        quantity.text = String(Int(value))
      //  CalculatePrice()
        goldcal()
       

    }
  
    @IBAction func decreaseAction(_ sender: Any) {
    
    
                if value > 0 {
                       value = value - 1
                    quantity.text = String(Int(value))
                    goldcal()

                }
         
    }
    

    @IBAction func backAction(_ sender: Any) {
        navigationController?.popViewController(animated: true)
              self.dismiss(animated: true, completion: nil)
    }
    @IBAction func customorderAction(_ sender: Any) {
        self.performSegue(withIdentifier: "custom", sender: self)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "custom" {
            let vc = segue.destination as! GoldCustomOrderController
            vc.item_code = item_code
            vc.goal_item_id = id
            vc.item_image = image
            vc.category_id = category_id
            vc.quality = gold_quality
            vc.qty = qty
            vc.pauk_zyy = pauk_zyy
            vc.nono = note
            
           
            
        }
    }
    
    @IBAction func addtocartAction(_ sender: Any) {
    
       
   
        upperLeftBadge = BadgeController(for: topbasketbtn, in: .upperRightCorner, badgeBackgroundColor: UIColor.red,  badgeTextColor: UIColor.white, borderWidth: 0.5, badgeHeight: 15)

        upperLeftBadge.addOrReplaceCurrent(with: "1", animated: true)

            upperLeftBadge.animateOnlyWhenBadgeIsNotYetPresent = true
            upperLeftBadge.animation = BadgeAnimations.rolling
       
        
        countforbadge+=1
        
        if db.sumbygoldid(id: (id as NSString).integerValue) == Int(id) {
            print("same item")
            self.view.makeToast("Already added")
        } else {
           
            db.insertGold(id: 1, gold_item_id: (id as NSString).integerValue, image: image, itemCode: item_code, category_id: (category_id as NSString).integerValue, quantity: gold_quality, total_price: fin, qty: Int(value), gold_stone_kyat: gold_stone_kyat, gold_stone_pal: gold_stone_pae, gold_stone_yae: gold_stone_yae, ayot_kyat: ayot_kyat, ayot_pal: ayot_pae, ayot_yae: ayot_yae, stone_kyat: stone_kyat, stone_pal: stone_pae, stone_yae: stone_yae, stone_value: stone_value, currentSalePrice: currentprice, order_type: "InStock", realtotal_price: fin)
       
    }
    }

}
