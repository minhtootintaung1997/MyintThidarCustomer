//
//  ChangePasswordController.swift
//  Myint Thidar Customer
//
//  Created by Kaung Khant Shar on 21/08/2020.
//  Copyright © 2020 Nanolabs. All rights reserved.
//

import Foundation
import UIKit
import Alamofire
import SwiftyJSON

protocol PopUpProtocolChangepassword {
    func handleAction(action: Bool)
}

class ChangePasswordController : UIViewController {
     static let identifier = "ChangePasswordController"
    var delegate : PopUpProtocolChangepassword?
    @IBOutlet var chpwView: UIView!
    @IBOutlet weak var confirmpw: UITextField!
    @IBOutlet weak var changepw: UITextField!
    var userid : String = ""
    var current_password : String = ""
    
    override func viewDidLoad() {
        super.viewDidLoad()
        current_password = UserDefaults.standard.string(forKey: "password")!
        userid = UserDefaults.standard.string(forKey: "userid")!
         view.backgroundColor = UIColor.black.withAlphaComponent(0.50)
        chpwView.layer.cornerRadius = 20
        chpwView.layer.borderWidth = 1.2
        chpwView.layer.borderColor = UIColor(named: "dialogBoxGray")?.cgColor
    }
    
    static func showPopup(parentVC: UIViewController){
           //creating a reference for the dialogView controller
           if let popupViewController = UIStoryboard(name: "ChangePassword", bundle: nil).instantiateViewController(withIdentifier: "ChangePasswordController") as? ChangePasswordController {
               popupViewController.modalPresentationStyle = .custom
               popupViewController.modalTransitionStyle = .crossDissolve
               
               //setting the delegate of the dialog box to the parent viewController
               popupViewController.delegate = parentVC as? PopUpProtocolChangepassword

               //presenting the pop up viewController from the parent viewController
               parentVC.present(popupViewController, animated: true)
           }
       }
    
    func updatepassword() {
                   
                   let parameters: [String: Any] = [
                       "user_id" : userid,
                       "old_password" : current_password,
                       "new_password" : changepw.text!
                       
                       
                   ]
                   
                   Alamofire.request("http://api.myinthidarjewellery.com/api/login/user/update", method: .post, parameters: parameters, encoding: JSONEncoding.default).responseJSON { response in
                       print(response)
                       
                       if let result = response.result.value {
                                                       
                       let JSONS = result as! NSDictionary
                                          
                           let statue = JSONS.object(forKey: "status")
                         if let json = response.data {
                           _ = try? JSON(data: json)
                            }
                                      if statue as AnyObject? === "success" as AnyObject  {
                                       
                                        UserDefaults.standard.set(self.changepw.text!, forKey: "password")
                                        self.navigationController?.popViewController(animated: true)
                                        self.dismiss(animated: true, completion: nil)
                                      } else {
                                       print("something went wrong")
                           }
                       }
                   }
                   
               }
    
    @IBAction func changepwAction(_ sender: Any) {
        if changepw.text == confirmpw.text! && changepw.text != "" {
            updatepassword()
            
        } else {
            let alertController = UIAlertController(title: "MTD Alert", message: "Password not match.", preferredStyle: .alert)
                                                                                                                    
              let action2 = UIAlertAction(title: "Cancel", style: .cancel) { (action:UIAlertAction) in
             }
               alertController.addAction(action2)

                self.present(alertController, animated: true, completion: nil)
                                                  
        }
    }
    
    @IBAction func closepopupAction(_ sender: Any) {
        navigationController?.popViewController(animated: true)
        dismiss(animated: true, completion: nil)
    }
}
