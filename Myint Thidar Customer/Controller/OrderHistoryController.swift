//
//  OrderHistoryController.swift
//  Myint Thidar Customer
//
//  Created by Kaung Khant Shar on 11/08/2020.
//  Copyright © 2020 Nanolabs. All rights reserved.
//

import Foundation
import UIKit
import Alamofire
import SwiftyJSON
import Kingfisher
class OrderHistoryController : UIViewController, UITableViewDelegate, UITableViewDataSource {
   
    @IBOutlet weak var segmentedControl: UISegmentedControl!
    @IBOutlet weak var curveView: UIView!
    @IBOutlet weak var ordertableview: UITableView!
    @IBOutlet weak var noorderlbl: UILabel!
    
    
    
    var goldorderhistory:[GoldOrderHistory]=[]
    var diamondorderhistory:[DiamondOrderHistory]=[]
    var platinumorderhistory:[PlatinumOrderHistory]=[]
    var totalorderhistory : [AnyObject] = []
    var userid : String = ""
    var goldordertype : [String] = []
     var refreshControl = UIRefreshControl()
     var indicator = UIActivityIndicatorView()
    override func viewDidLoad() {
        super.viewDidLoad()
        userid = UserDefaults.standard.string(forKey: "userid")!
       
        print("userid\(userid)")
        activityIndicator()
        indicator.startAnimating()
        indicator.backgroundColor = .clear
//        refreshControl.attributedTitle = NSAttributedString(string: "Pull to refresh")
//        refreshControl.addTarget(self, action: #selector(self.refresh(_:)), for: .valueChanged)
//        ordertableview.addSubview(refreshControl) // not required when using UITableViewController
        loadgoldinstockorder()
        loaddiamondorder()
        loadplatinumorder()
        //loadgoldcustomorder()
        ordertableview.rowHeight = 140
        curveView.clipsToBounds = true
          curveView.layer.cornerRadius = 30
          curveView.layer.maskedCorners = [.layerMaxXMinYCorner, .layerMinXMinYCorner]
        
    }
   
    func activityIndicator() {
           indicator = UIActivityIndicatorView(frame: CGRect(x: 0, y: 0, width: 40, height: 40))
           indicator.style = UIActivityIndicatorView.Style.medium
           indicator.center = self.view.center
           self.view.addSubview(indicator)
       }
    
    
    func loadgoldinstockorder(){
              
              let parameters: [String: Any] = [
              "user_id" : userid
                             
                       ]
                       
                       Alamofire.request("http://api.myinthidarjewellery.com/api/gold/order/user", method: .post,parameters: parameters).responseJSON { (myresponse) in
                           
                           switch myresponse.result {
                           case .success:
                               
                               let myresults = try? JSON(data: myresponse.data!)
                              
                               
                               let resultArray = myresults
                                self.goldorderhistory.removeAll()
                               for i in resultArray!.arrayValue{
                                let goldorder_type = i["category"].stringValue
                                self.goldordertype.append(goldorder_type)
                               let pp = JSON(i["gold_order"])
                                 //  self.goldorderhistory.removeAll()
                                 for ii in pp.arrayValue {
                                  
                                   let ppp = JSON(ii["gold"])
                                  
                                   for iii in ppp.arrayValue {
                                    if i["category"].stringValue == "gold_instock" {
                                        
                                        self.goldorderhistory.append(GoldOrderHistory(order_id: ii["order_id"].stringValue, total_price: ii["total_price"].stringValue, qty: ii["qty"].stringValue, current_price: ii["current_price"].stringValue, status: ii["status"].stringValue, description: ii["description"].stringValue, image: iii["image"].stringValue, item_code: iii["item_code"].stringValue, gram: iii["gram"].stringValue, gold_kyat: iii["gold_kyat"].stringValue, gold_pal: iii["gold_pal"].stringValue, gold_yae: iii["gold_yae"].stringValue, ayot_kyat: iii["ayot_kyat"].stringValue, ayot_pal: iii["ayot_pal"].stringValue, ayot_yae: iii["ayot_yae"].stringValue, stone_kyat: iii["stone_kyat"].stringValue, stone_pal: iii["stone_pal"].stringValue, stone_yae: iii["stone_yae"].stringValue, stone_value: iii["stone_value"].stringValue, gold_quality: iii["gold_quality"].stringValue, note: iii["note"].stringValue, created_at: iii["created_at"].stringValue))
                                    
                                   self.totalorderhistory = self.goldorderhistory
                                    } else {
                                        print("to gold custom")
                                    }
                                   }
                                  
                                 }
                               
                                  
                                self.ordertableview.reloadData()
                                self.indicator.stopAnimating()
                                self.indicator.hidesWhenStopped = true
                                   
                               }
                              
                               break
                           case .failure:
                               break
                           }

                       }
                       
                   }
    
