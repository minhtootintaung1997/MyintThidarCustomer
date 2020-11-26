//
//  BasketController.swift
//  Myint Thidar Customer
//
//  Created by Kaung Khant Shar on 30/07/2020.
//  Copyright © 2020 Nanolabs. All rights reserved.
//

import Foundation
import UIKit
import Alamofire
import SwiftyJSON


class BasketController : UIViewController, UITableViewDelegate, UITableViewDataSource, CounterDelegatePlus, CounterDelegateMinus, DeleteCard, UITabBarControllerDelegate {
    func deletecard(uibtn: UIButton) {
        if segmentedcontrol.selectedSegmentIndex == 0 {
         let index : Int = uibtn.tag
        if goldbasket.isEmpty {
            
        } else {
           
        let delete : AddtobasketGold = goldbasket[index]
        db.deleteBygolditemid(golditemid: delete.gold_item_id)
        goldbasket.remove(at: index)
         goldbasket = db.read()
        totalbasket = goldbasket
            totalgold = Double(db.sumGold())
        calculateTotalPrice()
        basketableview.reloadData()
    }
    } else if segmentedcontrol.selectedSegmentIndex == 1 {
         let index : Int = uibtn.tag
        if diamondbasket.isEmpty {
            
        } else {
        let delete : AddtobasketDiamond = diamondbasket[index]
            db.deleteBydiamonditemid(diamonditemid: delete.diamond_item_id)
        diamondbasket.remove(at: index)
        diamondbasket = db.readDiamond()
            totalbasket = diamondbasket
            totaldiamond = Double(db.sumTotalDiamond())
        calculateTotalPrice()
        basketableview.reloadData()
    }
    } else if segmentedcontrol.selectedSegmentIndex == 2 {
         let index : Int = uibtn.tag
        if platinumbasket.isEmpty {
            
        } else {
        let delete : AddtobasketPlatinum = platinumbasket[index]
            db.deleteByplatinumitemid(platinumitemid: delete.platinum_item_id)
        platinumbasket.remove(at: index)
        platinumbasket = db.readPlatinum()
            totalbasket = platinumbasket
            totalplatinum = Double(db.sumTotalPlatinum())
        calculateTotalPrice()
        basketableview.reloadData()
    }
    }
    }
    func sendCountPlus(uibtn: UIButton) {
        if segmentedcontrol.selectedSegmentIndex == 0 {
        let index:Int=uibtn.tag
        let add: AddtobasketGold = goldbasket[index]
           
        add.qty+=1
            
        db.updateBygoldID(gold_item_id: add.gold_item_id, qty: add.qty)
            self.gold_item_id = add.gold_item_id
            self.value = Double(add.qty)
            self.total_yway = (add.gold_stone_yae as NSString).doubleValue
            self.total_pll = (add.gold_stone_pal as NSString).doubleValue
            self.total_kyat = (add.gold_stone_kyat as NSString).doubleValue
            self.yorkyway = (add.ayot_yae as NSString).doubleValue
            self.yorkpll = (add.ayot_pal as NSString).doubleValue
            
            self.yorkkyat = (add.ayot_kyat as NSString).doubleValue
            self.kyaukyway = (add.stone_yae as NSString).doubleValue
            self.kyaukpll = (add.stone_pal as NSString).doubleValue
            self.kyaukkyat = (add.stone_kyat as NSString).doubleValue
            self.stonevalue = (add.stone_value as NSString).doubleValue
            self.pauk_zyy = (add.currentSalePrice as NSString).doubleValue
            
        goldbasket = db.read()
        totalbasket = goldbasket
        increaseCountInCard()
        basketableview.reloadData()
            
        } else if segmentedcontrol.selectedSegmentIndex == 1 {
            let index:Int=uibtn.tag
                   let add: AddtobasketDiamond = diamondbasket[index]
                   add.qty+=1
            db.updateBydiamondID(diamond_item_id: add.diamond_item_id, qty: add.qty)
            
            
                   diamondbasket = db.readDiamond()
                   totalbasket = diamondbasket
                   totaldiamond = Double(db.sumTotalDiamond())
            print("diamondcount \(totaldiamond)")
             total = totalgold  + totaldiamond + totalplatinum
            totalprice.text = String(Int(total))
            grand_totalprice.text = String(Int(total))+" ကျပ်၀န်းကျင်"
                   calculateTotalPrice()
                   basketableview.reloadData()
            
        } else if segmentedcontrol.selectedSegmentIndex == 2 {
                   let index:Int=uibtn.tag
                   let add: AddtobasketPlatinum = platinumbasket[index]
                   add.qty+=1
            db.updateByplatinumID(platinum_item_id: add.platinum_item_id, qty: add.qty)
                              platinumbasket = db.readPlatinum()
                              totalbasket = platinumbasket
            totalplatinum = Double(db.sumTotalPlatinum())
            total = totalgold  + totaldiamond + totalplatinum
           totalprice.text = String(Int(total))
           grand_totalprice.text = String(Int(total))+" ကျပ်၀န်းကျင်"
                              calculateTotalPrice()
                              basketableview.reloadData()
        }
    }
    
