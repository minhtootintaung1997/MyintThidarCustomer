//
//  DiamondDetailController.swift
//  Myint Thidar Customer
//
//  Created by Kaung Khant Shar on 28/07/2020.
//  Copyright © 2020 Nanolabs. All rights reserved.
//

import Foundation
import UIKit
import Alamofire
import SwiftyJSON


class DiamondDetailController : UIViewController, UICollectionViewDelegate, UICollectionViewDataSource, UIGestureRecognizerDelegate, SeemoreDiamondClickAction  {
    func wishClick(btn1: UIButton, btn2: UIButton) {
        let index : Int = btn1.tag
        let add : DetailDiamondCategories = diamonddetail[btn2.tag]
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
         diamonddetail[btn2.tag] = add
        diamondcollectionview.reloadData()
        
    }
    
    
    
   
    @IBOutlet weak var diamondcollectionview: UICollectionView!
    
    @IBOutlet weak var noitem: UILabel!
    @IBOutlet weak var curveView: UIView!
    var diamonddetail : [DetailDiamondCategories] = []
    var product_id : String = ""
    var type : String = ""
    var userid : String = ""
    
    override func viewDidLoad() {
        super.viewDidLoad()
        userid = UserDefaults.standard.string(forKey: "userid")!
        curveView.clipsToBounds = true
        curveView.layer.cornerRadius = 30
        curveView.layer.maskedCorners = [.layerMaxXMinYCorner, .layerMinXMinYCorner]
//         self.navigationController?.interactivePopGestureRecognizer?.delegate = self
//         self.navigationController?.interactivePopGestureRecognizer?.isEnabled = true
        diamondcollectionview.showsVerticalScrollIndicator = false
        
    }
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
         if segue.identifier == "diamondinstock" {
                let indexPaths=self.diamondcollectionview!.indexPathsForSelectedItems!
                let indexPath = indexPaths[0] as NSIndexPath
                let vc = segue.destination as! DiamondInstockController
                          if diamonddetail.isEmpty {
                              
                          } else {
                             
                            vc.price = diamonddetail[indexPath.row].price
                            vc.item_code = diamonddetail[indexPath.row].item_code
                            vc.imagev = diamonddetail[indexPath.row].image
                            vc.gram = diamonddetail[indexPath.row].gram
                            vc.diamond_quality = diamonddetail[indexPath.row].diamond_quality
                            vc.category_id = diamonddetail[indexPath.row].category_id
                            vc.diamond_item_id = diamonddetail[indexPath.row].diamond_item_id
                            vc.quality = diamonddetail[indexPath.row].quality
                            vc.diamond_kyat = diamonddetail[indexPath.row].diamond_kyat
                            vc.diamond_pal = diamonddetail[indexPath.row].diamond_pal
                            vc.diamond_yae = diamonddetail[indexPath.row].diamond_yae
                            vc.diamond_number = diamonddetail[indexPath.row].diamond_number
                            vc.diamond_alone = diamonddetail[indexPath.row].diamond_alone
                          }
           }
    }
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if diamonddetail.isEmpty {
                   noitem.isHidden = false
                   return 0
        } else {
            noitem.isHidden = true
       return diamonddetail.count
    }
    }
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = diamondcollectionview.dequeueReusableCell(withReuseIdentifier: "diamondcell", for: indexPath) as! DetailDiamondCell
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
        if diamonddetail.isEmpty {
            
        } else {
        cell.diamond_image.kf.setImage(with: URL(string: "http://api.myinthidarjewellery.com/uploads/diamond/\(diamonddetail[indexPath.row].image)"), placeholder: UIImage(named: "gold_ring"), options: nil, progressBlock: nil, completionHandler: nil)
        cell.diamond_name.text = diamonddetail[indexPath.row].item_code
        if diamonddetail[indexPath.row].isselected{
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
        self.performSegue(withIdentifier: "diamondinstock", sender: self)
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
extension DiamondDetailController : UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let size:CGFloat = (collectionView.frame.size.width - 70) / 2.0
        return CGSize(width: size, height: 220)
    }
    
}