    func loadgoldcustomorder(){
    
    let parameters: [String: Any] = [
    "user_id" : userid
                   
             ]
             
             Alamofire.request("http://api.myinthidarjewellery.com/api/gold/order/user", method: .post,parameters: parameters).responseJSON { (myresponse) in
                 
                 switch myresponse.result {
                 case .success:
                     
                     let myresults = try? JSON(data: myresponse.data!)
                    
                     
                     let resultArray = myresults
                      self.goldorderhistory.removeAll()
                     for i in resultArray!.arrayValue{
                      let goldorder_type = i["category"].stringValue
                      self.goldordertype.append(goldorder_type)
                     let pp = JSON(i["gold_order"])
                       //  self.goldorderhistory.removeAll()
                       for ii in pp.arrayValue {
                        
                         let ppp = JSON(ii["gold"])
                        
                         for iii in ppp.arrayValue {
                          if i["category"].stringValue == "gold_custom" {
                           //  print(ppp.arrayValue)
//                            self.goldorderhistory.append(OrderHistory(ordered_image: iii["image"].stringValue, ordered_id: ii["order_id"].stringValue, ordered_date: ii["created_at"].stringValue, ordered_price: ii["total_price"].stringValue, ordered_status: ii["status"].stringValue, goldorder_type: i["category"].stringValue, item_code: iii["item_code"].stringValue, gold_kyat: iii["gold_kyat"].stringValue, gold_pal: iii["gold_pal"].stringValue, gold_yae: iii["gold_yae"].stringValue, ayot_kyat: iii["ayot_kyat"].stringValue, ayot_pal: iii["ayot_pal"].stringValue, ayot_yae: iii["ayot_yae"].stringValue, stone_kyat: iii["stone_kyat"].stringValue, stone_pal: iii["stone_pal"].stringValue, stone_yae: iii["stone_yae"].stringValue, stone_value: iii["stone_value"].stringValue, gold_quality: iii["gold_quality"].stringValue, currentSalePrice: iii["currentSalePrice"].stringValue, qty: iii["qty"].stringValue, note: ii["note"].stringValue, description: ii["description"].stringValue, gold_stone_kyat: ii["gold_stone_kyat"].stringValue, gold_stone_pal: ii["gold_stone_pal"].stringValue, gold_stone_yae: ii["gold_stone_yae"].stringValue,diamond_quality: "", diamond_kyat: "", diamond_pal: "", diamond_yae: "", diamond_number: "", yati: "", diamond_alone: "", price: "", current_price: "",gram: "", platinum_quality: ""))
                              self.totalorderhistory = self.goldorderhistory
                          } else {
                              print("to gold custom")
                          }
                         }
                        
                       }
                     
                        
                      self.ordertableview.reloadData()
                      self.indicator.stopAnimating()
                      self.indicator.hidesWhenStopped = true
                         
                     }
                    
                     break
                 case .failure:
                     break
                 }

             }
             
         }
    
    func loaddiamondorder(){
                 
                 let parameters: [String: Any] = [
                 "user_id" : userid
                                
                          ]
                          
                          Alamofire.request("http://api.myinthidarjewellery.com/api/diamond/order/user", method: .post,parameters: parameters).responseJSON { (myresponse) in
                              
                              switch myresponse.result {
                              case .success:
                                  
                                  let myresults = try? JSON(data: myresponse.data!)
                                 
                                  
                                  let resultArray = myresults
                                  self.diamondorderhistory.removeAll()
                                  for i in resultArray!.arrayValue{
                                  let pp = JSON(i["diamond_order"])
                                    //  self.goldorderhistory.removeAll()
                                    for ii in pp.arrayValue {
                                        self.diamondorderhistory.append(DiamondOrderHistory(order_id: ii["order_id"].stringValue, price: ii["price"].stringValue, qty: ii["qty"].stringValue, diamond_number: ii["diamond_number"].stringValue, diamond_alone: ii["diamond_alone"].stringValue, status: ii["status"].stringValue, description: ii["description"].stringValue, created_at: ii["created_at"].stringValue))
                                      
                                        self.totalorderhistory = self.diamondorderhistory
                                     
                                     
                                    }
                                  
                                     
                                      self.ordertableview.reloadData()
                                    self.indicator.stopAnimating()
                                    self.indicator.hidesWhenStopped = true
                                      
                                  }
                                 
                                  break
                              case .failure:
                                  break
                              }

                          }
                          
                      }
    
