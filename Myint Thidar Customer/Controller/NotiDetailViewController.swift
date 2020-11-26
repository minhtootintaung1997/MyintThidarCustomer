//
//  NotiDetailViewController.swift
//  Myint Thidar Customer
//
//  Created by Min Htoo Tint Aung on 3/3/20.
//  Copyright © 2020 Nanolabs. All rights reserved.
//

import UIKit

class NotiDetailViewController: UIViewController {

    @IBOutlet weak var titlelb: UILabel!
    @IBOutlet weak var desclb: UILabel!
    static var titlestr:String?=nil
    static var descstr:String?=nil
    override func viewDidLoad() {
        super.viewDidLoad()

        titlelb.text=NotiDetailViewController.titlestr
        desclb.text=NotiDetailViewController.descstr
        // Do any additional setup after loading the view.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
