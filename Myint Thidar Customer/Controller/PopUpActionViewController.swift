//
//  PopUpActionViewController.swift
//  Myint Thidar Customer
//
//  Created by Kaung Khant Shar on 20/08/2020.
//  Copyright © 2020 Nanolabs. All rights reserved.
//

import Foundation
import Cosmos
import Alamofire
import SwiftyJSON
import Kingfisher
protocol PopUpProtocol {
    func handleAction(action: Bool)
}

class PopUpActionViewController: UIViewController {
    @IBOutlet var dialogBoxView: UIView!
    @IBOutlet weak var qrimg: UIImageView!
    
 static let identifier = "PopUpActionViewController"
    var delegate: PopUpProtocol?
    override func viewDidLoad() {
        super.viewDidLoad()
        LoadJson(username: UserDefaults.standard.string(forKey: "username")!)
         view.backgroundColor = UIColor.black.withAlphaComponent(0.50)
        dialogBoxView.layer.cornerRadius = 20
               dialogBoxView.layer.borderWidth = 1.2
               dialogBoxView.layer.borderColor = UIColor(named: "dialogBoxGray")?.cgColor
    }
    
    static func showPopup(parentVC: UIViewController){
        //creating a reference for the dialogView controller
        if let popupViewController = UIStoryboard(name: "CustomView", bundle: nil).instantiateViewController(withIdentifier: "PopUpActionViewController") as? PopUpActionViewController {
            popupViewController.modalPresentationStyle = .custom
            popupViewController.modalTransitionStyle = .crossDissolve
            
            //setting the delegate of the dialog box to the parent viewController
            popupViewController.delegate = parentVC as? PopUpProtocol

            //presenting the pop up viewController from the parent viewController
            parentVC.present(popupViewController, animated: true)
        }
    }
    func LoadJson(username:String)  {
            let session=URLSession.shared
                    let urlforjson=URL(string:"http://app.myinthidarjewellery.com/mtd/slae_invoice_userData.php?user_name="+username)!
                    var request=URLRequest(url:urlforjson)
                    request.httpMethod="POST"
                    let posttask=session.dataTask(with: request) { (Data, URLResponse, Error) in

                        if let res=URLResponse as? HTTPURLResponse{
                            if res.statusCode==200{


                        if let objj=try? JSONSerialization.jsonObject(with: Data!, options: .mutableContainers)as? NSMutableDictionary{




                            DispatchQueue.main.async {

                                let qrimage = objj.object(forKey: "path")!
                               
                                self.qrimg.kf.setImage(with: URL(string: "http://app.myinthidarjewellery.com/mtd/\(qrimage)"), placeholder: UIImage(named: ""), options: nil, progressBlock: nil, completionHandler: nil)
   

                            }

                        }



                    }
                            }
                            }
                    posttask.resume()

        }
    
    @IBAction func popupcloseAction(_ sender: Any) {
        navigationController?.popViewController(animated: true)
        dismiss(animated: true, completion: nil)
    }
    
}
