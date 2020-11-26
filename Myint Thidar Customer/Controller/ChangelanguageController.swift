//
//  ChangelanguageController.swift
//  Myint Thidar Customer
//
//  Created by Kaung Khant Shar on 21/08/2020.
//  Copyright © 2020 Nanolabs. All rights reserved.
//

import Foundation
import UIKit

class ChangelanguageController : UIViewController, UIPickerViewDelegate, UIPickerViewDataSource, UITextFieldDelegate{
    
    @IBOutlet weak var chooseL: UITextField!
    @IBOutlet weak var curveView: UIView!
    
     var pickerViewnrcOne = UIPickerView()
     var selectedLanguage: String?
     var language = ["Myanmar(Unicode)","English"]
    override func viewDidLoad() {
        super.viewDidLoad()
        createPickerViewnrcOne()
        dismissPickerViewnrcOne()
        curveView.clipsToBounds = true
        curveView.layer.cornerRadius = 30
        curveView.layer.maskedCorners = [.layerMaxXMinYCorner, .layerMinXMinYCorner]
    }
    
    func createPickerViewnrcOne() {
           
           pickerViewnrcOne.delegate = self
           chooseL.inputView = pickerViewnrcOne
    }
    
    func dismissPickerViewnrcOne() {
       let toolBar = UIToolbar()
       toolBar.sizeToFit()
     let button = UIBarButtonItem(title: "Done", style: .plain, target: self, action: #selector(self.action))

       toolBar.setItems([button], animated: true)
       toolBar.isUserInteractionEnabled = true
       chooseL.inputAccessoryView = toolBar
    }
    
    @objc func action() {
          view.endEditing(true)
    }
    
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
     return language.count
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return language[row]
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
           selectedLanguage = language[row]
           chooseL.text = selectedLanguage
           print([row])
           if row == 1 {
               print("select myanmar")
                // UserDefaults.standard.set("en", forKey: "selectedlanguage")
               
           } else {
               print("select English")
           //  UserDefaults.standard.set("my-MM", forKey: "selectedlanguage")
              
                
           }
       }
    
    
    
    @IBAction func backAction(_ sender: Any) {
        navigationController?.popViewController(animated: true)
        dismiss(animated: true, completion: nil)
    }
    @IBAction func changeAction(_ sender: Any) {
        navigationController?.popViewController(animated: true)
        dismiss(animated: true, completion: nil)
    }
}
