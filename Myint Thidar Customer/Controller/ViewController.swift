//
//  ViewController.swift
//  Myint Thidar Customer
//
//  Created by Min Htoo Tint Aung on 2/24/20.
//  Copyright © 2020 Nanolabs. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    static var userdata:NSMutableDictionary?=nil;
    @IBOutlet weak var scanqrbtn: UIButton!
    var mainurl="http://app.myinthidarjewellery.com/mtd"
   
    @IBOutlet weak var loadingindicator: UIActivityIndicatorView!
    @IBOutlet weak var usernametextfield: UITextField!
    override func viewDidLoad() {
        super.viewDidLoad()
        
        ShowIndicator(boo: false)
        
        
    }
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        view.endEditing(true)
        super.touchesBegan(touches, with: event)
    }
    
    func ShowIndicator(boo:Bool){
        DispatchQueue.main.async {
            if boo{
                self.loadingindicator.alpha=1
                self.loadingindicator.startAnimating()
            }
                else {
                 self.loadingindicator.stopAnimating()
                self.loadingindicator.alpha=0
        }
    }
    }
    @IBAction func signinbtnclick(_ sender: UIButton, forEvent event: UIEvent) {
        self.performSegue(withIdentifier: "tohome", sender: self)
//        var usernamestr:String?
//            usernamestr=usernametextfield.text
//
//        if usernamestr!.count==0{
//            self.showSimpleAlert(message:"Enter user name")
//        } else {
//
//             checkLogin(un: usernamestr!)
//        }
    }
    
    func checkLogin(un:String) {
        ShowIndicator(boo: true)
        let session=URLSession.shared
        let task=session.dataTask(with: URL(string: mainurl+"/logintest.php?user_name="+un)!) { (Data, URLResponse, Error) in
            if let json=try? JSONSerialization.jsonObject(with: Data!, options:.mutableContainers)as? NSMutableDictionary{
                self.ShowIndicator(boo: false)
                if json["response"]as!String=="customer"{
                    DispatchQueue.main.sync {
                        ViewController.userdata=json
                         self.performSegue(withIdentifier: "tohome", sender: self)
                    }
                   
                }else{
                            DispatchQueue.main.sync {
                    self.showSimpleAlert(message: "You are new user")
                    }
                }
                
            }
        }
        task.resume()
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.destination is TestViewController{
            let vc=segue.destination as? TestViewController
            vc?.name=ViewController.userdata
            
        }else {
            
            //Tab1ViewController.user_data=ViewController.userdata
        }
    }
    func showSimpleAlert(message:String) {

            
        
            let a=UIAlertController(title: "Error", message: message, preferredStyle: UIAlertController.Style.alert)
    a.addAction(UIAlertAction(title: "OK", style: UIAlertAction.Style.default, handler: { (UIAlertAction) in
        print("hello")
    }))
        
       self.present(a, animated: true, completion: nil)
        }
   

}