    func sendCountMinus(uibtn: UIButton) {
        if segmentedcontrol.selectedSegmentIndex == 0 {
            let index:Int=uibtn.tag
            let add: AddtobasketGold = goldbasket[index]
             if add.qty > 1 {
                add.qty-=1
                db.updateBygoldID(gold_item_id: add.gold_item_id, qty: add.qty)
                self.gold_item_id = add.gold_item_id
                self.value = Double(add.qty)
                self.total_yway = (add.gold_stone_yae as NSString).doubleValue
                self.total_pll = (add.gold_stone_pal as NSString).doubleValue
                self.total_kyat = (add.gold_stone_kyat as NSString).doubleValue
                self.yorkyway = (add.ayot_yae as NSString).doubleValue
                self.yorkpll = (add.ayot_pal as NSString).doubleValue
                
                self.yorkkyat = (add.ayot_kyat as NSString).doubleValue
                self.kyaukyway = (add.stone_yae as NSString).doubleValue
                self.kyaukpll = (add.stone_pal as NSString).doubleValue
                self.kyaukkyat = (add.stone_kyat as NSString).doubleValue
                self.stonevalue = (add.stone_value as NSString).doubleValue
                self.pauk_zyy = (add.currentSalePrice as NSString).doubleValue
                
                goldbasket = db.read()
                totalbasket = goldbasket
                decreaseCountInCard()
                basketableview.reloadData()
            }
        } else if segmentedcontrol.selectedSegmentIndex == 1 {
            let index: Int = uibtn.tag
            let add : AddtobasketDiamond = diamondbasket[index]
            if add.qty > 1 {
                add.qty-=1
                db.updateBydiamondID(diamond_item_id: add.diamond_item_id, qty: add.qty)
                diamondbasket = db.readDiamond()
                totalbasket = diamondbasket
                calculateTotalPrice()
                basketableview.reloadData()
            }
            
        } else if segmentedcontrol.selectedSegmentIndex == 2 {
            let index : Int = uibtn.tag
            let add : AddtobasketPlatinum = platinumbasket[index]
            if add.qty > 1 {
                add.qty-=1
                db.updateByplatinumID(platinum_item_id: add.platinum_item_id, qty: add.qty)
                platinumbasket = db.readPlatinum()
                totalbasket = platinumbasket
                calculateTotalPrice()
                basketableview.reloadData()
            }
        }
    }
    
   
    @IBOutlet weak var noitemlbl: UILabel!
    @IBOutlet weak var cartimg: UIImageView!
    @IBOutlet weak var platinumbadge: UILabel!
    @IBOutlet weak var diamondbadge: UILabel!
    @IBOutlet weak var goldbadge: UILabel!
    @IBOutlet weak var grand_totalprice: UILabel!
    @IBOutlet weak var totalprice: UILabel!
    @IBOutlet weak var checkoutView: UIView!
    
    @IBOutlet weak var basketableview: UITableView!
    
    @IBOutlet weak var segmentedcontrol: UISegmentedControl!
    
