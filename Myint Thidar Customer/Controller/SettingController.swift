//
//  SettingController.swift
//  Myint Thidar Customer
//
//  Created by Kaung Khant Shar on 14/07/2020.
//  Copyright © 2020 Nanolabs. All rights reserved.
//

import Foundation
import UIKit

class SettingController : UIViewController {
    
    
    @IBOutlet weak var scrollView: UIScrollView!
    @IBOutlet weak var userbtn: UIButton!
    @IBOutlet weak var historybtn: UIButton!
    @IBOutlet weak var customersupportbtn: UIButton!
    @IBOutlet weak var logoutbtn: UIButton!
    @IBOutlet weak var curveView: UIView!
    override func viewDidLoad() {
        super.viewDidLoad()
        scrollView.showsVerticalScrollIndicator = false
        userbtn.layer.cornerRadius = 8.0
        userbtn.layer.borderWidth = 1.0
        userbtn.layer.borderColor = UIColor.blue.cgColor
        historybtn.layer.cornerRadius = 8.0
        historybtn.layer.borderWidth = 1.0
        historybtn.layer.borderColor = UIColor.blue.cgColor
        customersupportbtn.layer.cornerRadius = 8.0
        customersupportbtn.layer.borderWidth = 1.0
        customersupportbtn.layer.borderColor = UIColor.blue.cgColor
        logoutbtn.layer.cornerRadius = 8.0
        logoutbtn.layer.borderWidth = 1.0
        logoutbtn.layer.borderColor = UIColor.blue.cgColor
        curveView.clipsToBounds = true
        curveView.layer.cornerRadius = 20
        curveView.layer.maskedCorners = [.layerMinXMaxYCorner, .layerMaxXMaxYCorner]
    }
    
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
    @IBAction func HistroyAction(_ sender: Any) {
        self.performSegue(withIdentifier: "tohistory", sender: self)
    }
    @IBAction func logout(_ sender: Any) {
    }
}
