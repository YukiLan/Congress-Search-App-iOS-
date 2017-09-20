//
//  NaviBarViewController.swift
//  hw9
//
//  Created by ChenQianlan on 11/30/16.
//  Copyright © 2016 ChenQianlan. All rights reserved.
//

import UIKit
import SlideMenuControllerSwift

class NaviBarViewController: UIViewController,UITableViewDataSource,UITableViewDelegate {

    @IBOutlet weak var titleText: UILabel!
        
    @IBOutlet weak var image: UIImageView!
    
    let item : [String] = ["Legislators","Bills","Committees","Favorites","About"]
    override func viewDidLoad() {
        super.viewDidLoad()
        titleText.text = "Congress API"
        
        //self.tableView.backgroundColor = UIColor.lightGrayColor()
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "rowcell", for: indexPath)
        if (indexPath.row <= 4){
            cell.textLabel?.text = item[indexPath.row]
            cell.textLabel?.textColor = UIColor.gray
        }
        
        
        return cell

        
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 14
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        print("lskadjglkldsgakj;dsagjlkjsdlgk")
        if (indexPath.row <= 4){
            //let select = item[indexPath.row]
            let storyboard = UIStoryboard(name: "Main", bundle: nil)
            if (indexPath.row == 0){
                print("lakjgl")
                let LegisBarController = self.storyboard?.instantiateViewController(withIdentifier: "LegisBarController")
                self.slideMenuController()?.changeMainViewController(LegisBarController!, close: false)
                self.slideMenuController()?.closeLeft()
                //self.navigationController?.pushViewController(self.slideMenuController()!, animated: true)
                /*
                var viewcontroller = storyboard.instantiateViewController(withIdentifier: "LegisStateViewController") as! LegisStateViewController
                self.navigationController?.pushViewController(viewcontroller, animated: true)
 */
            }
            else if (indexPath.row == 1){
                /*
                var viewcontroller = storyboard.instantiateViewController(withIdentifier: "ActiveBillViewController") as! ActiveBillViewController
                self.navigationController?.pushViewController(viewcontroller, animated: true)
 */
                let BillBarController = self.storyboard?.instantiateViewController(withIdentifier: "BillBarController")
                self.slideMenuController()?.changeMainViewController(BillBarController!, close: false)
                self.slideMenuController()?.closeLeft()
            }
            else if (indexPath.row == 2){
                /*
                var viewcontroller = storyboard.instantiateViewController(withIdentifier: "HouseCommitteeViewController") as! HouseCommitteeViewController
                self.navigationController?.pushViewController(viewcontroller, animated: true)
 */
                let CommitBarController = self.storyboard?.instantiateViewController(withIdentifier: "CommitBarController")
                self.slideMenuController()?.changeMainViewController(CommitBarController!, close: false)
                self.slideMenuController()?.closeLeft()
            }
            else if (indexPath.row == 3){
                /*
                var viewcontroller = storyboard.instantiateViewController(withIdentifier: "FavLegisTableViewController") as! FavLegisTableViewController
                self.navigationController?.pushViewController(viewcontroller, animated: true)
 */
                let FavBarController = self.storyboard?.instantiateViewController(withIdentifier: "FavBarController")
                self.slideMenuController()?.changeMainViewController(FavBarController!, close: false)
                self.slideMenuController()?.closeLeft()
            }
            else if (indexPath.row == 4){
                /*
                var viewcontroller = storyboard.instantiateViewController(withIdentifier: "LegisStateViewController") as! LegisStateViewController
                self.navigationController?.pushViewController(viewcontroller, animated: true)
 */
                let AboutViewController = self.storyboard?.instantiateViewController(withIdentifier: "AboutViewController")
                self.slideMenuController()?.changeMainViewController(AboutViewController!, close: false)
                self.slideMenuController()?.closeLeft()
            }

        }
        
        
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
