//
//  WishlistController.swift
//  Myint Thidar Customer
//
//  Created by Kaung Khant Shar on 03/08/2020.
//  Copyright © 2020 Nanolabs. All rights reserved.
//

import Foundation
import UIKit
import Alamofire
import SwiftyJSON
import Kingfisher

class WishlistController : UIViewController, UICollectionViewDelegate, UICollectionViewDataSource, WishRemoveAction, UITabBarControllerDelegate {
    func wishremoveClick(btn2: UIButton) {
         let index : Int = btn2.tag
        let item: Wishlist = wishlist[index]
        self.product_id = item.product_id
        self.type = item.type
        wishlist.remove(at: index)
        deleteWishlist()
       
        wishlistcollectionview.reloadData()
    }
    
    @IBOutlet weak var heartimg: UIImageView!
    @IBOutlet weak var notiemlbl: UILabel!
    
    @IBOutlet weak var curveView: UIView!
    @IBOutlet weak var wishlistcollectionview: UICollectionView!
    var wishlist : [Wishlist] = []
    var product_id : String = ""
    var type : String = ""
    var userid : String = ""
    override func viewDidLoad() {
        super.viewDidLoad()
        
        userid = UserDefaults.standard.string(forKey: "userid")!
        self.tabBarController?.delegate = self
      //  loadwishlist()
        curveView.clipsToBounds = true
        curveView.layer.cornerRadius = 30
        curveView.layer.maskedCorners = [.layerMaxXMinYCorner, .layerMinXMinYCorner]
    }
    
    override func viewWillAppear(_ animated: Bool) {
        self.tabBarController?.delegate = self
        wishlist.removeAll()
        loadwishlist()
       
    }
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if self.wishlist.count == 0 {
            heartimg.isHidden = false
            notiemlbl.isHidden = false
            return 0
        } else {
            heartimg.isHidden = true
            notiemlbl.isHidden = true
             return wishlist.count
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
                                 print("success")
                                 break
                             case .failure:
                                 break
                             }
                         }
                   }
       
       func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = wishlistcollectionview.dequeueReusableCell(withReuseIdentifier: "cell", for: indexPath) as! WishlistCell
        cell.layer.shadowColor = UIColor.gray.cgColor
        cell.layer.shadowOffset = CGSize(width: 0, height: 2.0)
        cell.layer.shadowRadius = 2.0
        cell.layer.shadowOpacity = 0.3
        cell.layer.masksToBounds = false
          cell.layer.shadowPath = UIBezierPath(roundedRect: cell.bounds, cornerRadius: cell.contentView.layer.cornerRadius).cgPath
        cell.delegatebtnremove = self
        cell.deletewishlistbtn.tag = indexPath.row
        if wishlist.isEmpty {
            
        } else {
        if wishlist[indexPath.row].newarrival_type == "gold" {
            cell.wish_image.kf.setImage(with: URL(string: "http://api.myinthidarjewellery.com/uploads/gold/\(wishlist[indexPath.row].newarrival_image)"), placeholder: UIImage(named: "gold_ring"), options: nil, progressBlock: nil, completionHandler: nil)
            
        }
        if wishlist[indexPath.row].newarrival_type == "diamond" {
            cell.wish_image.kf.setImage(with: URL(string: "http://api.myinthidarjewellery.com/uploads/diamond/\(wishlist[indexPath.row].newarrival_image)"), placeholder: UIImage(named: "gold_ring"), options: nil, progressBlock: nil, completionHandler: nil)
        }
        if wishlist[indexPath.row].newarrival_type == "platinum" {
           cell.wish_image.kf.setImage(with: URL(string: "http://api.myinthidarjewellery.com/uploads/platinum/\(wishlist[indexPath.row].newarrival_image)"), placeholder: UIImage(named: "gold_ring"), options: nil, progressBlock: nil, completionHandler: nil)
        }
        
        cell.wish_itemcode.text = wishlist[indexPath.row].newarrival_name
        cell.wish_type.text = wishlist[indexPath.row].newarrival_type
        cell.wish_price.text = "Ks : \(wishlist[indexPath.row].newarrival_price)"
        }
        return cell
       }
    
    func loadwishlist(){
                 
                 let parameters: [String: Any] = [
                 "user_id" : userid
               
                                
                          ]
                          
                          Alamofire.request("http://api.myinthidarjewellery.com/api/wishlist/user", method: .post,parameters: parameters).responseJSON { (myresponse) in
                              
                              switch myresponse.result {
                              case .success:
                                  
                                  let myresults = try? JSON(data: myresponse.data!)
                                 
                                 
                                  let resultArray = myresults
                                  for i in resultArray!.arrayValue{
                                     let category_type = i["category"].stringValue
                                    print("categorytype\(category_type)")
                                  let pp = JSON(i["\(category_type)"])
                                    // print("pptype\(pp)")
                                    //  self.goldorderhistory.removeAll()
                                    for ii in pp.arrayValue {
                                     
                                        self.wishlist.append(Wishlist(product_id: ii["product_id"].stringValue, type: ii["type"].stringValue, newarrival_image: ii["image"].stringValue, newarrival_name: ii["item_code"].stringValue, newarrival_type: ii["type"].stringValue, newarrival_price: ii["price"].stringValue, product_type: i["category"].stringValue))
                                     
                                      }
                                     
                                    }
                                  
                                  self.wishlistcollectionview.reloadData()
//                                      self.ordertableview.reloadData()
//                                   self.indicator.stopAnimating()
//                                   self.indicator.hidesWhenStopped = true
                                      
                                  
        
                                  break
                              case .failure:
                                  break
                              }

                          }
                          
                      }
    
}
extension WishlistController : UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let size:CGFloat = (collectionView.frame.size.width - 70) / 2.0
        return CGSize(width: size, height: 220)
    }
    
}
