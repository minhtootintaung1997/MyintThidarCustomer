//
//  DetailCategoriesController.swift
//  Myint Thidar Customer
//
//  Created by Kaung Khant Shar on 22/07/2020.
//  Copyright © 2020 Nanolabs. All rights reserved.
//

import Foundation
import UIKit
import Alamofire
import SwiftyJSON
class DetailCategoriesController : UIViewController, UICollectionViewDelegate, UICollectionViewDataSource, UIGestureRecognizerDelegate, SeemoreClickAction {
    func wishClick(btn1: UIButton, btn2: UIButton) {
        let index:Int=btn1.tag
        
        let add : DetailCategories = detailcategory[btn2.tag]
        print("addclicked\(add.isselected)")
        self.product_id = add.product_id
        self.type = add.type
        if !add.isselected {
            print("clickactionis\(add.isselected)")
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
        print("addclickresult\(add.isselected)")
        detailcategory[btn2.tag] = add
        collectionviewdetailcategories.reloadData()
    }
    
   
    
   
   
    @IBOutlet weak var noitem: UILabel!
    @IBOutlet weak var curveView: UIView!
    @IBOutlet weak var collectionviewdetailcategories: UICollectionView!
    var detailcategory : [DetailCategories] = []
    var product_id : String = ""
    var type : String = ""
    var userid : String = ""
    
    override func viewDidLoad() {
        super.viewDidLoad()
        userid = UserDefaults.standard.string(forKey: "userid")!
        curveView.clipsToBounds = true
              curveView.layer.cornerRadius = 30
              curveView.layer.maskedCorners = [.layerMaxXMinYCorner, .layerMinXMinYCorner]
        print("dd\(detailcategory.count)")
//        self.navigationController?.interactivePopGestureRecognizer?.delegate = self
//        self.navigationController?.interactivePopGestureRecognizer?.isEnabled = true
        collectionviewdetailcategories.showsVerticalScrollIndicator = false
    }
    override func viewWillAppear(_ animated: Bool) {
        
        collectionviewdetailcategories.reloadData()
        
    }
    
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "onstock" {
         let indexPaths=self.collectionviewdetailcategories!.indexPathsForSelectedItems!
         let indexPath = indexPaths[0] as NSIndexPath
         let vc = segue.destination as! GoldOnStockController
                   if detailcategory.isEmpty {
                       
                   } else {
                       vc.goldonstock.removeAll()
                    vc.image = detailcategory[indexPath.row].detailcategories_image
                    vc.id = detailcategory[indexPath.row].gold_item_id
                    vc.gold_stone_kyat = detailcategory[indexPath.row].gold_stone_kyat
                    vc.gold_stone_pae = detailcategory[indexPath.row].gold_stone_pal
                    vc.gold_stone_yae = detailcategory[indexPath.row].gold_stone_yae
                    vc.ayot_kyat = detailcategory[indexPath.row].ayot_kyat
                    vc.ayot_pae = detailcategory[indexPath.row].ayot_pal
                    vc.ayot_yae = detailcategory[indexPath.row].ayot_yae
                    vc.stone_kyat = detailcategory[indexPath.row].stone_kyat
                    vc.stone_pae = detailcategory[indexPath.row].stone_pal
                    vc.stone_yae = detailcategory[indexPath.row].stone_yae
                    vc.stone_value = detailcategory[indexPath.row].stone_value
                    vc.gold_quality = detailcategory[indexPath.row].gold_quality
                    vc.item_code = detailcategory[indexPath.row].detailcategories_name
                    vc.category_id = detailcategory[indexPath.row].category_id
                    vc.currentprice = detailcategory[indexPath.row].currentprice
                    vc.note = detailcategory[indexPath.row].note
                    
                   }
    }
    
    }
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
       if detailcategory.isEmpty {
                  noitem.isHidden = false
                  return 0
       } else {
        noitem.isHidden = true
        return detailcategory.count
        }
       }
       
       func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionviewdetailcategories.dequeueReusableCell(withReuseIdentifier: "detailcategories", for: indexPath) as! DetailCategoriesCell
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
        if detailcategory.isEmpty {
            
        } else {
          
            
        cell.detailcategories_image.kf.setImage(with: URL(string: "http://api.myinthidarjewellery.com/uploads/gold/" + detailcategory[indexPath.row].detailcategories_image), placeholder: UIImage(named: "gold_ring"), options: nil, progressBlock: nil, completionHandler: nil)
        cell.detailcategories_name.text = detailcategory[indexPath.row].detailcategories_name
            if detailcategory[indexPath.row].isselected{
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
       
        self.performSegue(withIdentifier: "onstock", sender: self)
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

    

extension DetailCategoriesController : UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let size:CGFloat = (collectionView.frame.size.width - 70) / 2.0
        return CGSize(width: size, height: 220)
    }
    
}

