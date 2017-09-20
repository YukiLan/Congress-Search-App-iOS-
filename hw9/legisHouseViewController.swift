//
//  legisHouseViewController.swift
//  hw9
//
//  Created by ChenQianlan on 11/29/16.
//  Copyright © 2016 ChenQianlan. All rights reserved.
//

import UIKit
import Alamofire
import SwiftyJSON
import SwiftSpinner

class legisHouseViewController: UITableViewController,UISearchBarDelegate{
    
    //UISearchControllerDelegate,UISearchResultsUpdating
    @IBOutlet weak var navButton: UIBarButtonItem!
    
    @IBAction func addNav(_ sender: Any) {
        self.slideMenuController()?.openLeft()
    }
    
    var searchController: UISearchController!
    var searchName : String = ""
    var shouldShowSearchResults = false
    var searchButton = UIBarButtonItem()
    var cancelButton = UIBarButtonItem()
    
    //-----------Search Bar
    var searchBar = UISearchBar()
    //----------------------------------------------------
    
    
    //var sectionName = [String]()
    //var rowForSet = [String : Array<JSON>]()
    var legisFull = [JSON]()
    var legisFilter = [JSON]()
    let url = URL(string: "http://104.198.0.197:8080/legislators?apikey=4f97288480da41d3b574d4c02be01448&per_page=all")!
    //let search = UIBarButtonItem(barButtonSystemItem: .search, target: self, action: "forSearch")
    //let cancel = UIBarButtonItem(barButtonSystemItem: .stop, target: self, action: "forCancel")
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.tabBarController?.tabBar.isHidden = false
        
        let attributes = [NSFontAttributeName: UIFont.fontAwesome(ofSize: 20)] as [String: Any]
        self.navButton.setTitleTextAttributes(attributes, for: .normal)
        self.navButton.title = String.fontAwesomeIcon(name: .bars)
//--------------------------------Search Bar
        self.tabBarController?.tabBar.isHidden = false
        self.searchBar.showsCancelButton = false
        self.searchBar.delegate = self
//----------------------------------------------
        

        searchButton = UIBarButtonItem(barButtonSystemItem: .search, target: self, action: "forSearch")
        cancelButton = UIBarButtonItem(barButtonSystemItem: .stop, target: self, action: "forCancel")
        self.navigationItem.rightBarButtonItem = searchButton
        
//---------------searchController----------------
        
        /*
        self.searchController = UISearchController(searchResultsController: nil)
        self.searchController.searchResultsUpdater = self
        self.searchController.dimsBackgroundDuringPresentation = false
        self.searchController.searchBar.delegate = self
        self.searchController.delegate = self
        self.searchController.hidesNavigationBarDuringPresentation = false
        self.searchController.searchBar.sizeToFit()
        //self.searchController.searchBar.
        //self.navigationItem.titleView = searchController.searchBar
        self.definesPresentationContext = true
        //self.searchController.searchBar.delegate = self
        */
//----------------------------------------------------
        
        
        SwiftSpinner.useContainerView(self.view)
        SwiftSpinner.show("fetching data...")
        
        
        
