//
//  CommiSenateDetailViewController.swift
//  hw9
//
//  Created by ChenQianlan on 11/30/16.
//  Copyright © 2016 ChenQianlan. All rights reserved.
//

import UIKit
import Alamofire
import SwiftyJSON
import SwiftSpinner
import FontAwesome_swift
class CommiSenateDetailViewController: UIViewController,UITableViewDataSource {
    
    static var favList = [JSON]()  
    @IBOutlet weak var fav: UIBarButtonItem!
  
    @IBAction func addFav(_ sender: Any) {
        if (CommiSenateDetailViewController.favList.contains(self.detail)){
            self.fav.title = String.fontAwesomeIcon(name: .starO)
            CommiSenateDetailViewController.favList = CommiSenateDetailViewController.favList.filter{$0 != self.detail}
        }
        else{
            self.fav.title = String.fontAwesomeIcon(name: .star)
            CommiSenateDetailViewController.favList.append(self.detail)
        }
    }
    
    @IBOutlet weak var titleText: UILabel!
    
    var detail : JSON = nil
    //var name : String = ""
    var header : [String] = ["ID","Parent ID","Chamber","Office","Contact"]
    var content : [String] = []
    override func viewDidLoad() {
        super.viewDidLoad()
        let attributes = [NSFontAttributeName: UIFont.fontAwesome(ofSize: 20)] as [String: Any]
        self.fav.setTitleTextAttributes(attributes, for: .normal)
        if (CommiSenateDetailViewController.favList.contains(self.detail)){
            self.fav.title = String.fontAwesomeIcon(name: .star)
        }
        else{
            self.fav.title = String.fontAwesomeIcon(name: .starO)
        }
        
        
        
        
        titleText.text = self.detail["name"].stringValue
        titleText?.numberOfLines = 0
        content.append("committee_id")
        let parent_id = self.detail["parent_committee_id"].stringValue
        if (parent_id == ""){
            content.append("N.A")
        }
        else{
            content.append(parent_id)
        }
        content.append(self.detail["chamber"].stringValue.capitalized)
        
        
        //content.append(self.detail["last_version"]["urls"]["pdf"].stringValue)
        /*
         let url = self.detail["last_version"]["urls"]["pdf"].stringValue
         if (url == ""){
         content.append("N.A")
         }
         else{
         content.append(url)
         }
         */
        let office = self.detail["office"].stringValue
        if (office == ""){
            content.append("N.A")
        }
        else{
            content.append(office)
        }
        
        let contact = self.detail["phone"].stringValue
        if (contact == ""){
            content.append("N.A")
        }
        else{
            content.append(contact)
        }
        
        // Do any additional setup after loading the view.
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "rowcell", for: indexPath)
        
        cell.textLabel?.text = self.header[indexPath.row]
        cell.detailTextLabel?.text = self.content[indexPath.row]
        cell.detailTextLabel?.textColor = UIColor.black
        
        return cell
        
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.header.count
    }
    /*
     // MARK: - Navigation
     
     // In a storyboard-based application, you will often want to do a little preparation before navigation
     override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
     // Get the new view controller using segue.destinationViewController.
     // Pass the selected object to the new view controller.
     }
     */
    
}