    @IBOutlet weak var curveView: UIView!
  
    var db:DBHelper = DBHelper()
    var goldbasket : [AddtobasketGold] = []
    var diamondbasket : [AddtobasketDiamond] = []
    var platinumbasket : [AddtobasketPlatinum] = []
    var totalbasket : [AnyObject] = []
    var jsonstring : String = ""
    var gold_item_id : Int = 0
    var finalgoldstring : String = ""
    var finaldiamondstring : String = ""
    var finalplatinumstring : String = ""
    var strgold : String = ""
    var strgold2 : String = ""
    var strdiamond : String = ""
    var strdiamond2 : String = ""
    var strplatinum : String = ""
    var strplatinum2 : String = ""
    var totaldiamond : Double = 0.0
    var totalgold : Double = 0.0
    var totalplatinum : Double = 0.0
    var totalgoldqty : Int = 0
    var totaldiamondqty : Int = 0
    var totalplatinumqty : Int = 0
    var userid : String = ""
    var password : String = ""
    
    var shwe_yway : String = ""
    
    var pauk_zyy : Double = 0.0
          var value : Double = 0.0
    
    var diamondvalue : Double = 0.0
    var diamondprice : Double = 0.0
    
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
    var total : Double = 0.0
    var third_kyat : Double = 0.0
    var third_pll : Double = 0.0
    var third_yway : Double = 0.0
    
     var stonevalue : Double = 0.0
    var final_total : Double = 0.0
    var fin : Double = 0.0
    
    var converttokyat : Double = 0.0
    
    var fourth_kyat : Double = 0.0
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
      calculateTotalPrice()
        print("username\(UserDefaults.standard.string(forKey: "username"))")
        
        password = UserDefaults.standard.string(forKey: "password")!
       print("password\(password)")
        userid = UserDefaults.standard.string(forKey: "userid")!
        
        goldbasket = db.read()
        diamondbasket = db.readDiamond()
        platinumbasket = db.readPlatinum()
        goldlist()
        diamondlist()
        platinumlist()
         
        totalbasket = goldbasket
      
