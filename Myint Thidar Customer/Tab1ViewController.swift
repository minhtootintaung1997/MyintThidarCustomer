//
//  Tab1ViewController.swift
//  Myint Thidar Customer
//
//  Created by Min Htoo Tint Aung on 2/25/20.
//  Copyright © 2020 Nanolabs. All rights reserved.
//

import UIKit
import Kingfisher
class Tab1ViewController: UIViewController {

    static var user_data:NSMutableDictionary?=nil
    static var user_name:String?=nil
    static var id:String?=nil
    @IBOutlet weak var qrimg: UIImageView!
    var mainurl="http://app.myinthidarjewellery.com/mtd"
    @IBOutlet weak var customernamelb: UILabel!
    @IBOutlet weak var ywaylb: UILabel!
    @IBOutlet weak var pallb: UILabel!
    @IBOutlet weak var kyatlb: UILabel!
    @IBOutlet weak var quantityLb: UILabel!
    @IBOutlet weak var profileimg: UIImageView!
    @IBOutlet weak var pointeightlb: UILabel!
    @IBOutlet weak var view1: UIView!
    override func viewDidLoad() {
        super.viewDidLoad()
        
        Tab1ViewController.user_name=Tab1ViewController.user_data!["user_name"]as? String
        LoadJson(username:Tab1ViewController.user_name!)
          }
    
    func LoadPoint(id:String) {
        let session1=URLSession.shared
        let loadpointtask=session1.dataTask(with: URL(string: mainurl+"/calculate_point.php?user_name="+id )!) { (pointdata, urlresponse, err) in
            if let responseObj=try? JSONSerialization.jsonObject(with: pointdata!, options: .mutableContainers)as? NSMutableDictionary{
                
                print(responseObj)
                print(String(responseObj.object(forKey: "point_eight")as! Int))
                DispatchQueue.main.sync {
                    self.pointeightlb.text=String(responseObj.object(forKey: "point_eight")as! Int)
                    self.quantityLb.text=String(
            responseObj.object(forKey: "qualtity")as! Int)
                }
            }
        }
        loadpointtask.resume()
        
    }

    func LoadJson(username:String)  {
        let session=URLSession.shared
                let urlforjson=URL(string:mainurl+"/slae_invoice_userData.php?user_name="+username)!
                var request=URLRequest(url:urlforjson)
                request.httpMethod="POST"
                let posttask=session.dataTask(with: request) { (Data, URLResponse, Error) in
                    if let objj=try? JSONSerialization.jsonObject(with: Data!, options: .mutableContainers)as? NSMutableDictionary{
                        
                        self.LoadPoint(id: objj.object(forKey: "id")as! String)
                       
                        
                        DispatchQueue.main.async {
                            self.LoadPhoto(path: objj.object(forKey: "path")as! String)

                            self.customernamelb.text=objj.object(forKey: "name")as? String
                            self.pointeightlb.text=objj.object(forKey: "total_point")as? String
                            self.kyatlb.text=objj.object(forKey: "debit_kyat")as? String
                            self.pallb.text=objj.object(forKey: "debit_pal")as? String
                            self.ywaylb.text=objj.object(forKey: "debit_yae")as? String
                            
                            Tab1ViewController.self.user_name=objj.object(forKey: "user_name")as?String
                            
                            Tab1ViewController.self.id=objj.object(forKey: "id")as? String

                        }
                        
                    }
                    
                                

                }
                posttask.resume()
        
    }
    func LoadPhoto(path:String)  {
    print(mainurl+"/"+path)
          let url = URL(string: mainurl+"/"+path)
              qrimg.kf.setImage(with: url)
              
    }
    

}