        Timer.scheduledTimer(timeInterval: 1,
                             target: self,
                             selector: #selector(self.update),
                             userInfo: nil,
                             repeats: true)
        Alamofire.request(url).validate().responseJSON{ response in
            switch response.result.isSuccess{
            case true:
                if let result = response.result.value{
                    let json = JSON(result)
                    var legis = json["results"].arrayValue
                    //print(legis)
                    legis = legis.sorted(){
                        $1["first_name"]>$0["first_name"]
                    }
                    
                    legis = legis.filter{x in
                        return x["chamber"].stringValue=="house"
                    }
                    /*
                    for item in legis{
                        let first_name = item["first_name"].stringValue
                        let i = first_name.characters.first!
                        self.sectionName.append(String(describing: i))
                    }
                    self.sectionName = Array(Set(self.sectionName))
                    self.sectionName = self.sectionName.sorted(){
                        $1>$0
                    }
 
                    for i in self.sectionName
                    {
                        self.rowForSet.updateValue([], forKey: i)
                    }
                    for item in legis{
                        let j = item["first_name"].stringValue.characters.first!
                        (self.rowForSet[String(j)])!.append(item)
                        
                    }
                    */
                    self.legisFull = legis
                    self.legisFilter = legis
                    //print(self.sectionName)
                    //print(self.rowForSet[self.sectionName[2]])
                    self.tableView.reloadData()
                    SwiftSpinner.hide()
                }
                
                
            case false:
                print(response.result.error!)
            }
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
        self.legisFilter = self.legisFull
    }
    /*
    func forSearch()
    {
        self.navigationItem.titleView = searchController.searchBar

        self.navigationItem.rightBarButtonItem = self.cancelButton
        
    }
    func forCancel(){
        print("sadgad")
        self.navigationItem.rightBarButtonItem = self.searchButton
        self.navigationItem.titleView = nil
        self.legisFilter = self.legisFull
    }
 */
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    /*
    func searchBarShouldBeginEditing(searchBar: UISearchBar) -> Bool {
        searchController.searchBar.setShowsCancelButton(false, animated: true)
        
        return true
    }
 */
    // MARK: - Table view data source
    /*
    override func sectionIndexTitles(for tableView: UITableView) -> [String]? {
        return sectionName
    }
 
    override func tableView(_ tableView: UITableView, sectionForSectionIndexTitle title: String, at index: Int) -> Int {
        return index
    }
 
    override func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return sectionName[section]
    }
 */
    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        
        //print(sectionName.count)
        return 1
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        //print("lksajalgkjl")
        //print(rowForSet[sectionName[section]]!.count)
        return legisFilter.count
    }
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "rowcell", for: indexPath)
        let content = legisFilter[indexPath.row]
        cell.textLabel?.text = content["first_name"].stringValue + "  " + content["last_name"].stringValue
        //print(name)
        //print(content["state_name"].stringValue)
        cell.detailTextLabel?.text = content["state_name"].stringValue
        
        let url = NSURL(string : "https://theunitedstates.io/images/congress/original/"+content["bioguide_id"].stringValue+".jpg")
        let img_data = NSData(contentsOf: url! as URL)
        cell.imageView?.image = UIImage(data:img_data! as Data)
        
        //var image = UIImage(data : data)
        //cell.textLabel?.text=name
        return cell
        
    }
/*
    func updateSearchResults(for searchController: UISearchController) {
        print("sadjgala")
        let searchString = searchController.searchBar.text
        if (searchString==""){
            self.legisFilter = self.legisFull
        }
        else{
            self.legisFilter = self.legisFull.filter{x in
                let name = x["first_name"].stringValue.uppercased() + " " + x["last_name"].stringValue.uppercased()
                return (name as NSString).contains(searchString!.uppercased()) }
        }
        
        // 根据用户输入过滤数据到 filteredArray
        
     
        // 刷新 tableView
        tableView.reloadData()
    }
 */
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        print("lsdl")
        tableView.deselectRow(at: indexPath, animated: true)
        let item = self.legisFilter[indexPath.row]
        print("lkejlggg")
        print(item)
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        
        var viewcontroller = storyboard.instantiateViewController(withIdentifier: "LegisHouseDetailViewController") as! LegisHouseDetailViewController
        
        viewcontroller.detail = item
        self.tabBarController?.tabBar.isHidden = true
        self.navigationController?.pushViewController(viewcontroller, animated: true)
    }
    
    
//-------------------------Filter for search bar------------------
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        if (searchText.characters.count == 0){
            self.legisFilter = self.legisFull
        }
        else{
            self.legisFilter = self.legisFull.filter{x in
                let name = x["first_name"].stringValue.uppercased() + " " + x["last_name"].stringValue.uppercased()
                return (name as NSString).contains(searchText.uppercased()) }
        }
        self.tableView.reloadData()
    }
    
//------------------------------------------------------------
    
    
    /*
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "reuseIdentifier", for: indexPath)

        // Configure the cell...

        return cell
    }
    */

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
