//
//  PurchaselistController.swift
//  Myint Thidar Customer
//
//  Created by Kaung Khant Shar on 21/08/2020.
//  Copyright © 2020 Nanolabs. All rights reserved.
//

import Foundation
import UIKit
import Alamofire
import SwiftyJSON

class PurchaselistController : UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    @IBOutlet weak var purchaselisttableview: UITableView!
    @IBOutlet weak var curveView: UIView!
    var purchaselist : [Purchaselist] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        loadpurchaselist()
        purchaselisttableview.rowHeight = 150
        curveView.clipsToBounds = true
        curveView.layer.cornerRadius = 30
        curveView.layer.maskedCorners = [.layerMaxXMinYCorner, .layerMinXMinYCorner]
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return purchaselist.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = purchaselisttableview.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as! PurchaselistCell
        cell.salename_group.text = "Sale name : \(purchaselist[indexPath.row].sale_user_name)"
        cell.gram.text = "Gram : \(purchaselist[indexPath.row].gram)"
        cell.point_eight.text = "Point Eight : \(purchaselist[indexPath.row].point_eight)"
        cell.date.text = "Date : \(purchaselist[indexPath.row].sale_date)"
        cell.voucher_no.text = "Voucher No : \(purchaselist[indexPath.row].voucher_number)"
        cell.quantity.text = "Quantity : \(purchaselist[indexPath.row].total_quantity)"
        return cell
    }
    func loadpurchaselist(){
                
                let parameters: [String: Any] = [
                "user_name" : "TSZ20190919_124433"
              
                               
                         ]
                         
                         Alamofire.request("http://app.myinthidarjewellery.com/mtd//salehistory.php", method: .post,parameters: parameters).responseJSON { (myresponse) in
                             
                             switch myresponse.result {
                             case .success:
                                 
                                 let myresults = try? JSON(data: myresponse.data!)
                                
                                 self.purchaselist.removeAll()
                                 let resultArray = myresults
                                
                                 for i in resultArray!.arrayValue{
                                 
                                    self.purchaselist.append(Purchaselist(sale_user_name: i["sale_user_name"].stringValue, gram: i["gram"].stringValue, point_eight: i["point_eight"].stringValue, sale_date: i["sale_date"].stringValue, voucher_number: i["voucher_number"].stringValue, total_quantity: i["total_qualtity"].stringValue))
                                   }
                                 
                                 self.purchaselisttableview.reloadData()
                               
                                 
       
                                 break
                             case .failure:
                                 break
                             }

                         }
                         
                     }
    @IBAction func backAction(_ sender: Any) {
        navigationController?.popViewController(animated: true)
        dismiss(animated: true, completion: nil
        )
    }
}
