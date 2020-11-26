//
//  HomeViewController.swift
//  Myint Thidar Customer
//
//  Created by Kaung Khant Shar on 03/08/2020.
//  Copyright © 2020 Nanolabs. All rights reserved.
//

import Foundation
import UIKit
import Alamofire
import SwiftyJSON
import ImageSlideshow
import MarqueeLabel

class HomeViewController : UIViewController, UICollectionViewDelegate, UICollectionViewDataSource, ImageSlideshowDelegate, SeemoreNewarrivalClickAction {
    func wishClick(btn1: UIButton, btn2: UIButton) {
        let index: Int = btn1.tag
        let add : NewArrivals = newarrival[btn2.tag]
        self.product_id = add.id
        self.type = add.item_type
        if !add.isselected {
                 
                   add.isselected = true
                   btn1.isHidden = false
                   btn2.isHidden = true
                   deleteWishlist()
                   
               } else {
                  
                   btn1.isHidden = true
                   btn2.isHidden = false
                   addWishlist()
                    
               }
    }
    
   
    
    @IBOutlet weak var datelbl: UILabel!
    @IBOutlet weak var marquee: MarqueeLabel!
    @IBOutlet weak var platinumcollectionview: UICollectionView!
    @IBOutlet weak var diamondcollectionview: UICollectionView!
    @IBOutlet weak var goldcollectionview: UICollectionView!
    @IBOutlet weak var newarrivalcollectionview: UICollectionView!
   
    @IBOutlet weak var curveView: UIView!
    @IBOutlet weak var slideShow: ImageSlideshow!
    func activityIndicator() {
           indicator = UIActivityIndicatorView(frame: CGRect(x: 0, y: 0, width: 40, height: 40))
           indicator.style = UIActivityIndicatorView.Style.medium
           indicator.center = self.view.center
           self.view.addSubview(indicator)
       }
     var marqueeS : String = ""
     var gold : [Categories] = []
     var diamond : [Diamond] = []
     var platinum : [Platinum] = []
    var newarrival : [NewArrivals] = []
     var banner_image = [String]()
     var almofireSource:[InputSource]=[]
    var userid : String = ""
    var indicator = UIActivityIndicatorView()

    var product_id : String = ""
    var type : String = ""
   
    
    override func viewDidLoad() {
        super.viewDidLoad()
        diamondcollectionview.backgroundColor = .white
        
       userid = UserDefaults.standard.string(forKey: "userid")!
        print("userid \(userid)")
        activityIndicator()
               indicator.startAnimating()
               indicator.backgroundColor = .clear
        curveView.clipsToBounds = true
        curveView.layer.cornerRadius = 30
        curveView.layer.maskedCorners = [.layerMaxXMinYCorner, .layerMinXMinYCorner]
        goldcollectionview.showsHorizontalScrollIndicator = false
        diamondcollectionview.showsHorizontalScrollIndicator = false
        platinumcollectionview.showsHorizontalScrollIndicator = false
        newarrivalcollectionview.showsHorizontalScrollIndicator = false
               loadGoldCategory()
               loadDiamondCategory()
               loadPlatinumCategory()
               SlideShow()
               loadSlideShow()
              // loadNotice()
        loadmarquee()
        //loadgoldnewarrival()
        
    }
    override func viewWillAppear(_ animated: Bool) {
       loadgoldnewarrival()
        loadGoldCategory()
        loadDiamondCategory()
        loadPlatinumCategory()
      //  SlideShow()
      //  loadSlideShow()
      //   loadmarquee()
    }
    
    
    func loadNotice(){
                 
                 Alamofire.request("http://api.myinthidarjewellery.com/api/current_work", method: .get).responseJSON { (myresponse) in
                     print("kkkk\(myresponse)")
                     switch myresponse.result {
                     case .success:
                        
                         print("response\(myresponse)")
                         let myresults = try? JSON(data: myresponse.data!)
                       if let json = myresponse.data {
                         let data = try? JSON(data: json)
                            self.datelbl.text = "\(data!["date"])"
                          self.marqueeS.append("\(data!["about"])")
                             let strings = [self.marqueeS]
                           self.marquee.text = strings[Int(arc4random_uniform(UInt32(strings.count)))]
                               self.marquee.type = .continuous
                    self.marquee.speed = .duration(15)
                   self.marquee.animationCurve = .easeInOut
                      self.marquee.fadeLength = 10.0
                         self.marquee.leadingBuffer = 30.0
                          }
                        
                        
                         break
                     case .failure:
                         break
                     }
                     
                     
                 }
                     
                  
             }
    
    func loadmarquee(){
                 
                 Alamofire.request("http://api.myinthidarjewellery.com/api/gold_quality", method: .get).responseJSON { (myresponse) in
                     print("kkkk\(myresponse)")
                     switch myresponse.result {
                     case .success:
                        
                       
                         
                       if let json = myresponse.data {
                         let data = try? JSON(data: json)
                        
                        let first = "\(data![0]["price"])"
                        let second = "\(data![1]["price"])"
                        let third = "\(data![2]["price"])"
                        let datelbl = "\(data![0]["created_at"])"
                        self.datelbl.text = String(datelbl.prefix(10))
                        print("eee\(data![0]["price"])")
                          self.marqueeS.append("💎💎💎 \(first) ကျပ်  💎💎💎\(second) ကျပ် 💎💎💎\(third) ကျပ်")
                             let strings = [self.marqueeS]
                           self.marquee.text = strings[Int(arc4random_uniform(UInt32(strings.count)))]
                               self.marquee.type = .continuous
                    self.marquee.speed = .duration(15)
                   self.marquee.animationCurve = .easeInOut
                      self.marquee.fadeLength = 10.0
                         self.marquee.leadingBuffer = 30.0
                          }
                        
                        
                         break
                     case .failure:
                         break
                     }
                     
                     
                 }
                     
                  
             }
    
