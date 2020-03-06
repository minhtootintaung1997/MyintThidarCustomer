//
//  ComfirmPasswordViewController.swift
//  Myint Thidar Customer
//
//  Created by Min Htoo Tint Aung on 3/6/20.
//  Copyright © 2020 Nanolabs. All rights reserved.
//

import UIKit

class ComfirmPasswordViewController: UIViewController {

    static var userdata:NSMutableDictionary?=nil
    
    @IBOutlet weak var textfield: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()

       
    }
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        view.endEditing(true)
        super.touchesBegan(touches, with: event)
    }

    @IBAction func comfirmAdd(_ sender: UIButton) {
        if textfield.text==ComfirmPasswordViewController.userdata!["password"]as? String{
            self.performSegue(withIdentifier: "comfirmtotab1iden", sender: self)
        }else{
showSimpleAlert(message: "Wrong Password")
            
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