    func loadplatinumorder(){
                 
                 let parameters: [String: Any] = [
                 "user_id" : userid
                                
                          ]
                          
                          Alamofire.request("http://api.myinthidarjewellery.com/api/platinum/order/user", method: .post,parameters: parameters).responseJSON { (myresponse) in
                              
                              switch myresponse.result {
                              case .success:
                                  
                                  let myresults = try? JSON(data: myresponse.data!)
                                 
                                  
                                  let resultArray = myresults
                                  self.platinumorderhistory.removeAll()
                                  for i in resultArray!.arrayValue{
                                  let pp = JSON(i["platinum_order"])
                                    //  self.goldorderhistory.removeAll()
                                    for ii in pp.arrayValue {
                                        
                                        self.platinumorderhistory.append(PlatinumOrderHistory(order_id: ii["order_id"].stringValue, price: ii["price"].stringValue, qty: ii["qty"].stringValue, status: ii["status"].stringValue, description: ii["description"].stringValue, created_at: ii["created_at"].stringValue))
                                       self.totalorderhistory = self.platinumorderhistory
                                     }
                                  
                                     
                                      self.ordertableview.reloadData()
                                    self.indicator.stopAnimating()
                                    self.indicator.hidesWhenStopped = true
                                      
                                  }
                                 
                                  break
                              case .failure:
                                  break
                              }

                          }
                          
                      }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "goldhistory" {
           let indexPaths=self.ordertableview!.indexPathsForSelectedRows!
           let indexPath = indexPaths[0] as NSIndexPath
            let vc = segue.destination as! GoldhistoryDetailController
            vc.imgS = goldorderhistory[indexPath.row].image
            vc.itemcodeS = goldorderhistory[indexPath.row].item_code
            vc.totalpriceS = goldorderhistory[indexPath.row].total_price
            vc.shwe_yiS = goldorderhistory[indexPath.row].gold_quality
            vc.shwekyatS = goldorderhistory[indexPath.row].gold_kyat
            vc.shwePlS = goldorderhistory[indexPath.row].gold_pal
            vc.shweywayS = goldorderhistory[indexPath.row].gold_yae
            vc.yorkkyat_S = goldorderhistory[indexPath.row].ayot_kyat
            vc.yorkpll_S = goldorderhistory[indexPath.row].ayot_pal
            vc.yorkyway_S = goldorderhistory[indexPath.row].ayot_yae
            vc.kyaukpoeS = goldorderhistory[indexPath.row].stone_value
            vc.kyaukkyatS = goldorderhistory[indexPath.row].stone_kyat
            vc.kyaukpllS = goldorderhistory[indexPath.row].stone_pal
            vc.kyaukywayS = goldorderhistory[indexPath.row].stone_yae
            vc.quantityS = goldorderhistory[indexPath.row].qty
            vc.priceS = goldorderhistory[indexPath.row].current_price
            vc.note = goldorderhistory[indexPath.row].note
            
            
            
        }
//        else if segue.identifier == "goldcustomhistory" {
//            let indexPaths=self.ordertableview!.indexPathsForSelectedRows!
//            let indexPath = indexPaths[0] as NSIndexPath
//             let vc = segue.destination as! GoldcustomhistorydetailController
////            vc.imgs = totalorderhistory[indexPath.row].ordered_image
////            vc.itemcodes = totalorderhistory[indexPath.row].item_code
////            vc.shweyis = totalorderhistory[indexPath.row].gold_quality
////            vc.prices = totalorderhistory[indexPath.row].currentSalePrice
////            vc.atais = totalorderhistory[indexPath.row].note
////            vc.notes = totalorderhistory[indexPath.row].description
////            vc.quantitys = totalorderhistory[indexPath.row].qty
////            vc.shwelays = totalorderhistory[indexPath.row].gold_stone_kyat
////            vc.shwelaypls = totalorderhistory[indexPath.row].gold_stone_pal
////            vc.shwelayyways = totalorderhistory[indexPath.row].gold_stone_yae
//        }
//        else if segue.identifier == "diamondorderhistory" {
//            let indexPaths=self.ordertableview!.indexPathsForSelectedRows!
//                       let indexPath = indexPaths[0] as NSIndexPath
//                        let vc = segue.destination as! DiamondhistorydetailController
//            vc.imgs = diamondorderhistory[indexPath.row].description
//            vc.itemcodes = diamondorderhistory[indexPath.row].item
//            vc.shweyis = diamondorderhistory[indexPath.row].
//            vc.weightkyats = totalorderhistory[indexPath.row].diamond_kyat
//            vc.weightpls = totalorderhistory[indexPath.row].diamond_pal
//            vc.weightyways = totalorderhistory[indexPath.row].diamond_yae
//            vc.apwintyays = totalorderhistory[indexPath.row].diamond_number
//            vc.yatis = totalorderhistory[indexPath.row].yati
//            vc.quantitys = totalorderhistory[indexPath.row].qty
//            vc.totalprices = totalorderhistory[indexPath.row].current_price
//            vc.grandtotal_prices = totalorderhistory[indexPath.row].price
//            vc.alonecees = totalorderhistory[indexPath.row].diamond_alone
//            
//            
//        } else if segue.identifier == "platinumorderhistory" {
//            let indexPaths=self.ordertableview!.indexPathsForSelectedRows!
//            let indexPath = indexPaths[0] as NSIndexPath
//             let vc = segue.destination as! PlatinumhistorydetailController
////            vc.imgs = totalorderhistory[indexPath.row].ordered_image
////            vc.itemcodes = totalorderhistory[indexPath.row].item_code
////            vc.shweyis = totalorderhistory[indexPath.row].platinum_quality
////            vc.laychains = totalorderhistory[indexPath.row].gram
////            vc.quantitys = totalorderhistory[indexPath.row].qty
////            vc.totalprices = totalorderhistory[indexPath.row].currentSalePrice
////            vc.grandtotal_prices = totalorderhistory[indexPath.row].price
////            vc.note = totalorderhistory[indexPath.row].note
//            
//        }
    }
    

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if totalorderhistory.isEmpty {
            noorderlbl.isHidden = false
            return 0
        } else {
            noorderlbl.isHidden = true
            return totalorderhistory.count
        }
        
       }
       
       func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = ordertableview.dequeueReusableCell(withIdentifier: "cell", for: indexPath)as! OrderHistoryCell
        if goldorderhistory.isEmpty {
            
        } else {
            if segmentedControl.selectedSegmentIndex == 0 {
                  let dateFormatterGet = DateFormatter()
                                         dateFormatterGet.dateFormat = "yyyy-MM-dd HH:mm:ss"
                                        
                                        let dateFormatterPrint = DateFormatter()
                                        dateFormatterPrint.dateFormat = "MMM dd,yyyy"
                                        
                                        let date: NSDate? = dateFormatterGet.date(from: goldorderhistory[indexPath.row].created_at) as NSDate?
                                        //print(dateFormatterPrint.string(from: date! as Date))
                                        cell.ordered_date.text = dateFormatterPrint.string(from: date! as Date)
                                        
                                        cell.ordered_image.kf.setImage(with: URL(string: "http://api.myinthidarjewellery.com/uploads/gold/\(goldorderhistory[indexPath.row].image)"), placeholder: UIImage(named: "gold_ring"), options: nil, progressBlock: nil, completionHandler: nil)
                                    
                                    cell.ordered_id.text = "Order id#\(goldorderhistory[indexPath.row].order_id)"
                                   
                                    cell.ordered_price.text = goldorderhistory[indexPath.row].total_price
                                    cell.ordered_status.text = goldorderhistory[indexPath.row].status
                       // cell.ordered_status.text = goldordertype[indexPath.row]
                    
                
                }
                
                
                
             else if segmentedControl.selectedSegmentIndex == 2 {
                                    let dateFormatterGet = DateFormatter()
                                         dateFormatterGet.dateFormat = "yyyy-MM-dd HH:mm:ss"

                                        let dateFormatterPrint = DateFormatter()
                                        dateFormatterPrint.dateFormat = "MMM dd,yyyy"

                                        let date: NSDate? = dateFormatterGet.date(from: diamondorderhistory[indexPath.row].created_at) as NSDate?
                                        //print(dateFormatterPrint.string(from: date! as Date))
                                        cell.ordered_date.text = dateFormatterPrint.string(from: date! as Date)

                                        cell.ordered_image.kf.setImage(with: URL(string: "http://api.myinthidarjewellery.com/uploads/gold/\(diamondorderhistory[indexPath.row].description)"), placeholder: UIImage(named: "gold_ring"), options: nil, progressBlock: nil, completionHandler: nil)

                                    cell.ordered_id.text = "Order id#\(diamondorderhistory[indexPath.row].order_id)"

                                    cell.ordered_price.text = diamondorderhistory[indexPath.row].price
                                    cell.ordered_status.text = diamondorderhistory[indexPath.row].status
                

              
            } else if segmentedControl.selectedSegmentIndex == 3 {
               let dateFormatterGet = DateFormatter()
                                   dateFormatterGet.dateFormat = "yyyy-MM-dd HH:mm:ss"
                                  
                                  let dateFormatterPrint = DateFormatter()
                                  dateFormatterPrint.dateFormat = "MMM dd,yyyy"
                                  
                                  let date: NSDate? = dateFormatterGet.date(from: platinumorderhistory[indexPath.row].created_at) as NSDate?
                                  //print(dateFormatterPrint.string(from: date! as Date))
                                //  cell.ordered_date.text = dateFormatterPrint.string(from: date! as Date)
                                  
                                  cell.ordered_image.kf.setImage(with: URL(string: "http://api.myinthidarjewellery.com/uploads/diamond/\(platinumorderhistory[indexPath.row].description)"), placeholder: UIImage(named: "gold_ring"), options: nil, progressBlock: nil, completionHandler: nil)
                              
                              cell.ordered_id.text = "Order id#\(platinumorderhistory[indexPath.row].order_id)"
                             
                              cell.ordered_price.text = platinumorderhistory[indexPath.row].price
                              cell.ordered_status.text = platinumorderhistory[indexPath.row].status
                             
            }
            else if segmentedControl.selectedSegmentIndex == 1 {
//                let dateFormatterGet = DateFormatter()
//                                     dateFormatterGet.dateFormat = "yyyy-MM-dd HH:mm:ss"
//
//                                    let dateFormatterPrint = DateFormatter()
//                                    dateFormatterPrint.dateFormat = "MMM dd,yyyy"
//
//                                    let date: NSDate? = dateFormatterGet.date(from: totalorderhistory[indexPath.row].ordered_date) as NSDate?
//                                    //print(dateFormatterPrint.string(from: date! as Date))
//                                   // cell.ordered_date.text = dateFormatterPrint.string(from: date! as Date)
//
//                                    cell.ordered_image.kf.setImage(with: URL(string: "http://api.myinthidarjewellery.com/uploads/platinum/\(totalorderhistory[indexPath.row].ordered_image)"), placeholder: UIImage(named: "gold_ring"), options: nil, progressBlock: nil, completionHandler: nil)
//
//                                cell.ordered_id.text = "Order id#\(totalorderhistory[indexPath.row].ordered_id)"
//
//                                cell.ordered_price.text = totalorderhistory[indexPath.row].ordered_price
//                                cell.ordered_status.text = totalorderhistory[indexPath.row].ordered_status
            }
             
        }
        return cell
       }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if segmentedControl.selectedSegmentIndex == 0 {
        self.performSegue(withIdentifier: "goldhistory", sender: self)
        } else if segmentedControl.selectedSegmentIndex == 1 {
            self.performSegue(withIdentifier: "goldcustomhistory", sender: self)
        } else if segmentedControl.selectedSegmentIndex == 2 {
            self.performSegue(withIdentifier: "diamondorderhistory", sender: self)
        } else if segmentedControl.selectedSegmentIndex == 3 {
            self.performSegue(withIdentifier: "platinumorderhistory", sender: self)
        }
    
    }
    
    @IBAction func segmentedAction(_ sender: Any) {
        if segmentedControl.selectedSegmentIndex == 0 {
            totalorderhistory.removeAll()
        
            loadgoldinstockorder()

           ordertableview.reloadData()

        }
//        else if segmentedControl.selectedSegmentIndex == 1 {
//           totalorderhistory.removeAll()
//
//                      loadgoldcustomorder()
//
//                     ordertableview.reloadData()
//
//        }
        else if segmentedControl.selectedSegmentIndex == 2 {
           totalorderhistory.removeAll()
                      loaddiamondorder()
                      ordertableview.reloadData()

        } else if segmentedControl.selectedSegmentIndex == 3 {
            totalorderhistory.removeAll()
                       loadplatinumorder()
                       ordertableview.reloadData()
        }
    }
    
}
