//
//  LegisDetailViewController.swift
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
import CoreData


class LegisDetailViewController: UIViewController,UITableViewDataSource,UITableViewDelegate{
    
    static var favList = [JSON]()
    var flag = 0
    @IBOutlet weak var image: UIImageView!
    
    @IBOutlet weak var fav: UIBarButtonItem!
    
    @IBAction func addFav(_ sender: Any) {
        
        let app = UIApplication.shared.delegate as! AppDelegate
        let context = app.persistentContainer.viewContext
        let fetchRequest = NSFetchRequest<FavLegis>(entityName:"FavLegis")
        fetchRequest.fetchLimit = 1 //限定查询结果的数量
        fetchRequest.fetchOffset = 0
//        let predicate = NSPredicate(format: "bioguide_id= '1' ", "")
//        fetchRequest.predicate = predicate
        //var flag = 0
        do {
            let fetchedObjects = try context.fetch(fetchRequest)
            
            //遍历查询的结果
            for info in fetchedObjects{
                if (info.bioguide_id == self.detail["bioguide_id"].stringValue){
                    self.flag = 1
                    context.delete(info)
                    try! context.save()
                    self.fav.title = String.fontAwesomeIcon(name: .starO)
                }
            }
        }
        catch {
            fatalError("不能保存：\(error)")
        }
        if (self.flag == 0){
            self.fav.title = String.fontAwesomeIcon(name: .star)
            let legis = NSEntityDescription.insertNewObject(forEntityName: "FavLegis",
                                                           into: context) as! FavLegis
            
            //对象赋值
            legis.bioguide_id = self.detail["bioguide_id"].stringValue
            legis.image = "https://theunitedstates.io/images/congress/original/"+self.detail["bioguide_id"].stringValue+".jpg"
            legis.name = self.detail["first_name"].stringValue+" "+self.detail["last_name"].stringValue
            var birth = self.detail["birthday"].stringValue
            if birth == ""{
                legis.birthday = "N.A"
            }
            else{
                let dateFormatter = DateFormatter()
                dateFormatter.dateFormat = "yyyy-MM-dd"
                
                let birthday = dateFormatter.date(from: birth)
                dateFormatter.dateFormat = "dd MMM yyyy"
                //print(birthday)
                legis.birthday = dateFormatter.string(from: birthday!)
                let gender = self.detail["gender"].stringValue
                if (gender==""){
                    legis.gender = "N.A"
                }
                else{
                    if (gender=="M"){
                        legis.gender = "Male"
                        
                    }
                    else{
                        legis.gender = "Female"
                    }
                    
                }
                legis.state = self.detail["state_name"].stringValue
                legis.chamber = self.detail["chamber"].stringValue.capitalized
                let fax = self.detail["fax"].stringValue
                if (fax==""){
                    legis.fax = "N.A"
                }
                else{
                    legis.fax = fax
                }
                let twitter = self.detail["twitter_id"].stringValue
                if (twitter == ""){
                    legis.twitter = "N.A"
                }
                else{
                    legis.twitter = twitter
                }
                let website = self.detail["website"].stringValue
                if (website == ""){
                    legis.website = "N.A"
                }
                else{
                    legis.website = website
                }
                let office = self.detail["office"].stringValue
                if (office == ""){
                    legis.office = "N.A"
                }
                else{
                    legis.office = office
                }
                let end = self.detail["term_end"].stringValue
                if end == ""{
                    legis.term_end = "N.A"
                }
                else{
                    let dateFormatter = DateFormatter()
                    dateFormatter.dateFormat = "yyyy-MM-dd"
                    
                    let term_end = dateFormatter.date(from: end)
                    dateFormatter.dateFormat = "dd MMM yyyy"
                    //print(birthday)
                    legis.term_end = dateFormatter.string(from: term_end!)
                }

                
            }
            
            //保存
            do {
                try context.save()
                print("保存成功！")
            } catch {
                fatalError("不能保存：\(error)")
            }
        }
        

        
        if (FavLegisTableViewController.favList.contains(self.detail)){
            self.fav.title = String.fontAwesomeIcon(name: .starO)
            FavLegisTableViewController.favList = FavLegisTableViewController.favList.filter{$0 != self.detail}
        }
        else{
            self.fav.title = String.fontAwesomeIcon(name: .star)
            FavLegisTableViewController.favList.append(self.detail)
        }
 
    }
    
