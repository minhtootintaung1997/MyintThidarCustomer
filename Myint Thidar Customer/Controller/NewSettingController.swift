//
//  NewSettingController.swift
//  Myint Thidar Customer
//
//  Created by Kaung Khant Shar on 07/08/2020.
//  Copyright © 2020 Nanolabs. All rights reserved.
//

import Foundation
import UIKit
import LSDialogViewController
import Alamofire
import SwiftyJSON

class NewSettingController : UIViewController, PopUpProtocol {
    
    func handleAction(action: Bool) {
            //opening a link to the app store if the user clickes on the go to app store button
                if (action) {
                    guard let url = URL(string: "url") else {
                        return
                    }
                    UIApplication.shared.open(url, options: [:], completionHandler: nil)
                }
      }
    var user_name : String = ""
    var real_username : String = ""
    var mainurl="http://app.myinthidarjewellery.com/mtd"
    @IBOutlet weak var curveView: UIView!
    @IBOutlet weak var quality: UILabel!
    @IBOutlet weak var point_eight: UILabel!
    @IBOutlet weak var realnamelbl: UILabel!
    @IBOutlet weak var kyat: UILabel!
    @IBOutlet weak var pll: UILabel!
    @IBOutlet weak var yway: UILabel!
    override func viewDidLoad() {
        super.viewDidLoad()
       
        user_name = UserDefaults.standard.string(forKey: "username")!
         userdata()
       // CalculatePoint(username: user_name)
        LoadJson(username: user_name)
        print("usernameis\(user_name)")
       curveView.clipsToBounds = true
        curveView.layer.cornerRadius = 30
        curveView.layer.maskedCorners = [.layerMaxXMinYCorner, .layerMinXMinYCorner]
    }
    
     func userdata() {

                   let parameters: [String: Any] = [
                       "user_name" : user_name


                   ]

                   Alamofire.request("http://app.myinthidarjewellery.com/mtd/calculate_point.php", method: .post, parameters: parameters, encoding: JSONEncoding.default).responseJSON { response in
                       print("response\(response)")

                       if let result = response.result.value {

                       let JSONS = result as! NSDictionary

                           let quantity = JSONS.object(forKey: "qualtity")
                        let point_eight = JSONS.object(forKey: "point_eight")

                      
                        self.quality.text = (String(describing: quantity!))
                        self.point_eight.text = (String(describing: point_eight!))
                        
                        

                       

                       }
                   }

               }
    
      func LoadJson(username:String)  {
            let session=URLSession.shared
        let url : String = "http://app.myinthidarjewellery.com/"
       let urlforjson=URL(string:url+"mtd/slae_invoice_userData.php?user_name="+username)!
       
                    var request=URLRequest(url:urlforjson)
                    request.httpMethod="POST"
                    let posttask=session.dataTask(with: request) { (Data, URLResponse, Error) in

                        if let res=URLResponse as? HTTPURLResponse{
                            if res.statusCode==200{


                        if let objj=try? JSONSerialization.jsonObject(with: Data!, options: .mutableContainers)as? NSMutableDictionary{




                            DispatchQueue.main.async {


                                self.realnamelbl.text=objj.object(forKey: "name")as? String
                                self.kyat.text = objj.object(forKey: "debit_kyat")as? String
                                self.pll.text = objj.object(forKey: "debit_pal")as? String
                                self.yway.text = objj.object(forKey: "debit_yae")as? String
//                                let qrname = objj.object(forKey: "path")as? String
//                             //   print("qrpirnt\(String(describing: qrname))")
//                                print("qrprint\(qrname!)")

    //                            self.profileimg.kf.setImage(with:URL(string:  self.mainurl+"/"+Tab1ViewController.profileimagepath!),options: [.memoryCacheExpiration(.seconds(10))])


                            }

                        }



                    }
                            }
                            }
                    posttask.resume()

        }
    
//    func CalculatePoint(username:String)  {
//               let session=URLSession.shared
//                       let urlforjson=URL(string:"ttp://app.myinthidarjewellery.com/mtd/calculate_point.php?user_name="+username)!
//                       var request=URLRequest(url:urlforjson)
//                       request.httpMethod="POST"
//                       let posttask=session.dataTask(with: request) { (Data, URLResponse, Error) in
//
//                           if let res=URLResponse as? HTTPURLResponse{
//                               if res.statusCode==200{
//
//
//                           if let objj=try? JSONSerialization.jsonObject(with: Data!, options: .mutableContainers)as? NSMutableDictionary{
//
//
//
//
//                               DispatchQueue.main.async {
//
//
//                                   self.quality.text=objj.object(forKey: "qualtity")as? String
//                                self.point_eight.text = objj.object(forKey: "point_eight")as? String
////                                   print("quantity\(objj.object(forKey: "quality")as? String)")
////                                print("pointeight\(objj.object(forKey: "point_eight")as? String)")
//
//       //                            self.profileimg.kf.setImage(with:URL(string:  self.mainurl+"/"+Tab1ViewController.profileimagepath!),options: [.memoryCacheExpiration(.seconds(10))])
//
//
//                               }
//
//                           }
//
//
//
//                       }
//                               }
//                               }
//                       posttask.resume()
//
//           }
    
    
    @IBAction func logoutAction(_ sender: Any) {
        let myalert = UIAlertController(title: "Myint Thidar Alert", message: "Are u sure want to logout?", preferredStyle: UIAlertController.Style.alert)

               myalert.addAction(UIAlertAction(title: "Log out", style: .default) { (action:UIAlertAction!) in
                   UserDefaults.standard.removeObject(forKey: "ISUSERLOGIN")
                   self.performSegue(withIdentifier: "logout", sender: self)
                   })
               myalert.addAction(UIAlertAction(title: "Cancel", style: .cancel) { (action:UIAlertAction!) in
                       print("Cancel")
                   })

                   self.present(myalert, animated: true)
    }
    
    
    
    @IBAction func qraction(_ sender: Any) {
         PopUpActionViewController.showPopup(parentVC: self)
    }
    @IBAction func changePasswordAction(_ sender: Any) {
        print("clicked")
        ChangePasswordController.showPopup(parentVC: self)
    }
    @IBAction func tutorialAction(_ sender: Any) {
        self.performSegue(withIdentifier: "tutorial", sender: self)
    }
    @IBAction func notiAction(_ sender: Any) {
        self.performSegue(withIdentifier: "noti", sender: self)
    }
    
    @IBAction func supportcenterAction(_ sender: Any) {
        self.performSegue(withIdentifier: "supportcenter", sender: self)
    }
    @IBAction func changelanguage(_ sender: Any) {
        self.performSegue(withIdentifier: "changelanguage", sender: self)
    }
    @IBAction func purchaselistAction(_ sender: Any) {
        self.performSegue(withIdentifier: "purchaselist", sender: self)
    }
    
    @IBAction func orderlistAction(_ sender: Any) {
        self.performSegue(withIdentifier: "orderlist", sender: self)
    }
    
    @IBAction func changeprfileAction(_ sender: Any) {
        self.performSegue(withIdentifier: "changeprofile", sender: self)
    }
}
