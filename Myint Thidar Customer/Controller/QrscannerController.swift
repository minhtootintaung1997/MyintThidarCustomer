//
//  QrscannerController.swift
//  Myint Thidar Customer
//
//  Created by Kaung Khant Shar on 17/08/2020.
//  Copyright © 2020 Nanolabs. All rights reserved.
//

import Foundation
import UIKit
import AVFoundation
import Alamofire
import SwiftyJSON

class QrscannerController : UIViewController, UIImagePickerControllerDelegate, UINavigationControllerDelegate, AVCapturePhotoCaptureDelegate, AVCaptureMetadataOutputObjectsDelegate, UIGestureRecognizerDelegate {
    
    var imageOrientation: AVCaptureVideoOrientation?
    var captureSession: AVCaptureSession?
    var videoPreviewLayer: AVCaptureVideoPreviewLayer?
    var capturePhotoOutput: AVCapturePhotoOutput?
    @IBOutlet weak var qrview: UIView!
    
    var finalusernamestring : String = ""
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationController?.interactivePopGestureRecognizer?.delegate = self
        self.navigationController?.interactivePopGestureRecognizer?.isEnabled = true
        guard let captureDevice = AVCaptureDevice.default(for: AVMediaType.video) else {
                   fatalError("No video device found")
               }
        self.imageOrientation = AVCaptureVideoOrientation.portrait
        do {
                  // Get an instance of the AVCaptureDeviceInput class using the previous deivce object
                  let input = try AVCaptureDeviceInput(device: captureDevice)
                         
                  // Initialize the captureSession object
                  captureSession = AVCaptureSession()
                         
                  // Set the input device on the capture session
                  captureSession?.addInput(input)
                         
                  // Get an instance of ACCapturePhotoOutput class
                  capturePhotoOutput = AVCapturePhotoOutput()
                  capturePhotoOutput?.isHighResolutionCaptureEnabled = true
                         
                  // Set the output on the capture session
                  captureSession?.addOutput(capturePhotoOutput!)
                  captureSession?.sessionPreset = .high
                         
                  // Initialize a AVCaptureMetadataOutput object and set it as the input device
                  let captureMetadataOutput = AVCaptureMetadataOutput()
                  captureSession?.addOutput(captureMetadataOutput)
                         
                  // Set delegate and use the default dispatch queue to execute the call back
                  captureMetadataOutput.setMetadataObjectsDelegate(self, queue: DispatchQueue.main)
                  captureMetadataOutput.metadataObjectTypes = [AVMetadataObject.ObjectType.qr]
                         
                  //Initialise the video preview layer and add it as a sublayer to the viewPreview view's layer
                  videoPreviewLayer = AVCaptureVideoPreviewLayer(session: captureSession!)
                  videoPreviewLayer?.videoGravity = AVLayerVideoGravity.resizeAspectFill
                  videoPreviewLayer?.frame = view.layer.bounds
                  qrview.layer.addSublayer(videoPreviewLayer!)

                  //start video capture
                  captureSession?.startRunning()
                         
              } catch {
                  //If any error occurs, simply print it out
                  print(error)
                  return
              }
    }
    override func viewWillAppear(_ animated: Bool) {
         navigationController?.setNavigationBarHidden(true, animated: false)
               self.captureSession?.startRunning()
    }
    func cameraWithPosition(position: AVCaptureDevice.Position) -> AVCaptureDevice? {
        let discoverySession = AVCaptureDevice.DiscoverySession(deviceTypes: [.builtInWideAngleCamera], mediaType: AVMediaType.video, position: .unspecified)
        for device in discoverySession.devices {
            if device.position == position {
                return device
            }
        }
        
        return nil
    }
    
    func metadataOutput(_ captureOutput: AVCaptureMetadataOutput,
                           didOutput metadataObjects: [AVMetadataObject],
                           from connection: AVCaptureConnection) {
           // Check if the metadataObjects array is contains at least one object.
           if metadataObjects.count == 0 {
               return
           }
           
           //self.captureSession?.stopRunning()
           
           // Get the metadata object.
           let metadataObj = metadataObjects[0] as! AVMetadataMachineReadableCodeObject
           
           if metadataObj.type == AVMetadataObject.ObjectType.qr {
               if let outputString = metadataObj.stringValue {
                   DispatchQueue.main.async {
                       print("outputString\(outputString)")
                    UserDefaults.standard.set(outputString, forKey: "username")
                    self.finalusernamestring = outputString
                    self.captureSession?.stopRunning()
                
                    self.isuserexist()
                      
                   }
               }
           }
           
       }
    
     func isuserexist() {
                
                let parameters: [String: Any] = [
                    "user_name" : finalusernamestring
                    
                    
                ]
                
                Alamofire.request("http://api.myinthidarjewellery.com/api/login/user", method: .post, parameters: parameters, encoding: JSONEncoding.default).responseJSON { response in
                    print(response)
                    
                    if let result = response.result.value {
                                                    
                    let JSONS = result as! NSDictionary
                                       
                        let statue = JSONS.object(forKey: "status")
                      if let json = response.data {
                        _ = try? JSON(data: json)
                         }
                                   if statue as AnyObject? === "success" as AnyObject  {
                                    
                                    print("user already existed")
                                    self.performSegue(withIdentifier: "isuserexist", sender: self)
                                    
                                   } else {
                                    print("something went wrong")
                        }
                    }
                }
                
            }
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "isuserexist"{
            let vc = segue.destination as! CheckuserController
                vc.username = finalusernamestring
        }
        }
    }
    

