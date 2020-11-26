//
//  PlatinumDetailController.swift
//  Myint Thidar Customer
//
//  Created by Kaung Khant Shar on 30/07/2020.
//  Copyright © 2020 Nanolabs. All rights reserved.
//

import Foundation
import UIKit
import Alamofire
import SwiftyJSON

class PlatinumDetailController : UIViewController, UICollectionViewDelegate, UICollectionViewDataSource, UIGestureRecognizerDelegate, SeemorePlatinumClickAction {
   
    func wishClick(btn1: UIButton, btn2: UIButton) {
        let index : Int = btn1.tag
        let add : DetailPlatinumCategories = platinumdetail[btn2.tag]
        self.product_id = add.product_id
        self.type = add.type
        
        if !add.isselected {
                          
                          add.isselected = true
                          btn1.isHidden = false
                          btn2.isHidden = true
                          deleteWishlist()
                          
                      } else {
                          add.isselected = false
                          btn1.isHidden = true
                          btn2.isHidden = false
                          addWishlist()
                           
                      }
        platinumdetail[btn2.tag] = add
        platinumcollectionview.reloadData()
    }
    
    
   
    @IBOutlet weak var noitem: UILabel!
    @IBOutlet weak var curveView: UIView!
    @IBOutlet weak var platinumcollectionview: UICollectionView!
    var platinumdetail : [DetailPlatinumCategories] = []
    var product_id : String = ""
    var type : String = ""
    var userid : String = ""
    override func viewDidLoad() {
        super.viewDidLoad()
        userid = UserDefaults.standard.string(forKey: "userid")!
        curveView.clipsToBounds = true
               curveView.layer.cornerRadius = 30
               curveView.layer.maskedCorners = [.layerMaxXMinYCorner, .layerMinXMinYCorner]
//               self.navigationController?.interactivePopGestureRecognizer?.delegate = self
//               self.navigationController?.interactivePopGestureRecognizer?.isEnabled = true
        platinumcollectionview.showsVerticalScrollIndicator = false
    }
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
            if segue.identifier == "toplatinuminstock" {
                   let indexPaths=self.platinumcollectionview!.indexPathsForSelectedItems!
                   let indexPath = indexPaths[0] as NSIndexPath
                   let vc = segue.destination as! PlatinumInstockController
                             if platinumdetail.isEmpty {
                                 
                             } else {
                                
                               vc.price = platinumdetail[indexPath.row].price
                               vc.item_code = platinumdetail[indexPath.row].item_code
                               vc.imagev = platinumdetail[indexPath.row].image
                               vc.gram = platinumdetail[indexPath.row].gram
                                vc.category_id = platinumdetail[indexPath.row].category_id
                                vc.platinum_item_id = platinumdetail[indexPath.row].platinum_item_id
                                vc.platinum_quality = platinumdetail[indexPath.row].platinum_quality
                                vc.quality = platinumdetail[indexPath.row].quality
                                vc.note = platinumdetail[indexPath.row].note
                                vc.sale_price = platinumdetail[indexPath.row].sale_price
                             
                             }
              }
       }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if platinumdetail.isEmpty {
            noitem.isHidden = false
            return 0
        } else {
            noitem.isHidden = true
        return platinumdetail.count
    }
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = platinumcollectionview.dequeueReusableCell(withReuseIdentifier: "platinumcell", for: indexPath) as! DetailPlatinumCell
        cell.delegatebtn = self
        cell.btn1.tag = indexPath.row
        cell.btn2.tag = indexPath.row
       cell.contentView.layer.cornerRadius = 2.0
        cell.contentView.layer.borderWidth = 1.0
        cell.contentView.layer.borderColor = UIColor.clear.cgColor
        cell.contentView.layer.masksToBounds = true
        cell.layer.shadowColor = UIColor.lightGray.cgColor
        cell.layer.shadowOffset = CGSize(width: 0, height: 2.0)
        cell.layer.shadowRadius = 2.0
        cell.layer.shadowOpacity = 0.5
        cell.layer.masksToBounds = false
        cell.layer.shadowPath = UIBezierPath(roundedRect: cell.bounds, cornerRadius: cell.contentView.layer.cornerRadius).cgPath
        if platinumdetail.isEmpty {
            
        } else {
        cell.platinum_image.kf.setImage(with: URL(string: "http://api.myinthidarjewellery.com/uploads/platinum/\(platinumdetail[indexPath.row].image)"), placeholder: UIImage(named: "gold_ring"), options: nil, progressBlock: nil, completionHandler: nil)
        cell.platinum_name.text = platinumdetail[indexPath.row].item_code
            if platinumdetail[indexPath.row].isselected{
                cell.btn2.isHidden=true
                cell.btn1.isHidden=false
            }else{
                cell.btn1.isHidden=true
                cell.btn2.isHidden=false
            }
        }
        return cell
    }
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        self.performSegue(withIdentifier: "toplatinuminstock", sender: self)
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
    
    @IBAction func backAction(_ sender: Any) {
        navigationController?.popViewController(animated: true)
        dismiss(animated: true, completion: nil)
    }
}
extension PlatinumDetailController : UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let size:CGFloat = (collectionView.frame.size.width - 40) / 2.0
        return CGSize(width: size, height: 220)
    }
    
}
