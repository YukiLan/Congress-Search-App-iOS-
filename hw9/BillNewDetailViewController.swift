//
//  BillNewDetailViewController.swift
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
class BillNewDetailViewController: UIViewController,UITableViewDataSource,UITableViewDelegate {
    static var favList = [JSON]()
    @IBOutlet weak var fav: UIBarButtonItem!
    
    @IBAction func addFav(_ sender: Any) {
        if (BillNewDetailViewController.favList.contains(self.detail)){
            self.fav.title = String.fontAwesomeIcon(name: .starO)
            BillNewDetailViewController.favList = BillNewDetailViewController.favList.filter{$0 != self.detail}
        }
        else{
            self.fav.title = String.fontAwesomeIcon(name: .star)
            BillNewDetailViewController.favList.append(self.detail)
        }
    }
    var detail : JSON = nil
    //var name : String = ""
    var header : [String] = ["Bill ID","Bill Type","Sponsor","Last Action","PDF","Chamber","Last Vote","Status"]
    var content : [String] = []
    
    @IBOutlet weak var titleText: UILabel!
    
    
    
    override func viewDidLoad() {
        print("here")
        print(self.detail)
        super.viewDidLoad()
        let attributes = [NSFontAttributeName: UIFont.fontAwesome(ofSize: 20)] as [String: Any]
        self.fav.setTitleTextAttributes(attributes, for: .normal)
        if (BillNewDetailViewController.favList.contains(self.detail)){
            self.fav.title = String.fontAwesomeIcon(name: .star)
        }
        else{
            self.fav.title = String.fontAwesomeIcon(name: .starO)
        }
        
        
        
        
        titleText.text = self.detail["official_title"].stringValue
        titleText?.numberOfLines = 0
        content.append(self.detail["bill_id"].stringValue)
        let type = self.detail["bill_type"].stringValue.uppercased()
        if (type == ""){
            content.append("N.A")
        }
        else{
            content.append(type)
        }
        
        content.append(self.detail["sponsor"]["title"].stringValue + " " + self.detail["sponsor"]["first_name"].stringValue + " " + self.detail["sponsor"]["last_name"].stringValue)
        
        var action = self.detail["last_action_at"].stringValue
        if (action == ""){
            content.append("N.A")
        }
        else{
            
            let endIndex = action.index(action.startIndex, offsetBy: 10)
            action = action.substring(to: endIndex)
            print(action)
            let dateFormatter = DateFormatter()
            dateFormatter.dateFormat = "yyyy-MM-dd"
            
            let last_action = dateFormatter.date(from: action)
            //print(last_action)
            dateFormatter.dateFormat = "dd MMM yyyy"
            print("lsdkjg")
            print(last_action)
            content.append(dateFormatter.string(from: last_action!))
        }
        let version = self.detail["last_version"]
        if (version == ""){
            content.append("N.A")
        }
        else{
            let urls = version["urls"]
            if (urls == ""){
                content.append("N.A")
            }
            else{
                let url = urls["pdf"].stringValue
                if (url == ""){
                    content.append("N.A")
                }
                else{
                    content.append(url)
                }
            }
        }
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
        content.append(self.detail["chamber"].stringValue.capitalized)
        var vote = self.self.detail["last_vote_at"].stringValue
        if vote == ""{
            content.append("N.A")
        }
        else{
            let endIndex = vote.index(vote.startIndex, offsetBy: 10)
            vote = vote.substring(to: endIndex)
            let dateFormatter = DateFormatter()
            dateFormatter.dateFormat = "yyyy-MM-dd"
            
            let last_vote = dateFormatter.date(from: vote)
            dateFormatter.dateFormat = "dd MMM yyyy"
            content.append(dateFormatter.string(from: last_vote!))
        }
        let active = self.detail["history"]["active"].boolValue
        print(active)
        if (active == true){
            content.append("Active")
        }
        else{
            content.append("New")
        }
        
        // Do any additional setup after loading the view.
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "rowcell", for: indexPath)
        if (indexPath.row==4){
            /*
             let button = UIButton(frame: CGRect(x: 100, y: 100, width: 100, height: 50))
             button.setTitle("Twitter Link", for: UIControlState.normal)
             button.addTarget(self, action: #selector(twitterLink), for: .touchUpInside)
             */
            //self.view.addSubview(button)
            cell.textLabel?.text = self.header[indexPath.row]
            if (self.content[4] == "N.A"){
                cell.detailTextLabel?.text = "N.A"
                cell.detailTextLabel?.textColor = UIColor.black
            }
            else{
                cell.detailTextLabel?.text = "PDF Link"
                cell.detailTextLabel?.textColor = UIColor.blue
            }
            
        }
        else{
            
            cell.textLabel?.text = self.header[indexPath.row]
            cell.detailTextLabel?.text = self.content[indexPath.row]
            cell.detailTextLabel?.textColor = UIColor.black
            
        }
        return cell
        
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.header.count
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath){
        print("lsdllll")
        print(indexPath.row)
        print(self.content[4])
        print("end")
        if (indexPath.row==4) && (self.content[4] != "N.A"){
            //print("lksdjglkdlgkja")
            let link = self.content[4]
            //let url = NSURL(string : link)
            //UIApplication.shared.openURL(url as! URL)
            print(link)
            UIApplication.shared.openURL(NSURL(string: link)! as URL)
        }
    }
    func tableView(_ tableView: UITableView, sectionForSectionIndexTitle title: String, at index: Int) -> Int {
        return index
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