      //  increaseCountInCard()
       basketableview.rowHeight = 120
        basketableview.showsVerticalScrollIndicator = false
        curveView.clipsToBounds = true
        curveView.layer.cornerRadius = 30
        curveView.layer.maskedCorners = [.layerMaxXMinYCorner, .layerMinXMinYCorner]
      

    }
    override func viewWillAppear(_ animated: Bool) {
        self.tabBarController?.delegate = self
        totalgold = Double(db.sumGold())
        totaldiamond = Double(db.sumDiamond())
        self.totalplatinum = Double(db.sumPlatinum())
        calculateTotalPrice()
              goldbasket = db.read()
              diamondbasket = db.readDiamond()
              platinumbasket = db.readPlatinum()
             totalbasket = goldbasket
       
        calculateTotalPrice()
             basketableview.rowHeight = 120
              basketableview.showsVerticalScrollIndicator = false
              curveView.clipsToBounds = true
              curveView.layer.cornerRadius = 30
              curveView.layer.maskedCorners = [.layerMaxXMinYCorner, .layerMinXMinYCorner]
    }
    override func viewDidAppear(_ animated: Bool) {
        
         self.tabBarController?.delegate = self
        calculateTotalPrice()
       
        goldbasket = db.read()
        diamondbasket = db.readDiamond()
        platinumbasket = db.readPlatinum()
        calculateTotalPrice()
    }
    
   func calculateTotalPrice() {
    
            goldbasket = db.read()
           diamondbasket = db.readDiamond()
           platinumbasket = db.readPlatinum()
           
           goldbadge.text = String(db.read().count)
           diamondbadge.text = String(db.readDiamond().count)
           platinumbadge.text = String(db.readPlatinum().count)
   
    
     total = totalgold  + totaldiamond + totalplatinum
    totalprice.text = String(Int(total))
    grand_totalprice.text = String(Int(total))+" ကျပ်၀န်းကျင်"
 
    }
    
    func increaseCountInCard() {
        
        goldcal()
        db.updateBygoldtotalprice(gold_item_id: gold_item_id, totalprice: Int(fin))
        calculateTotalPrice()
    }
    
    func goldcal() {
        
        var shwekyaukyway : Double = 0.0
        var shwekyaukpll : Int = 0
        var shwekyaukkyat : Int = 0
        
        shwekyaukyway = total_yway * value
        shwekyaukpll = Int(total_pll) * Int(value)
        shwekyaukkyat = Int(total_kyat) * Int(value)
        
        var ayorkyway : Double = 0.0
        var ayorkpll : Int = 0
        var ayorkkyat : Int = 0
        
        ayorkyway = yorkyway * value
        ayorkpll = Int(yorkpll) * Int(value)
        ayorkkyat = Int(yorkkyat) * Int(value)
        
        var shwekyaukplusyorkyway : Double = 0.0
        var shwekyaukplusyorkpll : Int = 0
        var shwekyaukplusyorkkyat : Int = 0
        
        shwekyaukplusyorkyway = shwekyaukyway + ayorkyway
        shwekyaukplusyorkpll = shwekyaukpll + ayorkpll
        shwekyaukplusyorkkyat = shwekyaukkyat + ayorkkyat
        
        var kyaukyway : Double = 0.0
        var kyaukpll : Int = 0
        var kyaukkyat : Int = 0
        
        kyaukyway = kyaukyway * value
        kyaukpll = Int(kyaukpll) * Int(value)
        kyaukkyat = Int(kyaukkyat) * Int(value)
        
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
        fin = beforekyat * pauk_zyy
       let stoneV = stonevalue * value
        fin = fin + stoneV
        print("fin is \(fin)")
        
    }
   func decreaseCountInCard() {
        
        if value > 0 {
                             
                           
            goldcal()
            db.updateBygoldtotalprice(gold_item_id: gold_item_id, totalprice: Int(fin))
            calculateTotalPrice()
    }
    
    }
    
    func goldlist() {
        for value in goldbasket {
                    strgold = "{\("\"")\("ayot_kyat")\("\"")\(":")\("\"")\(value.ayot_kyat)\("\"")\(",")\("\"")\("ayot_pal")\("\"")\(":")\("\"")\(value.ayot_pal)\("\"")\(",")\("\"")\("ayot_yae")\("\"")\(":")\("\"")\(value.ayot_yae)\("\"")\(",")\("\"")\("category_id")\("\"")\(":")\(value.category_id)\(",")\("\"")\("currentSalePrice")\("\"")\(":")\("\"")\(value.currentSalePrice)\("\"")\(",")\("\"")\("gold_item_id")\("\"")\(":")\(value.gold_item_id)\(",")\("\"")\("gold_stone_kyat")\("\"")\(":")\("\"")\(value.gold_stone_kyat)\("\"")\(",")\("\"")\("gold_stone_pal")\("\"")\(":")\("\"")\(value.gold_stone_pal)\("\"")\(",")\("\"")\("gold_stone_yae")\("\"")\(":")\("\"")\(value.gold_stone_yae)\("\"")\(",")\("\"")\("id")\("\"")\(":")\(value.id)\(",")\("\"")\("image")\("\"")\(":")\("\"")\(value.image)\("\"")\(",")\("\"")\("itemCode")\("\"")\(":")\("\"")\(value.itemCode)\("\"")\(",")\("\"")\("order_type")\("\"")\(":")\("\"")\(value.order_type)\("\"")\(",")\("\"")\("qty")\("\"")\(":")\(value.qty)\(",")\("\"")\("quality")\("\"")\(":")\("\"")\(value.quantity)\("\"")\(",")\("\"")\("stone_kyat")\("\"")\(":")\("\"")\(value.stone_kyat)\("\"")\(",")\("\"")\("stone_pal")\("\"")\(":")\("\"")\(value.stone_pal)\("\"")\(",")\("\"")\("stone_value")\("\"")\(":")\("\"")\(value.stone_value)\("\"")\(",")\("\"")\("stone_yae")\("\"")\(":")\("\"")\(value.stone_yae)\("\"")\(",")\("\"")\("total_price")\("\"")\(":")\(value.total_price)\(",")\("\"")\("unit")\("\"")\(":")\("\"")\("atine")\("\"")\("}")"
                        strgold2 += "\(strgold)\(",")"
                     }
                       finalgoldstring = "\("[")\(strgold2.dropLast())\("]")"
        print("initial\(finalgoldstring)")
               
