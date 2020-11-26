//
//  OrderlistController.swift
//  Myint Thidar Customer
//
//  Created by Kaung Khant Shar on 21/08/2020.
//  Copyright © 2020 Nanolabs. All rights reserved.
//

import Foundation
import UIKit
import Alamofire
import SwiftyJSON

class OrderlistController : UIViewController, UITableViewDataSource, UITableViewDelegate {
    
    @IBOutlet weak var curveView: UIView!
    @IBOutlet weak var orerlisttableview: UITableView!
    var orderlist : [Orderlist] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        loadorderlist()
        orerlisttableview.rowHeight = 150
               curveView.clipsToBounds = true
               curveView.layer.cornerRadius = 30
               curveView.layer.maskedCorners = [.layerMaxXMinYCorner, .layerMinXMinYCorner]
    }
    
    func loadorderlist(){
             
             let parameters: [String: Any] = [
             "user_name" : "TSZ20190919_124433"
           
                            
                      ]
                      
                      Alamofire.request("http://app.myinthidarjewellery.com/mtd//orderhistory.php", method: .post,parameters: parameters).responseJSON { (myresponse) in
                          
                          switch myresponse.result {
                          case .success:
                              
                              let myresults = try? JSON(data: myresponse.data!)
                             
                              self.orderlist.removeAll()
                              let resultArray = myresults
                             
                              for i in resultArray!.arrayValue{
                              
                                self.orderlist.append(Orderlist(sale_user_name: i["sale_user_name"].stringValue, gram:  i["gram"].stringValue, point_eight:  i["point_eight"].stringValue, sale_date:  i["order_date"].stringValue, voucher_number:  i["voucher_number"].stringValue, total_quantity:  i["total_qualtity"].stringValue))
                                }
                              
                              self.orerlisttableview.reloadData()
                            
                              
    
                              break
                          case .failure:
                              break
                          }

                      }
                      
                  }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return orderlist.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = orerlisttableview.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as! OrderlistCell
        cell.date.text = "Date : \(orderlist[indexPath.row].sale_date)"
        cell.gram.text = "Gram : \(orderlist[indexPath.row].gram)"
        cell.point_eight.text = "Point Eight : \(orderlist[indexPath.row].point_eight)"
        cell.quantity.text = "Quantity : \(orderlist[indexPath.row].total_quantity)"
        cell.voucher_no.text = "Voucher No : \(orderlist[indexPath.row].voucher_number)"
        cell.user_group.text = "Sale name : \(orderlist[indexPath.row].sale_user_name)"
        return cell
    }
    @IBAction func backAction(_ sender: Any) {
        navigationController?.popViewController(animated: true)
        dismiss(animated: true, completion: nil)
    }
}
