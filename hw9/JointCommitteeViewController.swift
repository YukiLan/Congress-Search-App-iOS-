//
//  JointCommitteeViewController.swift
//  hw9
//
//  Created by ChenQianlan on 11/30/16.
//  Copyright © 2016 ChenQianlan. All rights reserved.
//

import UIKit
import Alamofire
import SwiftyJSON
import SwiftSpinner
class JointCommitteeViewController: UITableViewController,UISearchBarDelegate{
    
    
    @IBOutlet weak var navButton: UIBarButtonItem!
    
    @IBAction func addNav(_ sender: Any) {
        self.slideMenuController()?.openLeft()
    }
    //-----------Search Bar
    var searchBar = UISearchBar()
    //----------------------------------------------------
    
    var searchController: UISearchController!
    var searchTitle : String = ""
    var commFull = [JSON]()
    var commFilter = [JSON]()
    
    let url = URL(string: "http://104.198.0.197:8080/committees?apikey=4f97288480da41d3b574d4c02be01448&per_page=all")!
    var searchButton = UIBarButtonItem()
    var cancelButton = UIBarButtonItem()
    override func viewDidLoad() {
        super.viewDidLoad()
        self.tabBarController?.tabBar.isHidden = false
        let attributes = [NSFontAttributeName: UIFont.fontAwesome(ofSize: 20)] as [String: Any]
        self.navButton.setTitleTextAttributes(attributes, for: .normal)
        self.navButton.title = String.fontAwesomeIcon(name: .bars)

        searchButton = UIBarButtonItem(barButtonSystemItem: .search, target: self, action: "forSearch")
        cancelButton = UIBarButtonItem(barButtonSystemItem: .stop, target: self, action: "forCancel")
        
        self.navigationItem.rightBarButtonItem = searchButton
        //--------------------------------Search Bar
        self.tabBarController?.tabBar.isHidden = false
        self.searchBar.showsCancelButton = false
        self.searchBar.delegate = self
//---------------------------------------------
/*

        //self.view.addSubview(search)
        self.searchController = UISearchController(searchResultsController: nil)
        self.searchController.searchResultsUpdater = self
        self.searchController.dimsBackgroundDuringPresentation = false
        self.searchController.searchBar.delegate = self
        self.searchController.delegate = self
        self.searchController.hidesNavigationBarDuringPresentation = false
        self.searchController.searchBar.sizeToFit()
        //self.navigationItem.titleView = searchController.searchBar
        self.definesPresentationContext = true
 */
        SwiftSpinner.useContainerView(self.view)
        SwiftSpinner.show("fetching data...")

        Alamofire.request(url).validate().responseJSON{ response in
            switch response.result.isSuccess{
            case true:
                if let result = response.result.value{
                    let json = JSON(result)
                    var committee = json["results"].arrayValue
                    committee = committee.filter{x in
                        return x["chamber"].stringValue == "joint"
                    }

                    //print(legis)
                    /*
                     if (self.state=="" )||(self.state=="All State"){
                     }
                     else{
                     legis = legis.filter{x in
                     return x["state_name"].stringValue==self.state
                     }
                     }
                     */
                    /*
                     bill = bill.sorted(){
                     $1["bill_name"]>$0["bill_name"]
                     }*/
                    self.commFull = committee
                    self.commFilter = committee
                    //print(self.activeBill)
                    //print(self.sectionName)
                    //print(self.rowForSet[self.sectionName[2]])
                    self.tableView.reloadData()
                    SwiftSpinner.hide()
                }
                
            case false:
                print(response.result.error!)
            }
            Timer.scheduledTimer(timeInterval: 1,
                                 target: self,
                                 selector: #selector(self.update),
                                 userInfo: nil,
                                 repeats: true)
        }
        
        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false
        
        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem()
    }
    func update() {
        // do what should happen when timer triggers an event
        //SwiftSpinner.hide()
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
        self.commFilter = self.commFull
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
        return commFilter.count
    }
    
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "rowcell", for: indexPath)
        let content = commFilter[indexPath.row]
        // Configure the cell...
        cell.textLabel?.text = content["name"].stringValue
        cell.detailTextLabel?.text = content["committee_id"].stringValue
        return cell
    }
    /*
    func updateSearchResults(for searchController: UISearchController) {
        let searchString = searchController.searchBar.text
        if (searchString==""){
            self.commFilter = self.commFull
        }
        else{
            self.commFilter = self.commFull.filter{x in
                let title = x["name"].stringValue.uppercased()
                return (title as NSString).contains(searchString!.uppercased()) }
        }
        
        // 根据用户输入过滤数据到 filteredArray
        
        
        // 刷新 tableView
        tableView.reloadData()
    }
    */
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        let item = self.commFilter[indexPath.row]
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        
        var viewcontroller = storyboard.instantiateViewController(withIdentifier: "CommiJointDetailViewController") as! CommiJointDetailViewController
        
        viewcontroller.detail = item
        self.tabBarController?.tabBar.isHidden = true
        self.navigationController?.pushViewController(viewcontroller, animated: true)
    }
    //-------------------------Filter for search bar------------------
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        if (searchText.characters.count == 0){
            self.commFilter = self.commFull
        }
        else{
            self.commFilter = self.commFull.filter{x in
                let title = x["name"].stringValue.uppercased()
                return (title as NSString).contains(searchText.uppercased()) }
        }
        self.tableView.reloadData()
    }
    
    //------------------------------------------------------------

    
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