     func SlideShow() {
           slideShow.slideshowInterval = 3.0
                         slideShow.pageIndicatorPosition = .init(horizontal: .center, vertical: .under)
                         slideShow.contentScaleMode = UIViewContentMode.scaleAspectFill

                         let pageControl = UIPageControl()
                         pageControl.currentPageIndicatorTintColor = UIColor.red
                         pageControl.pageIndicatorTintColor = UIColor.lightGray
        pageControl.backgroundColor = .white
        slideShow.backgroundColor = .white
                         slideShow.pageIndicator = pageControl

                        
                         slideShow.activityIndicator = DefaultActivityIndicator()
                         slideShow.delegate = self
                         slideShow.backgroundColor = .white
                         let recognizer = UITapGestureRecognizer(target: self, action: #selector(didTap))
                         slideShow.addGestureRecognizer(recognizer)
           
       }
       @objc func didTap() {
                       let fullScreenController = slideShow.presentFullScreenController(from: self)
                       // set the activity indicator for full screen controller (skipping the line will show no activity indicator)
                       fullScreenController.slideshow.activityIndicator = DefaultActivityIndicator(style: .white, color: nil)
                   }
          
          func imageSlideshow(_ imageSlideshow: ImageSlideshow, didChangeCurrentPageTo page: Int) {
                   
               }
        func loadSlideShow(){
               
               Alamofire.request("http://api.myinthidarjewellery.com/api/banner", method: .get).responseJSON { (myresponse) in
                   
                   switch myresponse.result {
                   case .success:
                       
                       let myresults = try? JSON(data: myresponse.data!)
                      let resultArray = myresults
                       for i in resultArray!.arrayValue{
                           
                           let banner_image = i["image"].stringValue
                           self.banner_image.append(banner_image)
    
                           self.almofireSource.append(AlamofireSource(urlString: "http://api.myinthidarjewellery.com/uploads/banner/\(i["image"].stringValue)")!)
                           self.slideShow.setImageInputs(self.almofireSource)
                       }
                      
                       break
                   case .failure:
                       break
                   }

               }
               
           }
    
    func loadGoldCategory(){
        
        let parameters: [String: Any] = [
                   "user_id" : userid
                                  
                            ]
                   
           
           Alamofire.request("http://api.myinthidarjewellery.com/api/gold_category", method: .post,parameters: parameters).responseJSON { (myresponse) in
               
               switch myresponse.result {
               case .success:
                   
                   let myresults = try? JSON(data: myresponse.data!)
                   
                   var product:[DetailCategories]=[]
                   
                   let resultArray = myresults
                    self.gold.removeAll()
                   for i in resultArray!.arrayValue{
                        let pp = JSON(i["gold"])
                       product.removeAll()
                       for ii in pp.arrayValue {

                        let iswishlist = JSON(ii["wishlist_gold"])
                        
                        if iswishlist.isEmpty == false  {
                            
                            product.append(DetailCategories(category_id: ii["category_id"].stringValue, gold_item_id: ii["id"].stringValue, detailcategories_image: ii["image"].stringValue, detailcategories_name: ii["item_code"].stringValue, gold_stone_kyat: ii["gold_stone_kyat"].stringValue, gold_stone_pal: ii["gold_stone_pal"].stringValue, gold_stone_yae: ii["gold_stone_yae"].stringValue, ayot_kyat: ii["ayot_kyat"].stringValue, ayot_pal: ii["ayot_pal"].stringValue, ayot_yae: ii["ayot_yae"].stringValue, stone_kyat: ii["stone_kyat"].stringValue, stone_pal: ii["stone_pal"].stringValue, stone_yae: ii["stone_yae"].stringValue, stone_value: ii["stone_value"].stringValue, gold_quality: ii["gold_quality"].stringValue, product_id: ii["id"].stringValue, type: "gold", isselected: false, currentprice: ii["currentSalePrice"].stringValue, note: ii["note"].stringValue))
                        } else {
                            print("select p br b")
                            product.append(DetailCategories(category_id: ii["category_id"].stringValue, gold_item_id: ii["id"].stringValue, detailcategories_image: ii["image"].stringValue, detailcategories_name: ii["item_code"].stringValue, gold_stone_kyat: ii["gold_stone_kyat"].stringValue, gold_stone_pal: ii["gold_stone_pal"].stringValue, gold_stone_yae: ii["gold_stone_yae"].stringValue, ayot_kyat: ii["ayot_kyat"].stringValue, ayot_pal: ii["ayot_pal"].stringValue, ayot_yae: ii["ayot_yae"].stringValue, stone_kyat: ii["stone_kyat"].stringValue, stone_pal: ii["stone_pal"].stringValue, stone_yae: ii["stone_yae"].stringValue, stone_value: ii["stone_value"].stringValue, gold_quality: ii["gold_quality"].stringValue, product_id: ii["id"].stringValue, type: "gold", isselected: true, currentprice: ii["currentSalePrice"].stringValue, note: ii["note"].stringValue))
                           
                        }
                       }
                    
                       self.gold.append(Categories(category_image: i["image"].stringValue, category_name: i["name"].stringValue, product: product))
                         
                        self.goldcollectionview.reloadData()
                    self.indicator.stopAnimating()
                    self.indicator.hidesWhenStopped = true
                       
                   }
                  
                   break
               case .failure:
                   break
               }

           }
           
       }
    func loadDiamondCategory(){
        
        let parameters: [String: Any] = [
        "user_id" : userid
                       
                 ]
              
              Alamofire.request("http://api.myinthidarjewellery.com/api/diamond_category", method: .post, parameters: parameters).responseJSON { (myresponse) in
                  
                  switch myresponse.result {
                  case .success:
                      
                      let myresults = try? JSON(data: myresponse.data!)
                      self.diamond.removeAll()
                      var diamondproduct:[DetailDiamondCategories]=[]
                      let resultArray = myresults
                      self.diamond.removeAll()
                      for i in resultArray!.arrayValue{
                        let pp = JSON(i["diamond"])
                       diamondproduct.removeAll()
                       for ii in pp.arrayValue {
                        let iswishlist = JSON(ii["wishlist_diamond"])
                        if iswishlist.isEmpty == false {
                            diamondproduct.append(DetailDiamondCategories(diamond_item_id: ii["id"].stringValue, image: ii["image"].stringValue, item_code: ii["item_code"].stringValue, price: ii["latkar_gold_diamond_price"].stringValue, gram: ii["gram"].stringValue, quality: ii["quality"].stringValue, diamond_quality: ii["diamond_quality"].stringValue, category_id: ii["category_id"].stringValue, product_id: ii["id"].stringValue, type: "diamond", isselected: false, diamond_kyat : ii["diamond_kyat"].stringValue, diamond_pal : ii["diamond_pal"].stringValue, diamond_yae : ii["diamond_yae"].stringValue, diamond_number : ii["diamond_number"].stringValue, diamond_alone : ii["diamond_alone"].stringValue))
                        } else {
                            diamondproduct.append(DetailDiamondCategories(diamond_item_id: ii["id"].stringValue, image: ii["image"].stringValue, item_code: ii["item_code"].stringValue, price: ii["latkar_gold_diamond_price"].stringValue, gram: ii["gram"].stringValue, quality: ii["quality"].stringValue, diamond_quality: ii["diamond_quality"].stringValue, category_id: ii["category_id"].stringValue, product_id: ii["id"].stringValue, type: "diamond", isselected: true, diamond_kyat : ii["diamond_kyat"].stringValue, diamond_pal : ii["diamond_pal"].stringValue, diamond_yae : ii["diamond_yae"].stringValue, diamond_number : ii["diamond_number"].stringValue, diamond_alone : ii["diamond_alone"].stringValue))
                        }
                       }
                       self.diamond.append(Diamond(diamond_image: i["image"].stringValue, diamond_name: i["name"].stringValue, diamondproduct: diamondproduct))
                         
                          self.diamondcollectionview.reloadData()
                          
                      }
                     
                      break
                  case .failure:
                      break
                  }

              }
              
          }
    func loadPlatinumCategory(){
        
        let parameters: [String: Any] = [
        "user_id" : userid
                       
                 ]
                 
                 Alamofire.request("http://api.myinthidarjewellery.com/api/platinum_category", method: .post,parameters: parameters).responseJSON { (myresponse) in
                     
                     switch myresponse.result {
                     case .success:
                         
                         let myresults = try? JSON(data: myresponse.data!)
                         self.platinum.removeAll()
                         var platinumproduct:[DetailPlatinumCategories]=[]
                         let resultArray = myresults
                         self.platinum.removeAll()
                         for i in resultArray!.arrayValue{
                         let pp = JSON(i["platinum"])
                           platinumproduct.removeAll()
                           for ii in pp.arrayValue {
                            let iswishlist = JSON(ii["wishlist_platinum"])
                            if iswishlist.isEmpty == false {
                                platinumproduct.append(DetailPlatinumCategories(platinum_item_id : ii["id"].stringValue, image: ii["image"].stringValue, item_code: ii["item_code"].stringValue, price: ii["price"].stringValue, gram: ii["gram"].stringValue, sale_price: ii["sale_price"].stringValue, quality: ii["quality"].stringValue, platinum_quality: ii["platinum_quality"].stringValue, category_id: ii["category_id"].stringValue, product_id: ii["id"].stringValue, type : "platinum", isselected: false, note: ii["note"].stringValue))
                            } else {
                                platinumproduct.append(DetailPlatinumCategories(platinum_item_id : ii["id"].stringValue, image: ii["image"].stringValue, item_code: ii["item_code"].stringValue, price: ii["price"].stringValue, gram: ii["gram"].stringValue, sale_price: ii["sale_price"].stringValue, quality: ii["quality"].stringValue, platinum_quality: ii["platinum_quality"].stringValue, category_id: ii["category_id"].stringValue, product_id: ii["id"].stringValue, type : "platinum", isselected: true, note: ii["note"].stringValue))
                           }
                            }
                           self.platinum.append(Platinum(platinum_image: i["image"].stringValue, platinum_name: i["name"].stringValue, platinumProduct: platinumproduct))
                            
                             self.platinumcollectionview.reloadData()
                             
                         }
                        
                         break
                     case .failure:
                         break
                     }

                 }
                 
             }
    
     func loadgoldnewarrival(){
                     
                     let parameters: [String: Any] = [
                     "user_id" : userid
                   
                                    
                              ]
                              
                              Alamofire.request("http://api.myinthidarjewellery.com/api/newarrival", method: .post,parameters: parameters).responseJSON { (myresponse) in
                                  
                                  switch myresponse.result {
                                  case .success:
                                      
                                      let myresults = try? JSON(data: myresponse.data!)
                                     
                                     
                                      let resultArray = myresults
                                      self.newarrival.removeAll()
                                      for i in resultArray!.arrayValue{
                                         let category_type = i["category"].stringValue
                                       
                                      let pp = JSON(i["\(category_type)"])
                                      
                                        for ii in pp.arrayValue {
                                          
                                          let iswishlist = JSON(ii["wishlist_gold"])
                                            let iswishlistdiamond = JSON(ii["wishlist_diamond"])
                                            let iswishlistplatinum = JSON(ii["wishlist_platinum"])
                                            if iswishlist.isEmpty == false  {
                                                
                                            
                                            
                                                self.newarrival.append(NewArrivals(id: ii["id"].stringValue, image: ii["image"].stringValue, item_code: ii["item_code"].stringValue, gold_kyat: ii["gold_kyat"].stringValue, gold_pal: ii["gold_pal"].stringValue, gold_yae: ii["gold_yae"].stringValue, ayin_ayot_kyat: ii["ayin_ayot_kyat"].stringValue, ayin_ayot_pal: ii["ayin_ayot_pal"].stringValue, ayin_ayot_yae: ii["ayin_ayot_yae"].stringValue, gram: ii["gram"].stringValue, gold_stone_kyat: ii["gold_stone_kyat"].stringValue, gold_stone_pal: ii["gold_stone_pal"].stringValue, gold_stone_yae: ii["gold_stone_yae"].stringValue, ayot_kyat: ii["ayot_kyat"].stringValue, ayot_pal: ii["ayot_pal"].stringValue, ayot_yae: ii["ayot_yae"].stringValue, latli_ayot_kyat: ii["latli_ayot_kyat"].stringValue, latli_ayot_pal: ii["latli_ayot_pal"].stringValue, latli_ayot_yae: ii["latli_ayot_yae"].stringValue, stone_kyat: ii["stone_kyat"].stringValue, stone_pal: ii["stone_pal"].stringValue, stone_yae: ii["stone_yae"].stringValue, stone_value: ii["stone_value"].stringValue, qty: ii["qty"].stringValue, gold_quality: ii["gold_quality"].stringValue, currentSalePrice: ii["currentSalePrice"].stringValue, gold_quality_price: ii["gold_quality_price"].stringValue, latli_currentSalePrice: ii["latli_currentSalePrice"].stringValue, ayin_price: ii["ayin_price"].stringValue, isselected: false, item_type: i["category"].stringValue, price: ii["price"].stringValue, yadi: ii["yadi"].stringValue, diamond_kyat: ii["diamond_kyat"].stringValue, diamond_pal: ii["diamond_pal"].stringValue, diamond_yae: ii["diamond_yae"].stringValue, note: ii["note"].stringValue, diamond_quality : ii["diamond_quality"].stringValue, diamond_number : ii["diamond_number"].stringValue, diamond_alone : ii["diamond_alone"].stringValue, platinum_price : ii["price"].stringValue, platinum_quality : ii["platinum_quality"].stringValue, sale_price : ii["sale_price"].stringValue))
                                                   }
                                            else {
                                                self.newarrival.append(NewArrivals(id: ii["id"].stringValue, image: ii["image"].stringValue, item_code: ii["item_code"].stringValue, gold_kyat: ii["gold_kyat"].stringValue, gold_pal: ii["gold_pal"].stringValue, gold_yae: ii["gold_yae"].stringValue, ayin_ayot_kyat: ii["ayin_ayot_kyat"].stringValue, ayin_ayot_pal: ii["ayin_ayot_pal"].stringValue, ayin_ayot_yae: ii["ayin_ayot_yae"].stringValue, gram: ii["gram"].stringValue, gold_stone_kyat: ii["gold_stone_kyat"].stringValue, gold_stone_pal: ii["gold_stone_pal"].stringValue, gold_stone_yae: ii["gold_stone_yae"].stringValue, ayot_kyat: ii["ayot_kyat"].stringValue, ayot_pal: ii["ayot_pal"].stringValue, ayot_yae: ii["ayot_yae"].stringValue, latli_ayot_kyat: ii["latli_ayot_kyat"].stringValue, latli_ayot_pal: ii["latli_ayot_pal"].stringValue, latli_ayot_yae: ii["latli_ayot_yae"].stringValue, stone_kyat: ii["stone_kyat"].stringValue, stone_pal: ii["stone_pal"].stringValue, stone_yae: ii["stone_yae"].stringValue, stone_value: ii["stone_value"].stringValue, qty: ii["qty"].stringValue, gold_quality: ii["gold_quality"].stringValue, currentSalePrice: ii["currentSalePrice"].stringValue, gold_quality_price: ii["gold_quality_price"].stringValue, latli_currentSalePrice: ii["latli_currentSalePrice"].stringValue, ayin_price: ii["ayin_price"].stringValue, isselected: true, item_type: i["category"].stringValue, price: ii["price"].stringValue, yadi: ii["yadi"].stringValue, diamond_kyat: ii["diamond_kyat"].stringValue, diamond_pal: ii["diamond_pal"].stringValue, diamond_yae: ii["diamond_yae"].stringValue, note: ii["note"].stringValue, diamond_quality : ii["diamond_quality"].stringValue, diamond_number : ii["diamond_number"].stringValue, diamond_alone : ii["diamond_alone"].stringValue, platinum_price : ii["price"].stringValue, platinum_quality : ii["platinum_quality"].stringValue, sale_price : ii["sale_price"].stringValue))
                                            }
//                                            if iswishlistdiamond.isEmpty == false  {
//
//
//
//                                                                                      self.newarrival.append(NewArrivals(id: ii["id"].stringValue, image: ii["image"].stringValue, item_code: ii["item_code"].stringValue, gold_kyat: ii["gold_kyat"].stringValue, gold_pal: ii["gold_pal"].stringValue, gold_yae: ii["gold_yae"].stringValue, ayin_ayot_kyat: ii["ayin_ayot_kyat"].stringValue, ayin_ayot_pal: ii["ayin_ayot_pal"].stringValue, ayin_ayot_yae: ii["ayin_ayot_yae"].stringValue, gram: ii["gram"].stringValue, gold_stone_kyat: ii["gold_stone_kyat"].stringValue, gold_stone_pal: ii["gold_stone_pal"].stringValue, gold_stone_yae: ii["gold_stone_yae"].stringValue, ayot_kyat: ii["ayot_kyat"].stringValue, ayot_pal: ii["ayot_pal"].stringValue, ayot_yae: ii["ayot_yae"].stringValue, latli_ayot_kyat: ii["latli_ayot_kyat"].stringValue, latli_ayot_pal: ii["latli_ayot_pal"].stringValue, latli_ayot_yae: ii["latli_ayot_yae"].stringValue, stone_kyat: ii["stone_kyat"].stringValue, stone_pal: ii["stone_pal"].stringValue, stone_yae: ii["stone_yae"].stringValue, stone_value: ii["stone_value"].stringValue, qty: ii["qty"].stringValue, gold_quality: ii["gold_quality"].stringValue, currentSalePrice: ii["currentSalePrice"].stringValue, gold_quality_price: ii["gold_quality_price"].stringValue, latli_currentSalePrice: ii["latli_currentSalePrice"].stringValue, ayin_price: ii["ayin_price"].stringValue, isselected: false, item_type: i["category"].stringValue, price: ii["price"].stringValue, yadi: ii["yadi"].stringValue, diamond_kyat: ii["diamond_kyat"].stringValue, diamond_pal: ii["diamond_pal"].stringValue, diamond_yae: ii["diamond_yae"].stringValue))
//                                                                                             }
//                                            else {
//                                                        self.newarrival.append(NewArrivals(id: ii["id"].stringValue, image: ii["image"].stringValue, item_code: ii["item_code"].stringValue, gold_kyat: ii["gold_kyat"].stringValue, gold_pal: ii["gold_pal"].stringValue, gold_yae: ii["gold_yae"].stringValue, ayin_ayot_kyat: ii["ayin_ayot_kyat"].stringValue, ayin_ayot_pal: ii["ayin_ayot_pal"].stringValue, ayin_ayot_yae: ii["ayin_ayot_yae"].stringValue, gram: ii["gram"].stringValue, gold_stone_kyat: ii["gold_stone_kyat"].stringValue, gold_stone_pal: ii["gold_stone_pal"].stringValue, gold_stone_yae: ii["gold_stone_yae"].stringValue, ayot_kyat: ii["ayot_kyat"].stringValue, ayot_pal: ii["ayot_pal"].stringValue, ayot_yae: ii["ayot_yae"].stringValue, latli_ayot_kyat: ii["latli_ayot_kyat"].stringValue, latli_ayot_pal: ii["latli_ayot_pal"].stringValue, latli_ayot_yae: ii["latli_ayot_yae"].stringValue, stone_kyat: ii["stone_kyat"].stringValue, stone_pal: ii["stone_pal"].stringValue, stone_yae: ii["stone_yae"].stringValue, stone_value: ii["stone_value"].stringValue, qty: ii["qty"].stringValue, gold_quality: ii["gold_quality"].stringValue, currentSalePrice: ii["currentSalePrice"].stringValue, gold_quality_price: ii["gold_quality_price"].stringValue, latli_currentSalePrice: ii["latli_currentSalePrice"].stringValue, ayin_price: ii["ayin_price"].stringValue, isselected: true, item_type: i["category"].stringValue, price: ii["price"].stringValue, yadi: ii["yadi"].stringValue, diamond_kyat: ii["diamond_kyat"].stringValue, diamond_pal: ii["diamond_pal"].stringValue, diamond_yae: ii["diamond_yae"].stringValue))
//                                            }
//                                            if iswishlistplatinum.isEmpty == false {
//                                                        self.newarrival.append(NewArrivals(id: ii["id"].stringValue, image: ii["image"].stringValue, item_code: ii["item_code"].stringValue, gold_kyat: ii["gold_kyat"].stringValue, gold_pal: ii["gold_pal"].stringValue, gold_yae: ii["gold_yae"].stringValue, ayin_ayot_kyat: ii["ayin_ayot_kyat"].stringValue, ayin_ayot_pal: ii["ayin_ayot_pal"].stringValue, ayin_ayot_yae: ii["ayin_ayot_yae"].stringValue, gram: ii["gram"].stringValue, gold_stone_kyat: ii["gold_stone_kyat"].stringValue, gold_stone_pal: ii["gold_stone_pal"].stringValue, gold_stone_yae: ii["gold_stone_yae"].stringValue, ayot_kyat: ii["ayot_kyat"].stringValue, ayot_pal: ii["ayot_pal"].stringValue, ayot_yae: ii["ayot_yae"].stringValue, latli_ayot_kyat: ii["latli_ayot_kyat"].stringValue, latli_ayot_pal: ii["latli_ayot_pal"].stringValue, latli_ayot_yae: ii["latli_ayot_yae"].stringValue, stone_kyat: ii["stone_kyat"].stringValue, stone_pal: ii["stone_pal"].stringValue, stone_yae: ii["stone_yae"].stringValue, stone_value: ii["stone_value"].stringValue, qty: ii["qty"].stringValue, gold_quality: ii["gold_quality"].stringValue, currentSalePrice: ii["currentSalePrice"].stringValue, gold_quality_price: ii["gold_quality_price"].stringValue, latli_currentSalePrice: ii["latli_currentSalePrice"].stringValue, ayin_price: ii["ayin_price"].stringValue, isselected: false, item_type: i["category"].stringValue, price: ii["price"].stringValue, yadi: ii["yadi"].stringValue, diamond_kyat: ii["diamond_kyat"].stringValue, diamond_pal: ii["diamond_pal"].stringValue, diamond_yae: ii["diamond_yae"].stringValue))
//                                            }
//                                            else {
//                                                        self.newarrival.append(NewArrivals(id: ii["id"].stringValue, image: ii["image"].stringValue, item_code: ii["item_code"].stringValue, gold_kyat: ii["gold_kyat"].stringValue, gold_pal: ii["gold_pal"].stringValue, gold_yae: ii["gold_yae"].stringValue, ayin_ayot_kyat: ii["ayin_ayot_kyat"].stringValue, ayin_ayot_pal: ii["ayin_ayot_pal"].stringValue, ayin_ayot_yae: ii["ayin_ayot_yae"].stringValue, gram: ii["gram"].stringValue, gold_stone_kyat: ii["gold_stone_kyat"].stringValue, gold_stone_pal: ii["gold_stone_pal"].stringValue, gold_stone_yae: ii["gold_stone_yae"].stringValue, ayot_kyat: ii["ayot_kyat"].stringValue, ayot_pal: ii["ayot_pal"].stringValue, ayot_yae: ii["ayot_yae"].stringValue, latli_ayot_kyat: ii["latli_ayot_kyat"].stringValue, latli_ayot_pal: ii["latli_ayot_pal"].stringValue, latli_ayot_yae: ii["latli_ayot_yae"].stringValue, stone_kyat: ii["stone_kyat"].stringValue, stone_pal: ii["stone_pal"].stringValue, stone_yae: ii["stone_yae"].stringValue, stone_value: ii["stone_value"].stringValue, qty: ii["qty"].stringValue, gold_quality: ii["gold_quality"].stringValue, currentSalePrice: ii["currentSalePrice"].stringValue, gold_quality_price: ii["gold_quality_price"].stringValue, latli_currentSalePrice: ii["latli_currentSalePrice"].stringValue, ayin_price: ii["ayin_price"].stringValue, isselected: true, item_type: i["category"].stringValue, price: ii["price"].stringValue, yadi: ii["yadi"].stringValue, diamond_kyat: ii["diamond_kyat"].stringValue, diamond_pal: ii["diamond_pal"].stringValue, diamond_yae: ii["diamond_yae"].stringValue))
//                                            }
                                        }
                                        }
                                      
                                      self.newarrivalcollectionview.reloadData()
                                    
                                      
            
                                      break
                                  case .failure:
                                      break
                                  }

                              }
                              
                          }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
          if segue.identifier == "detailcategories" {
                    
        //            let indexPaths=self.collectionviewgold!.indexPathsForSelectedItems!
        //            let indexPath = indexPaths[0] as NSIndexPath
                    let vc = segue.destination as! DetailCategoriesController
                    if gold.isEmpty {
                        
                    } else {
                        vc.detailcategory.removeAll()
                        vc.detailcategory = sender as Any as! [DetailCategories]
                       
                    }
                } else if segue.identifier == "todiamonddetail" {
                    let vc = segue.destination as! DiamondDetailController
                    if diamond.isEmpty {
                        
                    } else {
                        vc.diamonddetail.removeAll()
                        vc.diamonddetail = sender as Any as! [DetailDiamondCategories]
                        
                    }
                    
                } else if segue.identifier == "todetailplatinum" {
                    let vc = segue.destination as! PlatinumDetailController
                    if platinum.isEmpty {
                        
                    } else {
                        vc.platinumdetail.removeAll()
                        vc.platinumdetail = sender as Any as! [DetailPlatinumCategories]
                    }
          } else if segue.identifier == "newarrival_gold" {
            let indexPaths=self.newarrivalcollectionview!.indexPathsForSelectedItems!
                       let indexPath = indexPaths[0] as NSIndexPath
            let vc = segue.destination as! GoldOnStockController
            vc.gold_stone_kyat = newarrival[indexPath.row].gold_kyat
            vc.gold_stone_pae = newarrival[indexPath.row].gold_pal
            vc.gold_stone_yae = newarrival[indexPath.row].gold_yae
            vc.ayot_kyat = newarrival[indexPath.row].ayot_kyat
            vc.ayot_pae = newarrival[indexPath.row].ayot_pal
            vc.ayot_yae = newarrival[indexPath.row].ayot_yae
            vc.stone_kyat = newarrival[indexPath.row].stone_kyat
            vc.stone_pae = newarrival[indexPath.row].stone_pal
            vc.stone_yae = newarrival[indexPath.row].stone_yae
            vc.stone_value = newarrival[indexPath.row].stone_value
            vc.gold_quality = newarrival[indexPath.row].gold_quality
            vc.item_code = newarrival[indexPath.row].item_code
            vc.image = newarrival[indexPath.row].image
            vc.note = newarrival[indexPath.row].note
            vc.currentprice = newarrival[indexPath.row].currentSalePrice
            
            
          } else if segue.identifier == "newarrival_diamond" {
            let indexPaths=self.newarrivalcollectionview!.indexPathsForSelectedItems!
            let indexPath = indexPaths[0] as NSIndexPath
            let vc = segue.destination as! DiamondInstockController
            vc.imagev = newarrival[indexPath.row].image
            vc.price = newarrival[indexPath.row].price
            vc.item_code = newarrival[indexPath.row].item_code
            vc.gram = newarrival[indexPath.row].gram
            vc.diamond_quality = newarrival[indexPath.row].diamond_quality
            vc.diamond_number = newarrival[indexPath.row].diamond_number
            vc.diamond_alone = newarrival[indexPath.row].diamond_alone
            vc.diamond_kyat = newarrival[indexPath.row].diamond_kyat
            vc.diamond_pal = newarrival[indexPath.row].diamond_pal
            vc.diamond_yae = newarrival[indexPath.row].diamond_yae
            
            
            
            
            
          } else if segue.identifier == "newarrival_platinum" {
            let indexPaths=self.newarrivalcollectionview!.indexPathsForSelectedItems!
                       let indexPath = indexPaths[0] as NSIndexPath
            let vc = segue.destination as! PlatinumInstockController
            
//            vc.price = platinumdetail[indexPath.row].price
//            vc.item_code = platinumdetail[indexPath.row].item_code
//            vc.imagev = platinumdetail[indexPath.row].image
//            vc.gram = platinumdetail[indexPath.row].gram
//             vc.category_id = platinumdetail[indexPath.row].category_id
//             vc.platinum_item_id = platinumdetail[indexPath.row].platinum_item_id
//             vc.platinum_quality = platinumdetail[indexPath.row].platinum_quality
//             vc.quality = platinumdetail[indexPath.row].quality
//             vc.note = platinumdetail[indexPath.row].note
//             vc.sale_price = platinumdetail[indexPath.row].sale_price
            
            vc.imagev = newarrival[indexPath.row].image
            vc.price = newarrival[indexPath.row].platinum_price
            vc.item_code = newarrival[indexPath.row].item_code
            vc.gram = newarrival[indexPath.row].gram
            vc.platinum_quality = newarrival[indexPath.row].platinum_quality
            vc.note = newarrival[indexPath.row].note
            vc.sale_price = newarrival[indexPath.row].sale_price
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        
        if collectionView == diamondcollectionview {
            return diamond.count
        }
        if collectionView == platinumcollectionview {
            return platinum.count
        }
        if collectionView == newarrivalcollectionview {
            return newarrival.count
        }
        
        return gold.count
       }
       
       func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        if collectionView == goldcollectionview {
        let goldcell = goldcollectionview.dequeueReusableCell(withReuseIdentifier: "goldcell", for: indexPath) as! GoldCell
               goldcell.contentView.layer.cornerRadius = 10.0
               goldcell.contentView.layer.borderWidth = 1.0
               goldcell.contentView.layer.borderColor = UIColor.clear.cgColor
               goldcell.contentView.layer.masksToBounds = true
               goldcell.layer.shadowColor = UIColor.lightGray.cgColor
               goldcell.layer.shadowOffset = CGSize(width: 0, height: 2.0)
               goldcell.layer.shadowRadius = 2.0
            goldcell.layer.shadowOpacity = 0.5
               goldcell.layer.masksToBounds = false
              // goldcell.layer.shadowPath = UIBezierPath(roundedRect: goldcell.bounds, cornerRadius: goldcell.contentView.layer.cornerRadius).cgPath
        if gold.isEmpty {
            
        } else {
        goldcell.gold_image.kf.setImage(with: URL(string: "http://api.myinthidarjewellery.com/uploads/gold_category/" + gold[indexPath.row].category_image), placeholder: UIImage(named: "gold_ring"), options: nil, progressBlock: nil, completionHandler: nil)
        goldcell.gold_name.text = gold[indexPath.row].category_name
        }
        
        return goldcell
        }
        if collectionView == diamondcollectionview {
            let diamondcell = diamondcollectionview.dequeueReusableCell(withReuseIdentifier: "diamondcell", for: indexPath) as! DiamondCell
            diamondcell.backgroundColor = .white
            diamondcell.contentView.layer.cornerRadius = 10.0
                    diamondcell.contentView.layer.borderWidth = 1.0
                    diamondcell.contentView.layer.borderColor = UIColor.clear.cgColor
                    diamondcell.contentView.layer.masksToBounds = true
                    diamondcell.layer.shadowColor = UIColor.lightGray.cgColor
                    diamondcell.layer.shadowOffset = CGSize(width: 0, height: 2.0)
                    diamondcell.layer.shadowRadius = 2.0
            diamondcell.layer.shadowOpacity = 0.5
                    diamondcell.layer.masksToBounds = false
                  //  diamondcell.layer.shadowPath = UIBezierPath(roundedRect: diamondcell.bounds, cornerRadius: diamondcell.contentView.layer.cornerRadius).cgPath
            if diamond.isEmpty {
                
            } else {
                diamondcell.diamond_image.kf.setImage(with: URL(string: "http://api.myinthidarjewellery.com/uploads/diamond_category/" + diamond[indexPath.row].diamond_image), placeholder: UIImage(named: "gold_ring"), options: nil, progressBlock: nil, completionHandler: nil)
                       diamondcell.diamond_name.text = diamond[indexPath.row].diamond_name
            }
            return diamondcell
        }
        if collectionView == platinumcollectionview {
            let platinumcell = platinumcollectionview.dequeueReusableCell(withReuseIdentifier: "platinumcell", for: indexPath) as! PlatinumCell
            platinumcell.contentView.layer.cornerRadius = 10.0
            platinumcell.contentView.layer.borderWidth = 1.0
            platinumcell.contentView.layer.borderColor = UIColor.clear.cgColor
            platinumcell.contentView.layer.masksToBounds = true
            platinumcell.layer.shadowColor = UIColor.lightGray.cgColor
            platinumcell.layer.shadowOffset = CGSize(width: 0, height: 2.0)
            platinumcell.layer.shadowRadius = 2.0
            platinumcell.layer.shadowOpacity = 0.5
            platinumcell.layer.masksToBounds = false
            if platinum.isEmpty {
                
            } else {
                platinumcell.platinum_image.kf.setImage(with: URL(string: "http://api.myinthidarjewellery.com/uploads/platinum_category/" + platinum[indexPath.row].platinum_image), placeholder: UIImage(named: "gold_ring"), options: nil, progressBlock: nil, completionHandler: nil)
                platinumcell.platinum_name.text = platinum[indexPath.row].platinum_name
                
            }
            return platinumcell
            
        }
        if collectionView == newarrivalcollectionview {
            let newarrivalcell = newarrivalcollectionview.dequeueReusableCell(withReuseIdentifier: "arrivalcell", for: indexPath) as! NewArrivalsCell
            newarrivalcell.delegatebtn = self
            newarrivalcell.btn1.tag = indexPath.row
            newarrivalcell.btn2.tag = indexPath.row
            newarrivalcell.contentView.layer.cornerRadius = 10.0
            newarrivalcell.contentView.layer.borderWidth = 1.0
            newarrivalcell.contentView.layer.borderColor = UIColor.clear.cgColor
            newarrivalcell.contentView.layer.masksToBounds = true
            newarrivalcell.layer.shadowColor = UIColor.lightGray.cgColor
            newarrivalcell.layer.shadowOffset = CGSize(width: 0, height: 2.0)
            newarrivalcell.layer.shadowRadius = 2.0
            newarrivalcell.layer.shadowOpacity = 0.3
            newarrivalcell.layer.masksToBounds = false
            if newarrival.isEmpty {

            } else {
                if newarrival[indexPath.row].item_type == "gold" {
                    newarrivalcell.newarrival_image.kf.setImage(with: URL(string: "http://api.myinthidarjewellery.com/uploads/gold/\(newarrival[indexPath.row].image)"), placeholder: UIImage(named: "gold_ring"), options: nil, progressBlock: nil, completionHandler: nil)
                     newarrivalcell.newarrival_name.text = newarrival[indexPath.row].item_code
                    newarrivalcell.newarrival_type.text = newarrival[indexPath.row].item_type
                    if newarrival[indexPath.row].isselected {
                        newarrivalcell.btn2.isHidden=true
                        newarrivalcell.btn1.isHidden=false
                    } else {
                        newarrivalcell.btn1.isHidden = true
                        newarrivalcell.btn2.isHidden = false
                    }
                }
                if newarrival[indexPath.row].item_type == "diamond" {
                     newarrivalcell.newarrival_image.kf.setImage(with: URL(string: "http://api.myinthidarjewellery.com/uploads/diamond/\(newarrival[indexPath.row].image)"), placeholder: UIImage(named: "gold_ring"), options: nil, progressBlock: nil, completionHandler: nil)
                    newarrivalcell.newarrival_name.text = newarrival[indexPath.row].item_code
                                   newarrivalcell.newarrival_type.text = newarrival[indexPath.row].item_type
                }
                if newarrival[indexPath.row].item_type == "platinum" {
                     newarrivalcell.newarrival_image.kf.setImage(with: URL(string: "http://api.myinthidarjewellery.com/uploads/platinum/\(newarrival[indexPath.row].image)"), placeholder: UIImage(named: "gold_ring"), options: nil, progressBlock: nil, completionHandler: nil)
                    newarrivalcell.newarrival_name.text = newarrival[indexPath.row].item_code
                    newarrivalcell.newarrival_type.text = newarrival[indexPath.row].item_type
                }

                
            }
            return newarrivalcell
        }
        return UICollectionViewCell()
       }
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
         if collectionView == goldcollectionview {
           
            
            let selectedMessage = gold[indexPath.row].product
            
            loadGoldCategory()
                     
               self.performSegue(withIdentifier: "detailcategories", sender: selectedMessage)
               }
               else if collectionView == diamondcollectionview {
            
                   let selectedMessage = diamond[indexPath.row].diamondproduct
            loadDiamondCategory()
                   self.performSegue(withIdentifier: "todiamonddetail", sender: selectedMessage)
               } else if collectionView == platinumcollectionview {
                   let selectedMessage = platinum[indexPath.row].platinumProduct
            loadPlatinumCategory()
                   self.performSegue(withIdentifier: "todetailplatinum", sender: selectedMessage)
               }
        if collectionView == newarrivalcollectionview {
            
            if newarrival[indexPath.row].item_type == "gold"{
                print("have to go to gold")
                
                self.performSegue(withIdentifier: "newarrival_gold", sender: self)
            }
            else if newarrival[indexPath.row].item_type == "diamond" {
                 print("have to go to diamond")
                self.performSegue(withIdentifier: "newarrival_diamond", sender: self)
            }
            else if newarrival[indexPath.row].item_type == "platinum" {
                 print("have to go to platinum")
                self.performSegue(withIdentifier: "newarrival_platinum", sender: self)
            }
            
        }
           }
    func addWishlist(){
        
        let parameters: [String: Any] = [
            "user_id" : userid,
            "product_id" : product_id,
            "type" : type
                           
                           
                       ]
            
            Alamofire.request("http://api.myinthidarjewellery.com/api/wishlist/store", method: .post, parameters: parameters).responseJSON { (myresponse) in
                
                switch myresponse.result {
                case .success:

                    let myresults =  JSON(myresponse.data!)
                    _ = myresults
                    print("insert success")
                    break
                case .failure:
                    break
                }
            }
      }
      
      func deleteWishlist(){
           
           let parameters: [String: Any] = [
               "user_id" : userid,
               "product_id" : product_id,
               "type" : type
                              
                              
                          ]
               
               Alamofire.request("http://api.myinthidarjewellery.com/api/wishlist/destroy", method: .post, parameters: parameters).responseJSON { (myresponse) in
                   
                   switch myresponse.result {
                   case .success:

                       let myresults =  JSON(myresponse.data!)
                       _ = myresults
                       print("delete success")
                       break
                   case .failure:
                       break
                   }
               }
         }
    
}
extension UIView {

    /**
     Rotate a view by specified degrees

     - parameter angle: angle in degrees
     */
    func rotate(angle: CGFloat) {
        let radians = angle / 180.0 * CGFloat.pi
        let rotation = self.transform.rotated(by: radians);
        self.transform = rotation
    }

}
