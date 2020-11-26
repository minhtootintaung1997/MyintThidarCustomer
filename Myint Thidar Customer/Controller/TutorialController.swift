//
//  TutorialController.swift
//  Myint Thidar Customer
//
//  Created by Kaung Khant Shar on 21/08/2020.
//  Copyright © 2020 Nanolabs. All rights reserved.
//

import Foundation
import UIKit
import Alamofire
import SwiftyJSON
import AVFoundation
import AVKit
class TutorialController : UIViewController, UITableViewDelegate, UITableViewDataSource{
   
   
    @IBOutlet weak var curveView: UIView!
    @IBOutlet weak var tutorialtablview: UITableView!
    var tutorial : [Tutorial] = []
    var video_url = [String]()
     let vc = AVPlayerViewController()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        loadtutorial()
        tutorialtablview.rowHeight = 150
        curveView.clipsToBounds = true
        curveView.layer.cornerRadius = 30
        curveView.layer.maskedCorners = [.layerMaxXMinYCorner, .layerMinXMinYCorner]
    }
    @objc func playerDidFinishPlaying(note: NSNotification) {
               vc.dismiss(animated: true, completion: nil)
     }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return tutorial.count
       }
       
       func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tutorialtablview.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as! TutorialCell
        cell.video_cover.kf.setImage(with: URL(string: "http://api.myinthidarjewellery.com/uploads/tutorial_image/\(tutorial[indexPath.row].video_cover)"), placeholder: UIImage(named: ""), options: nil, progressBlock: nil, completionHandler: nil)
        cell.video_title.text = tutorial[indexPath.row].video_title
        return cell
       }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
         let player = AVPlayer(url: URL(string: "http://api.myinthidarjewellery.com/uploads/tutorial_video/\(video_url[indexPath.row])")!)
                     
                      vc.player = player
                      NotificationCenter.default.addObserver(self, selector: #selector(playerDidFinishPlaying), name: NSNotification.Name.AVPlayerItemDidPlayToEndTime, object: vc.player?.currentItem)

                      
                      present(vc, animated: true) {
                          self.vc.player?.play()
                          print("played")
                          
                      }
    }
    
    func loadtutorial(){
                         
                            Alamofire.request("http://api.myinthidarjewellery.com/api/tutorial", method: .get).responseJSON { (myresponse) in
                                      
                                      switch myresponse.result {
                                      case .success:
                                          
                                          let myresults = try? JSON(data: myresponse.data!)
                                         
                                         
                                          let resultArray = myresults
                                          self.tutorial.removeAll()
                                          for i in resultArray!.arrayValue{
                                            
                                            self.tutorial.append(Tutorial(video_cover: i["photo"].stringValue, video_title: i["name"].stringValue, video_url: i["video"].stringValue))
                                      
                                            self.video_url.append(i["video"].stringValue)
                                             
                                            }
                                          
                                          self.tutorialtablview.reloadData()
                                        
                                          
                
                                          break
                                      case .failure:
                                          break
                                      }

                                  }
                                  
                              }
    
    @IBAction func backAction(_ sender: Any) {
        navigationController?.popViewController(animated: true)
        dismiss(animated: true, completion: nil)
    }
    
    
}
