//
//  NotificationTableViewController.swift
//  Myint Thidar Customer
//
//  Created by Min Htoo Tint Aung on 2/25/20.
//  Copyright © 2020 Nanolabs. All rights reserved.
//

import UIKit

class NotificationTableViewController: UIViewController,UITableViewDataSource,UITableViewDelegate {
var mainurl="http://app.myinthidarjewellery.com/mtd"
    @IBOutlet weak var notificationtableview: UITableView!
    var notificationarray=[NotificationModel]()
    override func viewDidLoad() {
        super.viewDidLoad()

        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem
        self.notificationtableview.delegate=self
               self.notificationtableview.dataSource=self
        let userN:String=Tab1ViewController.id!
        LoadNoti(uN: userN)
    }
    func LoadNoti(uN:String)  {
        
        let session1=URLSession.shared
        let loadpointtask=session1.dataTask(with: URL(string: mainurl+"/read_notification.php?user_name="+uN )!) { (pointdata, urlresponse, err) in
            if let res=urlresponse as? HTTPURLResponse{
                if res.statusCode==200{
                    
                
            if let responseObj=try? JSONSerialization.jsonObject(with: pointdata!, options: [])as? [[String:Any]]{
                //print(responseObj)
                            
                DispatchQueue.main.sync {
                    for ob in responseObj{
                        self.notificationarray.append(NotificationModel(title: ob["title"]as!String,date: ob["noti_date"]as! String, noti: ob["noti_one"]as! String))
                        
                    }
                    self.notificationtableview.reloadData()

                            }
            }

        }
                }
            
                }
        loadpointtask.resume()
        
       
    }

    // MARK: - Table view data source

     
     func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return notificationarray.count
    }

  
     func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "notificationcell", for: indexPath)as! NotificationTableViewCell

        let noti=notificationarray[indexPath.row]
        cell.titlelabel.text=noti.title
        cell.datelbl.text=noti.date
        // Configure the cell...

        return cell
    }
    
     func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        print(notificationarray[indexPath.row].title)
        NotiDetailViewController.titlestr=notificationarray[indexPath.row].title
        NotiDetailViewController.descstr=notificationarray[indexPath.row].noti_one
        self.performSegue(withIdentifier: "notidenti", sender: self)
    }

    /*
    // Override to support conditional editing of the table view.
    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the specified item to be editable.
        return true
    }
    */

    /*
    // Override to support editing the table view.
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            // Delete the row from the data source
            tableView.deleteRows(at: [indexPath], with: .fade)
        } else if editingStyle == .insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
        }    
    }
    */

    /*
    // Override to support rearranging the table view.
    override func tableView(_ tableView: UITableView, moveRowAt fromIndexPath: IndexPath, to: IndexPath) {

    }
    */

    /*
    // Override to support conditional rearranging of the table view.
    override func tableView(_ tableView: UITableView, canMoveRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the item to be re-orderable.
        return true
    }
    */

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
 */
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
      //  if(segue.description is Noti
    }
    

}
