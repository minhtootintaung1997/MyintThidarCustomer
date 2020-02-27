//
//  ViewController.swift
//  Myint Thidar Customer
//
//  Created by Min Htoo Tint Aung on 2/24/20.
//  Copyright © 2020 Nanolabs. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    @IBOutlet weak var scanqrbtn: UIButton!
    
   
    @IBOutlet weak var usernametextfield: UITextField!
    override func viewDidLoad() {
        super.viewDidLoad()
                
        
    }
    
  
    @IBAction func signinbtnclick(_ sender: UIButton, forEvent event: UIEvent) {
        let usernamestr:String=usernametextfield.text!
       
        if usernamestr=="" {
            showSimpleAlert()
        } else {
            performSegue(withIdentifier: "identi", sender: self)
                    }
    }
    
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.destination is TestViewController{
            let vc=segue.destination as? TestViewController
            vc?.name=usernametextfield.text!
            
        }
    }
 func showSimpleAlert() {
    let a=UIAlertController(title: "Error", message: "Enter user name", preferredStyle: UIAlertController.Style.alert)
    a.addAction(UIAlertAction(title: "OK", style: UIAlertAction.Style.default, handler: { (UIAlertAction) in
        print("hello")
    }))
        
       self.present(a, animated: true, completion: nil)
   }

}