    var detail : JSON = nil
    //var name : String = ""
    var header : [String] = ["First Name","Last Name","State","Birthday","Gender","Chamber","Fax No.","Twitter","Facebook","Website","Office No.","Term ends on"]
    var content : [String] = []
    let twitter = UIButton()
    override func viewDidLoad() {
        super.viewDidLoad()
        //print(self.detail)
        
        
        
        
        self.tabBarController?.tabBar.isHidden = true
        
        let attributes = [NSFontAttributeName: UIFont.fontAwesome(ofSize: 20)] as [String: Any]
        self.fav.setTitleTextAttributes(attributes, for: .normal)
        if (FavLegisTableViewController.favList.contains(self.detail)){
            self.fav.title = String.fontAwesomeIcon(name: .star)
        }
        else{
            self.fav.title = String.fontAwesomeIcon(name: .starO)
        }
        /*
        if (self.falg == 1){
            self.fav.title = String.fontAwesomeIcon(name: .star)
        }
        else{
            self.fav.title = String.fontAwesomeIcon(name: .starO)
        }
*/
        
        
        
        let url = NSURL(string : "https://theunitedstates.io/images/congress/original/"+detail["bioguide_id"].stringValue+".jpg")
        let img_data = NSData(contentsOf: url! as URL)
        image.image = UIImage(data:img_data! as Data)
        content.append(self.detail["first_name"].stringValue)
        content.append(self.detail["last_name"].stringValue)
        content.append(self.detail["state_name"].stringValue)
        var birth = self.detail["birthday"].stringValue
        if birth == ""{
            content.append("N.A")
        }
        else{
            let dateFormatter = DateFormatter()
            dateFormatter.dateFormat = "yyyy-MM-dd"
            
            let birthday = dateFormatter.date(from: birth)
            dateFormatter.dateFormat = "dd MMM yyyy"
            //print(birthday)
            content.append(dateFormatter.string(from: birthday!))
        }
        
        //content.append(self.detail["birthday"].stringValue)
        //content.append()
        let gender = self.detail["gender"].stringValue
        if (gender==""){
            content.append("N.A")
        }
        else{
            if (gender=="M"){
                content.append("Male")
                
            }
            else{
                content.append("Female")
            }

        }
        content.append(self.detail["chamber"].stringValue.capitalized)
        let fax = self.detail["fax"].stringValue
        if (fax==""){
            content.append("N.A")
        }
        else{
            content.append(fax)
        }
        let twitter = self.detail["twitter_id"].stringValue
        if (twitter == ""){
            content.append("N.A")
        }
        else{
            content.append(twitter)
        }
        let facebook = self.detail["facebook_id"].stringValue
        if (facebook == ""){
            content.append("N.A")
        }
        else{
            content.append(facebook)
        }
        let website = self.detail["website"].stringValue
        if (website == ""){
            content.append("N.A")
        }
        else{
            content.append(website)
        }
        let office = self.detail["office"].stringValue
        if (office == ""){
            content.append("N.A")
        }
        else{
            content.append(office)
        }
        let end = self.detail["term_end"].stringValue
        if end == ""{
            content.append("N.A")
        }
        else{
            let dateFormatter = DateFormatter()
            dateFormatter.dateFormat = "yyyy-MM-dd"
            
            let term_end = dateFormatter.date(from: end)
            dateFormatter.dateFormat = "dd MMM yyyy"
            //print(birthday)
            content.append(dateFormatter.string(from: term_end!))
        }
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "rowcell", for: indexPath)
        if (indexPath.row==7){
            /*
            let button = UIButton(frame: CGRect(x: 100, y: 100, width: 100, height: 50))
            button.setTitle("Twitter Link", for: UIControlState.normal)
            button.addTarget(self, action: #selector(twitterLink), for: .touchUpInside)
            */
            //self.view.addSubview(button)
            cell.textLabel?.text = self.header[indexPath.row]
            if (self.content[7] == "N.A"){
                cell.detailTextLabel?.text = "N.A"
                cell.detailTextLabel?.textColor = UIColor.black
            }
            else{
                cell.detailTextLabel?.text = "Twitter Link"
                cell.detailTextLabel?.textColor = UIColor.blue
            }
            
        }
        else if (indexPath.row==8){
            cell.textLabel?.text = self.header[indexPath.row]
            
            if (self.content[8] == "N.A"){
                cell.detailTextLabel?.text = "N.A"
                cell.detailTextLabel?.textColor = UIColor.black
            }
            else{
                cell.detailTextLabel?.text = "Facebook Link"
                cell.detailTextLabel?.textColor = UIColor.blue
            }
            
        }
        else if (indexPath.row==9){
            cell.textLabel?.text = self.header[indexPath.row]
            
            if (self.content[8] == "N.A"){
                cell.detailTextLabel?.text = "N.A"
                cell.detailTextLabel?.textColor = UIColor.black
            }
            else{
                cell.detailTextLabel?.text = "Website Link"
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
    func twitterLink(sender:UIButton!) {
        let link = "https://twitter.com/"+self.content[7]
        if let url = NSURL(string: link) {
            UIApplication.shared.openURL(url as URL)
        }
        
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath){
        print("lsdllll")
        if (indexPath.row==7) && (self.content[7] != "N.A"){
            //print("lksdjglkdlgkja")
            let link = "https://twitter.com/"+self.content[7]
            //let url = NSURL(string : link)
            //UIApplication.shared.openURL(url as! URL)
            UIApplication.shared.openURL(NSURL(string: link)! as URL)
        }
        else if (indexPath.row==8) && (self.content[8] != "N.A"){
            let link = "https://facebook.com/"+self.content[8]
            let url = NSURL(string : link)
            UIApplication.shared.openURL(url as! URL)
        }
        else if (indexPath.row==9) && (self.content[9] != "N.A"){
            let link = self.content[9]
            let url = NSURL(string : link)
            UIApplication.shared.openURL(url as! URL)
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
