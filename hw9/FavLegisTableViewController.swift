//
//  FavLegisTableViewController.swift
//  hw9
//
//  Created by ChenQianlan on 11/30/16.
//  Copyright © 2016 ChenQianlan. All rights reserved.
//

import UIKit
import Alamofire
import SwiftyJSON
import SwiftSpinner
import CoreData

class FavLegisTableViewController: UITableViewController,UISearchBarDelegate {

    @IBOutlet weak var navButton: UIBarButtonItem!
    
    @IBAction func addNav(_ sender: Any) {
        self.slideMenuController()?.openLeft()
    }
    var searchButton = UIBarButtonItem()
    var cancelButton = UIBarButtonItem()
    var searchBar = UISearchBar()
    
    
    static var favList = [JSON]()
    
    var favFilter = [JSON]()
    
    
    
    
    
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        self.tabBarController?.tabBar.isHidden = false
        self.searchBar.showsCancelButton = false
        self.searchBar.delegate = self
        searchButton = UIBarButtonItem(barButtonSystemItem: .search, target: self, action: "forSearch")
        cancelButton = UIBarButtonItem(barButtonSystemItem: .stop, target: self, action: "forCancel")
        self.navigationItem.rightBarButtonItem = searchButton
        /*
         self.favList += LegisDetailViewController.favList
         self.favList += LegisHouseDetailViewController.favList
         self.favList += LegisSenateDetailViewController.favList
         */
        FavLegisTableViewController.favList = FavLegisTableViewController.favList.sorted(){
            $1["first_name"]>$0["first_name"]
        }
        self.favFilter = FavLegisTableViewController.favList
        let attributes = [NSFontAttributeName: UIFont.fontAwesome(ofSize: 20)] as [String: Any]
        self.navButton.setTitleTextAttributes(attributes, for: .normal)
        self.navButton.title = String.fontAwesomeIcon(name: .bars)
        
        SwiftSpinner.useContainerView(self.view)
        SwiftSpinner.show("fetching data...")
        
        self.tableView.reloadData()
        SwiftSpinner.hide()
        Timer.scheduledTimer(timeInterval: 1,
                             target: self,
                             selector: #selector(self.update),
                             userInfo: nil,
                             repeats: true)
        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false
        
        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem()
    }
    func forSearch()
    {
        self.navigationItem.titleView = self.searchBar
        self.navigationItem.rightBarButtonItem = self.cancelButton
        
    }
    func forCancel(){
        print("sadgad")
        self.navigationItem.rightBarButtonItem = self.searchButton
        self.navigationItem.titleView = nil
        self.favFilter = FavLegisTableViewController.favList
    }
    func update() {
        // do what should happen when timer triggers an event
        //SwiftSpinner.hide()
    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    // MARK: - Table view data source
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return self.favFilter.count
    }
    
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "rowcell", for: indexPath)
        
        // Configure the cell...
        let content = self.favFilter[indexPath.row]
        cell.textLabel?.text = content["first_name"].stringValue + "  " + content["last_name"].stringValue
        //print(name)
        //print(content["state_name"].stringValue)
        cell.detailTextLabel?.text = content["state_name"].stringValue
        
        let url = NSURL(string : "https://theunitedstates.io/images/congress/original/"+content["bioguide_id"].stringValue+".jpg")
        let img_data = NSData(contentsOf: url! as URL)
        cell.imageView?.image = UIImage(data:img_data! as Data)
        
        return cell
    }
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        if (searchText.characters.count == 0){
            self.favFilter = FavLegisTableViewController.favList
            
        }
        else{
            self.favFilter = FavLegisTableViewController.favList.filter{x in
                let name = x["first_name"].stringValue.uppercased() + " " + x["last_name"].stringValue.uppercased()
                return (name as NSString).contains(searchText.uppercased()) }
        }
        self.tableView.reloadData()
    }
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        print("lsdl")
        tableView.deselectRow(at: indexPath, animated: true)
        let item = favFilter[indexPath.row]
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        
        var viewcontroller = storyboard.instantiateViewController(withIdentifier: "FavLegisDetailViewController") as! FavLegisDetailViewController
        
        viewcontroller.detail = item
        self.tabBarController?.tabBar.isHidden = true
        self.navigationController?.pushViewController(viewcontroller, animated: true)
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
     override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
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
     // Get the new view controller using segue.destinationViewController.
     // Pass the selected object to the new view controller.
     }
     */
    
}
