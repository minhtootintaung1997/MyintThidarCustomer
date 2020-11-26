//
//  NotificationController.swift
//  Myint Thidar Customer
//
//  Created by Kaung Khant Shar on 21/08/2020.
//  Copyright © 2020 Nanolabs. All rights reserved.
//

import Foundation
import UIKit
import Alamofire
import SwiftyJSON

class NotificationController : UIViewController, UITableViewDelegate, UITableViewDataSource {
  
    @IBOutlet weak var curveView: UIView!
    @IBOutlet weak var notitableview: UITableView!
    var notifications : [Notifications] = []
    override func viewDidLoad() {
        super.viewDidLoad()
        loadnoti()
        notitableview.rowHeight = 120
        curveView.clipsToBounds = true
               curveView.layer.cornerRadius = 30
               curveView.layer.maskedCorners = [.layerMaxXMinYCorner, .layerMinXMinYCorner]
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return notifications.count
      }
    func loadnoti(){
             
             let parameters: [String: Any] = [
             "city" : "MEIKTILA"
           
                            
                      ]
                      
                      Alamofire.request("http://app.myinthidarjewellery.com/mtd/read_notification_group.php", method: .post,parameters: parameters).responseJSON { (myresponse) in
                          
                          switch myresponse.result {
                          case .success:
                              
                              let myresults = try? JSON(data: myresponse.data!)
                             
                              self.notifications.removeAll()
                              let resultArray = myresults
                              self.notifications.removeAll()
                              for i in resultArray!.arrayValue{
                               self.notifications.append(Notifications(title: i["group_title"].stringValue, date: i["noti_group_date"].stringValue))
                             
                                }
                              
                              self.notitableview.reloadData()
                            
                              
    
                              break
                          case .failure:
                              break
                          }

                      }
                      
                  }
      
      func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = notitableview.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as! NotificationCell
        cell.title.text = notifications[indexPath.row].title
        cell.date.text = notifications[indexPath.row].date
        return cell
      }
      
    @IBAction func backAction(_ sender: Any) {
        navigationController?.popViewController(animated: true)
        dismiss(animated: true, completion: nil)
    }
  
}
