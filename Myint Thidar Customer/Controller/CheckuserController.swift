//
//  CheckuserController.swift
//  Myint Thidar Customer
//
//  Created by Kaung Khant Shar on 17/08/2020.
//  Copyright © 2020 Nanolabs. All rights reserved.
//

import Foundation
import UIKit
import Alamofire
import SwiftyJSON

class CheckuserController : UIViewController {
    
    @IBOutlet weak var password: UITextField!
    var username : String = ""
    var user_id : String = ""
    override func viewDidLoad() {
        super.viewDidLoad()
       
        
    }
    
  
    
    func userlogin() {
        
        let parameters: [String: Any] = [
                              "user_name" : username,
                              "password" : password.text!,
                                 "android" : "false",
                                 "ios" : "true",
                                    ]
        
        Alamofire.request("http://api.myinthidarjewellery.com/api/login/user/store", method: .post, parameters: parameters, encoding: JSONEncoding.default).responseJSON { response in
            print(response)
            
            switch response.result{
            case  .success :
                if let result = response.result.value {
                                                       
                       let JSONS = result as! NSDictionary
                                          
                           let statue = JSONS.object(forKey: "status")
                    
                         if let json = response.data {
                           let data = try? JSON(data: json)
                             self.user_id = "\(data!["id"])"
                            print("useridis\(self.user_id)")
                            }
                                      if statue as AnyObject? === "success" as AnyObject  {
                                       UserDefaults.standard.set(self.user_id, forKey: "userid")
                                        UserDefaults.standard.set(self.password.text!,forKey: "password")
                                         UserDefaults.standard.set(true, forKey: "ISUSERLOGIN")
                                         self.performSegue(withIdentifier: "loginsuccess", sender: self)
                                       
                                      } else {
                                       print("something went wrong")
                                       let alertController = UIAlertController(title: "MTD Alert", message: "Login failed. Please contact to MTD.", preferredStyle: .alert)
                                                                                                         
                                                          let action2 = UIAlertAction(title: "Cancel", style: .cancel) { (action:UIAlertAction) in
                                                                                                            
                                                              print("You've pressed cancel");
                                                                                                         }
                                                                                                 
                                                                                                
                                                          alertController.addAction(action2)

                                                                                                
                                                          self.present(alertController, animated: true, completion: nil)
                                       print("failure")
                           }
                       }
                break
            case .failure:
                let alertController = UIAlertController(title: "MTD Alert", message: "Login failed. Please try again.", preferredStyle: .alert)
                                                                                                               
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
    
   
    
    
    @IBAction func loginAction(_ sender: Any) {
        if password.text! != "" {
          userlogin()
  
        } else {
            let alertController = UIAlertController(title: "MTD Alert", message: "Please enter your password.", preferredStyle: .alert)
                     let action2 = UIAlertAction(title: "Cancel", style: .cancel) { (action:UIAlertAction) in
                       }
                     alertController.addAction(action2)
             self.present(alertController, animated: true, completion: nil)
        }
    }
}
