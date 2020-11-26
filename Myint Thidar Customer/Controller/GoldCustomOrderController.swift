//
//  GoldCustomOrderController.swift
//  Myint Thidar Customer
//
//  Created by Kaung Khant Shar on 23/07/2020.
//  Copyright © 2020 Nanolabs. All rights reserved.
//

import Foundation
import UIKit
import Alamofire
import SwiftyJSON
import BadgeControl
import Kingfisher
import ImageSlideshow
class GoldCustomOrderController : UIViewController, UITextFieldDelegate, ImageSlideshowDelegate {
    
    @IBOutlet weak var notelbl: UILabel!
    @IBOutlet weak var kyat_shwekyauk: UITextField!
    @IBOutlet weak var pll_shwekyauk: UITextField!
    @IBOutlet weak var yway_shwekyauk: UITextField!
    @IBOutlet weak var item_name: UILabel!
    @IBOutlet weak var imageV: ImageSlideshow!
    
    
    @IBOutlet weak var quantity: UILabel!
    @IBOutlet weak var increase: UIButton!
    @IBOutlet weak var decrease: UIButton!
    @IBOutlet weak var curveView: UIView!
    @IBOutlet weak var topbasketbtn: UIButton!
    @IBOutlet weak var scrollView: UIScrollView!
    
    var value : Double = 0.0
    var total_pll : Double = 0.0
    var total_kyat : Double = 0.0
    var total_yway : Double = 0.0
    var paukzyy : String = ""
    var grand_total : Double = 0.0
    var image : [String] = []
    var item_image : String = ""
    var category_id : String = ""
    var pauk_zyy : String = ""
    var goal_item_id : String = ""
    var gold_stone_kyat : String = ""
    var gold_stone_pal : String = ""
    var gold_stone_yae : String = ""
    var id : Int = 0
    var item_code : String = ""
    var order_type : String = ""
    var qty : String = ""
    var quality : String = ""
    var nono : String = ""
    var almofireSource:[InputSource]=[]
    
