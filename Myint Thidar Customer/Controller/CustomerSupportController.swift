//
//  CustomerSupportController.swift
//  Myint Thidar Customer
//
//  Created by Kaung Khant Shar on 21/08/2020.
//  Copyright © 2020 Nanolabs. All rights reserved.
//

import Foundation
import UIKit
import Alamofire
import SwiftyJSON

class CustomerSupportController : UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    @IBOutlet weak var cstableview: UITableView!
    @IBOutlet weak var curveView: UIView!
    var customersupport : [CustomerSupport] = []
    override func viewDidLoad() {
        super.viewDidLoad()
        loadcustomersupport()
        cstableview.rowHeight = 100
        curveView.clipsToBounds = true
               curveView.layer.cornerRadius = 30
               curveView.layer.maskedCorners = [.layerMaxXMinYCorner, .layerMinXMinYCorner]
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return customersupport.count
       }
       
       func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = cstableview.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as! CustomerSupportCell
        cell.status.text = customersupport[indexPath.row].status
        cell.phno.text = customersupport[indexPath.row].phno
        return cell
       }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        UIApplication.shared.openURL(NSURL(string: "tel://\(customersupport[indexPath.row].phno)")! as URL)
    }
    
    func loadcustomersupport(){
                       
                          Alamofire.request("http://api.myinthidarjewellery.com/api/support_center", method: .get).responseJSON { (myresponse) in
                                    
                                    switch myresponse.result {
                                    case .success:
                                        
                                        let myresults = try? JSON(data: myresponse.data!)
                                       
                                       
                                        let resultArray = myresults
                                        self.customersupport.removeAll()
                                        for i in resultArray!.arrayValue{
                                          
                                            self.customersupport.append(CustomerSupport(status: i["type"].stringValue, phno: i["phone"].stringValue))
                                    
                                           
                                          }
                                        
                                        self.cstableview.reloadData()
                                      
                                        
              
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