//
               
    }
    func diamondlist() {
        for value in diamondbasket {
            strdiamond = "{\("\"")\("category_id")\("\"")\(":")\(value.category_id)\(",")\("\"")\("diamond_alone")\("\"")\(":")\("\"")\(value.diamond_alone)\("\"")\(",")\("\"")\("diamond_item_id")\("\"")\(":")\(value.diamond_item_id)\(",")\("\"")\("diamond_number")\("\"")\(":")\("\"")\(value.diamond_number)\("\"")\(",")\("\"")\("gram")\("\"")\(":")\(value.gram)\(",")\("\"")\("id")\("\"")\(":")\(value.id)\(",")\("\"")\("image")\("\"")\(":")\("\"")\(value.image)\("\"")\(",")\("\"")\("itemCode")\("\"")\(":")\("\"")\(value.itemCode)\("\"")\(",")\("\"")\("price")\("\"")\(":")\(value.price)\(",")\("\"")\("qty")\("\"")\(":")\(value.qty)\(",")\("\"")\("quality")\("\"")\(":")\("\"")\(value.quality)\("\"")\(",")\("\"")\("total_price")\("\"")\(":")\(value.total_price)\(",")\("\"")\("yati")\("\"")\(":")\("\"")\(value.yati)\("\"")\("}")"
           strdiamond2 += "\(strdiamond)\(",")"
        }
        finaldiamondstring = "\("[")\(strdiamond2.dropLast())\("]")"
        print("diamondstring\(finaldiamondstring)")
    }
    func platinumlist() {
        for value in platinumbasket {
            strplatinum = "{\("\"")\("category_id")\("\"")\(":")\(value.category_id)\(",")\("\"")\("platinum_item_id")\("\"")\(":")\(value.platinum_item_id)\(",")\("\"")\("gram")\("\"")\(":")\(value.gram)\(",")\("\"")\("id")\("\"")\(":")\(value.id)\(",")\("\"")\("image")\("\"")\(":")\("\"")\(value.image)\("\"")\(",")\("\"")\("itemCode")\("\"")\(":")\("\"")\(value.itemCode)\("\"")\(",")\("\"")\("price")\("\"")\(":")\(value.price)\(",")\("\"")\("qty")\("\"")\(":")\(value.qty)\(",")\("\"")\("quality")\("\"")\(":")\("\"")\(value.quality)\("\"")\(",")\("\"")\("total_price")\("\"")\(":")\(value.total_price)\("}")"
            strplatinum2 += "\(strplatinum)\(",")"
        }
        finalplatinumstring = "\("[")\(strplatinum2.dropLast())\("]")"
    }
    
    
    @IBAction func segmentedValueChanged(_ sender: Any) {
        self.basketableview.reloadData()
    }
    
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
       
            checkoutView.isHidden = false
        if segmentedcontrol.selectedSegmentIndex == 0 {
            if self.totalbasket.count == 0 {
                cartimg.isHidden = false
                noitemlbl.isHidden = false
                noitemlbl.text = "No item in gold basket"
                return 0
            } else {
                cartimg.isHidden = true
                noitemlbl.isHidden = true
              return  totalbasket.count
            }
        } else if segmentedcontrol.selectedSegmentIndex == 1 {
            if self.totalbasket.count == 0 {
                          cartimg.isHidden = false
                          noitemlbl.isHidden = false
                          noitemlbl.text = "No item in diamond basket"
                          return 0
                      } else {
                          cartimg.isHidden = true
                          noitemlbl.isHidden = true
                        return  totalbasket.count
                      }
            
        } else if segmentedcontrol.selectedSegmentIndex == 2 {
            if self.totalbasket.count == 0 {
                          cartimg.isHidden = false
                          noitemlbl.isHidden = false
                          noitemlbl.text = "No item in platinum basket"
                          return 0
                      } else {
                          cartimg.isHidden = true
                          noitemlbl.isHidden = true
                        return  totalbasket.count
                      }
        
        }
        return totalbasket.count
       }
    
       func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = basketableview.dequeueReusableCell(withIdentifier: "basketcell", for: indexPath) as! BasketCell
      
        cell.contentView.layer.cornerRadius = 10.0
        cell.contentView.layer.borderWidth = 1.0
        cell.contentView.layer.borderColor = UIColor.clear.cgColor
        cell.contentView.layer.masksToBounds = true
        cell.layer.shadowColor = UIColor.lightGray.cgColor
        cell.layer.shadowOffset = CGSize(width: 0, height: 2.0)
        cell.layer.shadowRadius = 2.0
        cell.layer.shadowOpacity = 1.0
        cell.layer.masksToBounds = false
        cell.deletecard.tag = indexPath.row
        cell.deletedelegate=self
        cell.delegateminus = self
        cell.delegatePlus = self
        cell.plus.tag = indexPath.row
        cell.minus.tag = indexPath.row
      
        self.calculateTotalPrice()
        if totalbasket.isEmpty {
                
            } else {
                if segmentedcontrol.selectedSegmentIndex == 0 {
                    if goldbasket.isEmpty {
                        
                    }
                    else {
//
                    cell.item_code.text = goldbasket[indexPath.row].itemCode
                    if goldbasket[indexPath.row].order_type == "InStock" {
                        cell.price.text = "Ks : \(Int(goldbasket[indexPath.row].realtotal_price))"
                                             
                        totalgold = Double(db.sumGold())
                         self.calculateTotalPrice()
                    } else {
                        cell.price.text = goldbasket[indexPath.row].order_type
                    }

                    cell.shwe_yi.text = "Quality : \(goldbasket[indexPath.row].quantity)"
                    cell.item_image.kf.setImage(with: URL(string: "http://api.myinthidarjewellery.com/uploads/gold/\(goldbasket[indexPath.row].image)"), placeholder: UIImage(named: "gold_ring"), options: nil, progressBlock: nil, completionHandler: nil)
                        
                    cell.count.text = "\(goldbasket[indexPath.row].qty)"

                       
                    }
            }
                
                else if segmentedcontrol.selectedSegmentIndex == 1{
                    if diamondbasket.isEmpty {
                        
                    } else {
                    cell.item_code.text = diamondbasket[indexPath.row].itemCode

                    cell.item_image.kf.setImage(with: URL(string: "http://api.myinthidarjewellery.com/uploads/diamond/\(diamondbasket[indexPath.row].image)"), placeholder: UIImage(named: "gold_ring"), options: nil, progressBlock: nil, completionHandler: nil)
                    cell.shwe_yi.text = "Quality : \(diamondbasket[indexPath.row].quality)"
                    cell.price.text = "Price : \(diamondbasket[indexPath.row].price)"
                    cell.count.text = "\(diamondbasket[indexPath.row].qty)"
                        totaldiamond = Double(db.sumTotalDiamond())
                        self.calculateTotalPrice()
                    }
            }
                else if segmentedcontrol.selectedSegmentIndex == 2 {
                    if platinumbasket.isEmpty {
                        
                    } else {
                    cell.item_code.text = platinumbasket[indexPath.row].itemCode
                    cell.item_image.kf.setImage(with: URL(string: "http://api.myinthidarjewellery.com/uploads/platinum/\(platinumbasket[indexPath.row].image)"), placeholder: UIImage(named: "gold_ring"), options: nil, progressBlock: nil, completionHandler: nil)
                    cell.shwe_yi.text = "Grade : \(platinumbasket[indexPath.row].quality)"
                    cell.price.text = "Price : \(platinumbasket[indexPath.row].price)"
                    cell.count.text = "\(platinumbasket[indexPath.row].qty)"
                        
                        self.totalplatinum = Double(db.sumTotalPlatinum())
                        self.calculateTotalPrice()
            }
            }
                }
        
      
        
        return cell
       }
    @IBAction func backAction(_ sender: Any) {
        navigationController?.popViewController(animated: true)
        dismiss(animated: true, completion: nil)
        
    }
    @IBAction func segmentedControlAction(_ sender: Any) {
        if segmentedcontrol.selectedSegmentIndex == 0  {
            print("0")
            totalbasket.removeAll()
            totalbasket = db.read()
            calculateTotalPrice()
            basketableview.reloadData()
             
            
            
        }
      else  if segmentedcontrol.selectedSegmentIndex == 1 {
            print("1")
            totalbasket.removeAll()
            totalbasket = db.readDiamond()
            calculateTotalPrice()
            basketableview.reloadData()
           
            
        }
      else  if segmentedcontrol.selectedSegmentIndex == 2 {
            totalbasket.removeAll()
            totalbasket = db.readPlatinum()
            calculateTotalPrice()
            basketableview.reloadData()
            
            
        }
    }
    
    
    
      func storeorder(){
                   
                   let parameters: [String: Any] = [
                    "gold_list" : finalgoldstring,
                       "diamond_list" : finaldiamondstring,
                       "platinum_list" : finalplatinumstring,
                       "customer_id" : userid,
                          ]
                       
                       Alamofire.request("http://api.myinthidarjewellery.com/api/order/create", method: .post, parameters: parameters).responseJSON { (myresponse) in
                           
                           switch myresponse.result {
                           case .success:

                            print("ordereduserid\(self.userid)")
                               //self.db.dropRow()
                            
                            self.db.dropGoldRow()
                            self.db.dropDiamondRow()
                            self.db.dropPlatinumRow()
                               let myresults =  JSON(myresponse.data!)
                            _ = myresults
                               
                               if let json = myresponse.data {
                                                            
                                _ = try? JSON(data: json)
 
                            }
                                self.performSegue(withIdentifier: "aaa", sender: self)
                               
                               break
                           case .failure:
                            print(self.finalgoldstring)
                            print(self.finaldiamondstring)
                            print(self.finalplatinumstring)
                            
                            
                            let alertController = UIAlertController(title: "MTD Alert", message: "Order failed. Please try again.", preferredStyle: .alert)
                                                                                              
                                               let action2 = UIAlertAction(title: "Cancel", style: .cancel) { (action:UIAlertAction) in
                                                                                                 
                                                   print("You've pressed cancel");
                                                                                              }
                                                                                      
                                                                                     
                                               alertController.addAction(action2)

                                                                                     
                                               self.present(alertController, animated: true, completion: nil)
                            print("failure")
                               break
                           }
                       }
        }
    @IBAction func checkoutAction(_ sender: Any) {
        
        if goldbasket.isEmpty && diamondbasket.isEmpty && platinumbasket.isEmpty {
            let alertController = UIAlertController(title: "MTD Alert", message: "No item in basket. Please choose first.", preferredStyle: .alert)
             let action2 = UIAlertAction(title: "Cancel", style: .cancel) { (action:UIAlertAction) in
              }
               alertController.addAction(action2)
          self.present(alertController, animated: true, completion: nil)
        } else {
        
          let alert = UIAlertController(title: "Password Required", message: "Enter your password to confirm order.", preferredStyle: UIAlertController.Style.alert)

            alert.addTextField { (textField) in
                                  textField.placeholder = "Enter your passord"
                               }
         alert.addAction(UIAlertAction(title: "Confirm", style: .default, handler: { [weak alert] (_) in
                                guard let textField = alert?.textFields?[0], let userText = textField.text else { return }
            if userText == self.password {
                self.storeorder()
            } else {
                
            }
            
               
         }))

         alert.addAction(UIAlertAction(title: "Cancel", style: .cancel, handler: { (action: UIAlertAction!) in
              
         }))

         present(alert, animated: true, completion: nil)
        
        
    
        }
        
    }
   
}
