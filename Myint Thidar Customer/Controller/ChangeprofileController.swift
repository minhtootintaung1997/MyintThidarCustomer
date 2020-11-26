//
//  ChangeprofileController.swift
//  Myint Thidar Customer
//
//  Created by Kaung Khant Shar on 01/09/2020.
//  Copyright © 2020 Nanolabs. All rights reserved.
//

import Foundation
import UIKit
import Alamofire
import SwiftyJSON
import Kingfisher
import Photos
class ChangeprofileController : UIViewController, UIImagePickerControllerDelegate, UINavigationControllerDelegate, UITabBarControllerDelegate {
    
    @IBOutlet weak var profileImageSetting: UIImageView!
    @IBOutlet weak var changeProfileBtn: UIButton!
    @IBOutlet weak var curveView: UIView!
    
    let imagepicker = UIImagePickerController()
     var imgstr = String()
    var username : String = ""
    override func viewDidLoad() {
        super.viewDidLoad()
        profileImageSetting.layer.cornerRadius = profileImageSetting.frame.size.width/2
               self.profileImageSetting.clipsToBounds = true
        imagepicker.delegate = self
        username = UserDefaults.standard.string(forKey: "username")!
        curveView.clipsToBounds = true
        curveView.layer.cornerRadius = 30
        curveView.layer.maskedCorners = [.layerMaxXMinYCorner, .layerMinXMinYCorner]
    }
    
    
    @IBAction func changeProfileAction(_ sender: Any) {
    
     PHPhotoLibrary.requestAuthorization { (status) in
                          // cruch here
                      }
                             imagepicker.allowsEditing=true
                             imagepicker.sourceType = .photoLibrary
                           present(imagepicker, animated: true, completion: nil)
               
    }
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
         if let pickerimg = info[UIImagePickerController.InfoKey.editedImage] as? UIImage
                          {
                              DispatchQueue.main.async {
                                             
                                             self.profileImageSetting.contentMode = .scaleAspectFit
                                             self.profileImageSetting.image=pickerimg
                                             self.profileImageSetting.layer.cornerRadius = self.profileImageSetting.frame.size.width / 2
                                             self.profileImageSetting.clipsToBounds = true
                           
                                            self.imgstr = self.convertImageToBase64(image:pickerimg)
                                           
                                self.changeProfileBtn.isHidden = true
                                         }
                              }
                          
                       dismiss(animated: true, completion: nil)
    }
    func convertImageToBase64(image: UIImage) -> String {
                let imageData:NSData = image.jpegData(compressionQuality: 0.4)! as NSData
                   let strBase64 = imageData.base64EncodedString(options: .lineLength64Characters)
                   return strBase64
            }
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
              dismiss(animated: true, completion: nil)
          }
    
    
    
      func sendData(un:String,code:String) {
               
               let parameters: [String: Any] = [
                "user_name" : username,
                "image" : code,
                    ]
            
               
               Alamofire.request("http://app.myinthidarjewellery.com/mtd/update_customer_profile.php", method: .post, parameters: parameters, encoding: JSONEncoding.default, headers: nil).responseJSON { response in
                  print(response)
                   
                if response.result.value != nil {

                 //  let JSONS = result as! NSDictionary

                  

                       if let json = response.data {
                                  let data = try? JSON(data: json)

                        print("image\(data!["response"])")
                        self.navigationController?.popViewController(animated: true)
                        self.dismiss(animated: true, completion: nil)

                        print("imagename\(data!["image"])")

                              }

                  
                   }
               }
               
           }
    
    @IBAction func backAction(_ sender: Any) {
        navigationController?.popViewController(animated: true)
        dismiss(animated: true, completion: nil)
    }
    
    @IBAction func updateProfileAction(_ sender: Any) {
        
        if imgstr != "" {
             sendData(un: username, code: imgstr)
        } else {
        let alertController = UIAlertController(title: "Alert", message: "Please choose image to update profile", preferredStyle: .alert)
                       let action2 = UIAlertAction(title: "Dismiss", style: .cancel) { (action:UIAlertAction) in
                                   print("You've pressed cancel");
                               }

                       alertController.addAction(action2)

                       self.present(alertController, animated: true, completion: nil)
    }
    }
}