    var countforbadge : Int = 0
    private var upperLeftBadge: BadgeController!
    var db:DBHelper = DBHelper()
    override func viewDidLoad() {
        super.viewDidLoad()
        scrollView.bounces = false
        almofireSource = [ AlamofireSource(urlString: "http://api.myinthidarjewellery.com/uploads/gold/\(item_image)")!]
        imagetoload()
       // itemimage.kf.setImage(with: URL(string: "http://api.myinthidarjewellery.com/uploads/gold/\(item_image)"), placeholder: UIImage(named: "gold_ring"), options: nil, progressBlock: nil, completionHandler: nil)
        item_name.text = item_code
        notelbl.text = nono
        curveView.clipsToBounds = true
        curveView.layer.cornerRadius = 30
        curveView.layer.maskedCorners = [.layerMaxXMinYCorner, .layerMinXMinYCorner]
        loadSlideShow()
        self.hideKeyboardWhenTappedAround()
        PaukZyy()
        pll_shwekyauk.delegate = self
        quantity.layer.borderColor = UIColor.gray.cgColor
        increase.layer.cornerRadius = 8.0
        increase.layer.borderWidth = 1.0
        increase.layer.borderColor = UIColor.gray.cgColor
        decrease.layer.cornerRadius = 8.0
        decrease.layer.borderWidth = 1.0
        decrease.layer.borderColor = UIColor.gray.cgColor
        
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
    
//    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
//         let newText = (pll_shwekyauk.text! as NSString).replacingCharacters(in: range, with: string) as String
//           if let num = Int(newText), num >= 0 && num <= 15 {
//               return true
//           } else {
//               return false
//           }
//    }
    @IBAction func increaseQAction(_ sender: Any) {
    
    
       
        if kyat_shwekyauk.text == "" || pll_shwekyauk.text == "" || yway_shwekyauk.text == "" {
            let alertController = UIAlertController(title: "MTD Alert", message: "Please fill all the info", preferredStyle: .alert)
                      
                       let action2 = UIAlertAction(title: "Cancel", style: .cancel) { (action:UIAlertAction) in
                                                                                                               
            }
                       alertController.addAction(action2)

            self.present(alertController, animated: true, completion: nil)
        } else {
        value = value + 1
        quantity.text = String (Int(value))
       total_yway = Double(yway_shwekyauk.text!)! * value
        print("totalyway\(total_yway)")
        if total_yway >= 8 {
            let yway_kyan = total_yway / 8
            total_yway = yway_kyan
            total_pll = (Double(pll_shwekyauk.text!)! * value ) + 1
        }else {
             total_pll = Double(pll_shwekyauk.text!)! * value
        }
            if total_pll >= 16 {
                let pll_kyan = total_pll / 16
                total_pll = pll_kyan
                 total_kyat = ( Double(kyat_shwekyauk.text!)! * value ) + 1
            } else {
         total_kyat = Double(kyat_shwekyauk.text!)! * value
        }
        
        convertToKyat()
            
        }
    }
    
    func convertToKyat() {
        
       let convertk_yway = (((total_yway/8)+total_pll)/16) + total_kyat
       
        grand_total = Double(convertk_yway) * (paukzyy as NSString).doubleValue
        let fmt = NumberFormatter()
        fmt.numberStyle = .decimal
        
      //  total_value.text = fmt.string(from: NSNumber(value: Int(grand_total)))! + " ကျပ်"
        
    }
    
    func PaukZyy() {
        
        Alamofire.request("http://api.myinthidarjewellery.com/api/current_price", method: .get, encoding: JSONEncoding.default).responseJSON { response in
                          
                           
                           if let result = response.result.value {
                                                           
                            _ = result as! NSDictionary
                            if let json = response.data {
                               let data = try? JSON(data: json)
                              
                                self.paukzyy = "\(data!["price"])"
                               
                            }
                            
            }
            
        }
        
    }
    
   
    @IBAction func decreaseQAction(_ sender: Any) {
    
    if value > 0 {
        value = value - 1
        quantity.text = String (Int(value))
          total_yway = Double(yway_shwekyauk.text!)! * value
          print("totalyway\(total_yway)")
          if total_yway >= 8 {
              let yway_kyan = total_yway / 8
              total_yway = yway_kyan
              total_pll = (Double(pll_shwekyauk.text!)! * value ) + 1
          }else {
               total_pll = Double(pll_shwekyauk.text!)! * value
          }
              if total_pll >= 16 {
                  let pll_kyan = total_pll / 16
                  total_pll = pll_kyan
                   total_kyat = ( Double(kyat_shwekyauk.text!)! * value ) + 1
              } else {
           total_kyat = Double(kyat_shwekyauk.text!)! * value
          }
          
          convertToKyat()
         
    }
    }
    
    func loadSlideShow(){
               
               Alamofire.request("http://128.199.112.232:4400/api/news/", method: .get).responseJSON { (myresponse) in
                   
                   switch myresponse.result {
                   case .success:
                       
                       let myresults = try? JSON(data: myresponse.data!)
                      let resultArray = myresults
                       for i in resultArray!.arrayValue{
                           
//                           let banner_image = i["image"].stringValue
//                           self.banner_image.append(banner_image)
                        self.image.append(i["newsImage"].stringValue)
                        print(self.image)
//                           self.almofireSource.append(AlamofireSource(urlString: "http://api.myinthidarjewellery.com/uploads/banner/\(i["image"].stringValue)")!)
//                           self.slideShow.setImageInputs(self.almofireSource)
                       }
                      
                       break
                   case .failure:
                       break
                   }

               }
               
           }
    
    @IBAction func backAction(_ sender: Any) {
        navigationController?.popViewController(animated: true)
               self.dismiss(animated: true, completion: nil)
    }
    
   
    
    @IBAction func addtocartaction(_ sender: Any) {
    
    
    upperLeftBadge = BadgeController(for: topbasketbtn, in: .upperRightCorner, badgeBackgroundColor: UIColor.red,  badgeTextColor: UIColor.white, borderWidth: 0.5, badgeHeight: 15)

               upperLeftBadge.addOrReplaceCurrent(with: "1", animated: true)

                   upperLeftBadge.animateOnlyWhenBadgeIsNotYetPresent = true
                   upperLeftBadge.animation = BadgeAnimations.rolling
               //(product_id! as NSString).integerValue
               
               countforbadge+=1
        if db.sumbygoldid(id: (goal_item_id as NSString).integerValue) == (goal_item_id as NSString).integerValue {
            self.view.makeToast("Already added")
        } else {
        db.insertGold(id: 1, gold_item_id: (goal_item_id as NSString).integerValue, image: item_image, itemCode: item_code, category_id: (category_id as NSString).integerValue, quantity: quality, total_price: 0, qty: Int(value), gold_stone_kyat: kyat_shwekyauk.text!, gold_stone_pal: pll_shwekyauk.text!, gold_stone_yae: yway_shwekyauk.text!, ayot_kyat: "", ayot_pal: "", ayot_yae: "", stone_kyat: "", stone_pal: "", stone_yae: "", stone_value: "", currentSalePrice: pauk_zyy, order_type: "CustomOrder", realtotal_price: 0)
    }
    }
  
}
extension GoldCustomOrderController {
  public  func hideKeyboardWhenTappedAround() {
        let tap: UITapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(GoldCustomOrderController.dismissKeyboard))
        tap.cancelsTouchesInView = false
        view.addGestureRecognizer(tap)
    }

    @objc func dismissKeyboard() {
        view.endEditing(true)
    }
}
