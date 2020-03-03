//
//  SettingViewController.swift
//  Myint Thidar Customer
//
//  Created by Min Htoo Tint Aung on 2/28/20.
//  Copyright © 2020 Nanolabs. All rights reserved.
//

import UIKit
import MaterialComponents

class SettingViewController: UIViewController,UIImagePickerControllerDelegate,UINavigationControllerDelegate {

    let imagepicker=UIImagePickerController()
    //@IBOutlet weak var profileimge: UIImageView!
    @IBOutlet var profileimagesetting: UIImageView!
        var mainurl="http://app.myinthidarjewellery.com/mtd"
    @IBOutlet weak var loading: UIActivityIndicatorView!
    @IBOutlet weak var comfirmcodetextfield: MDCFilledTextField!
    @IBOutlet weak var changeprofilebtn: MDCRaisedButton!
    var profileimagepath:String?=nil
    var userN:String?=nil
    override func viewDidLoad() {
        super.viewDidLoad()

        profileimagepath=Tab1ViewController.profileimagepath
        
        ShowIndicator(boo: false)
        
        profileimagesetting.kf.setImage(with: URL(string: mainurl+"/"+profileimagepath!))
        imagepicker.delegate = self
        userN=Tab1ViewController.user_name!
        

       
    }
    func ShowIndicator(boo:Bool){
        DispatchQueue.main.async {
            if boo{
                self.loading.alpha=1
                self.loading.startAnimating()
            }
                else {
                 self.loading.stopAnimating()
                self.loading.alpha=0
        }
    }
    }
    @IBAction func changecomfirmcodebtn(_ sender: MDCButton) {
        let codestr:String=comfirmcodetextfield.text!
        if(!codestr.elementsEqual("")){
            changeCode(un: userN!, code: codestr)
            print(codestr+"code")
        }else{
            showSimpleAlert(message: "Error", title: "Enter code")
        }
    }
    @IBAction func logoutbtnclick(_ sender: UIButton) {
    exit(0)
    }
    
    @IBAction func changeProfilebtnClick(_ sender: MDCButton) {
        
        imagepicker.allowsEditing=false
        imagepicker.sourceType = .photoLibrary
        present(imagepicker, animated: true, completion: nil)
       
    }
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        print("selected")
        if let pickerimg=info[UIImagePickerController.InfoKey.originalImage]as? UIImage{
            
            
            DispatchQueue.main.async {
                self.profileimagesetting.contentMode = .scaleAspectFit
                self.profileimagesetting.image=pickerimg
            }
        }
        dismiss(animated: true, completion: nil)
        
    }
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        dismiss(animated: true, completion: nil)
    }
    
    func changeCode(un:String,code:String) {
        ShowIndicator(boo: true)
        let session=URLSession.shared
        let task=session.dataTask(with: URL(string: mainurl+"/changePinCode.php?user_name="+un+"&code="+code)!) { (Data, URLResponse, Error) in
            if let json=try? JSONSerialization.jsonObject(with: Data!, options:.mutableContainers)as? NSMutableDictionary{
                self.ShowIndicator(boo: false)
                if json["response"]as!String=="ok"{
                    DispatchQueue.main.async {
                        self.comfirmcodetextfield.text=nil
                        self.showSimpleAlert(message: "Success", title:"Code Changed")
                    }
                    
                    
                }else{
                    DispatchQueue.main.async {
                        self.showSimpleAlert(message: "Error", title:"Something wrong")
                    }
                    
                }
                
            }
        }
        task.resume()
    }
    func showSimpleAlert(message:String,title:String) {

            
        
            let a=UIAlertController(title: title, message: message, preferredStyle: UIAlertController.Style.alert)
    a.addAction(UIAlertAction(title: "OK", style: UIAlertAction.Style.default, handler: { (UIAlertAction) in
        print("hello")
    }))
        
       self.present(a, animated: true, completion: nil)
        }

}
