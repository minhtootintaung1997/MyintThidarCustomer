//
//  WelcomeController.swift
//  Myint Thidar Customer
//
//  Created by Kaung Khant Shar on 17/08/2020.
//  Copyright © 2020 Nanolabs. All rights reserved.
//

import Foundation
import UIKit

class WelcomeController : UIViewController {
    
    var userid : String = ""
    var user_name : String = ""
    var current_password : String = ""
    override func viewDidLoad() {
        super.viewDidLoad()
          if UserDefaults.standard.bool(forKey: "ISUSERLOGIN")  == true {
            userid = UserDefaults.standard.string(forKey: "userid")!
            user_name = UserDefaults.standard.string(forKey: "username")!
            current_password = UserDefaults.standard.string(forKey: "password")!
            self.performSegue(withIdentifier: "alreadylogin", sender: self)
            print("username \(user_name)")
            
        }
    }
    @IBAction func scanqrAction(_ sender: Any) {
        self.performSegue(withIdentifier: "scanqr", sender: self)
    }
}
