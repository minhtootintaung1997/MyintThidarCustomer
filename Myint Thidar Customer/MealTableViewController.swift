//
//  MealTableViewController.swift
//  Myint Thidar Customer
//
//  Created by Min Htoo Tint Aung on 2/25/20.
//  Copyright © 2020 Nanolabs. All rights reserved.
//

import UIKit


class MealTableViewController: UITableViewController,UISearchResultsUpdating  {
    func updateSearchResults(for searchController: UISearchController) {
        filterList.removeAll()
        var deletedlist=[Meal]()
        deletedlist=meal
        deletedlist.removeAll { !$0.date.contains(searchController.searchBar.text!) }
        filterList=deletedlist
        ordertableview.reloadData()
    }
    
var mainurl="http://app.myinthidarjewellery.com/mtd"
    var meal=[Meal]()
    var filterList=[Meal]()
    @IBOutlet var ordertableview: UITableView!
    let searchcontroller=UISearchController(searchResultsController: nil)
    override func viewDidLoad() {
        super.viewDidLoad()
        
        searchcontroller.searchResultsUpdater=self
        searchcontroller.obscuresBackgroundDuringPresentation=false
        searchcontroller.searchBar.placeholder="Search Orders"
        
        self.navigationItem.searchController=searchcontroller
        
        definesPresentationContext=true
        

                let userN:String=Tab1ViewController.user_name!
        loadData(uN: userN)
    }
    
    func loadData(uN:String)  {
        //TSZ20190919_124433
                let session=URLSession.shared
        let loadorder=session.dataTask(with: URL(string: mainurl+"/orderhistory.php?user_name="+uN)!) { (Data, URLResponse, Error) in
            if let responseobj=try?JSONSerialization.jsonObject(with: Data!, options: [])as? [[String:Any]]{
                DispatchQueue.main.sync {
                    for ob in responseobj{
                        self.meal.append(Meal(date: ob["order_date"]as! String, salename: ob["sale_user_name"]as! String, vn: ob["voucher_number"]as! String, gr: ob["gram"]as! String, qt: ob["total_qualtity"]as! String, pe: ob["point_eight"]as! String))
                    }
                    self.ordertableview.reloadData()
                }
            }
        }
        loadorder.resume()
    }
    
    
    // MARK: - Table view data source

//    override func numberOfSections(in tableView: UITableView) -> Int {
//        // #warning Incomplete implementation, return the number of sections
//        return 0
//    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        if(searchcontroller.isActive){
            return filterList.count
        }else{

        return meal.count
        }
    }

    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)as!MealTableViewCell

        var m:Meal
        if(searchcontroller.isActive){
            m=filterList[indexPath.row]
        }else{
            m=meal[indexPath.row]
        }
         

        cell.pointeightlb.text="Point Eight :  "+m.pointeight
        cell.datelb.text="Date : "+m.date
        cell.quantitylb.text="Quantity : "+m.quantity
        cell.gramlb.text="Gram : "+m.gram
        cell.salenamelb.text="Sale Name : "+m.salename
        cell.voucherno.text="Voucher No : "+m.voucherno
        
       
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
