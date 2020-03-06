//
//  HistoryViewController.swift
//  Myint Thidar Customer
//
//  Created by Min Htoo Tint Aung on 2/27/20.
//  Copyright © 2020 Nanolabs. All rights reserved.
//

import UIKit
//
//  NotificationTableViewController.swift
//  Myint Thidar Customer
//
//  Created by Min Htoo Tint Aung on 2/25/20.
//  Copyright © 2020 Nanolabs. All rights reserved.
//

import UIKit
class HistoryViewController: UIViewController,UITableViewDataSource,UITableViewDelegate,UISearchResultsUpdating {
    func updateSearchResults(for searchController: UISearchController) {
        filterHistory.removeAll()
        var deletedlist=[HistoryModel]()
        deletedlist=historyarr
        deletedlist.removeAll { !$0.date.contains(searchController.searchBar.text!) }
        filterHistory=deletedlist
        historytableview.reloadData()
        
    }
    var filterHistory=[HistoryModel]()
var mainurl="http://app.myinthidarjewellery.com/mtd"
var historyarr=[HistoryModel]()
    let searchcontroller=UISearchController(searchResultsController: nil)
    @IBOutlet weak var historytableview: UITableView!
    override func viewDidLoad() {
        super.viewDidLoad()
        

        
        searchcontroller.searchResultsUpdater=self
        searchcontroller.obscuresBackgroundDuringPresentation=false
        searchcontroller.searchBar.placeholder="Search History"
        self.navigationItem.searchController=searchcontroller
        
        definesPresentationContext=true
        
        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
         //self.navigationItem.rightBarButtonItem = self.editButtonItem
        historytableview.separatorColor=UIColor.white
        self.historytableview.delegate=self
               self.historytableview.dataSource=self
       let userN:String=Tab1ViewController.user_name!
        LoadNoti(uN: userN)
    }
    var isSearchBarEmpty: Bool {
      return searchcontroller.searchBar.text?.isEmpty ?? true
    }
    func LoadNoti(uN:String)  {
        print(uN)
        
        let session1=URLSession.shared
        let loadpointtask=session1.dataTask(with: URL(string: mainurl+"/salehistory.php?user_name="+uN )!) { (pointdata, urlresponse, err) in
            

            if let res=urlresponse as? HTTPURLResponse{
                if(res.statusCode==200){
                    
                
            if let responseObj=try? JSONSerialization.jsonObject(with: pointdata!, options: [])as? [[String:Any]]{
                //print(responseObj)
                            
                DispatchQueue.main.sync {
                    for ob in responseObj{
                       self.historyarr.append(HistoryModel(date: ob["sale_date"]as! String, salename: ob["sale_user_name"]as! String, vn: ob["voucher_number"]as! String, gr: ob["gram"]as! String, qt: ob["total_qualtity"]as! String, pe: ob["point_eight"]as! String))
                        
                    }
                    self.historytableview.reloadData()

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
        if(searchcontroller.isActive){
            return self.filterHistory.count
        }else{
            return historyarr.count
        }
        
    }

  
     func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "historycell", for: indexPath)as! HistoryTableViewCell

        var h:HistoryModel
        if(searchcontroller.isActive){
            h=filterHistory[indexPath.row]
        }else{
            h=historyarr[indexPath.row]
        }
        
        cell.datelb.text="Date : "+h.date
        cell.gramlb.text="Gram : "+h.gram
        cell.pointeightlb.text="Point Eight : "+h.pointeight
        cell.quantitylb.text="Quantity : "+h.quantity
        cell.salenamelb.text="Sale Name : "+h.salename
        cell.voucherlb.text="Voucher No : "+h.voucherno
        return cell
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
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */



}
