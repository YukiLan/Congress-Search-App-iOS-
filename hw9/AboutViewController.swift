//
//  AboutViewController.swift
//  hw9
//
//  Created by ChenQianlan on 12/1/16.
//  Copyright © 2016 ChenQianlan. All rights reserved.
//

import UIKit
import SwiftSpinner
class AboutViewController: UIViewController {
    @IBOutlet weak var addNav: UIBarButtonItem!

    @IBAction func addNav(_ sender: Any) {
        self.slideMenuController()?.openLeft()
    }
    @IBOutlet weak var navB: UIBarButtonItem!
    override func viewDidLoad() {
        super.viewDidLoad()
        //self.tabBarController?.tabBar.isHidden = true
        let attributes = [NSFontAttributeName: UIFont.fontAwesome(ofSize: 20)] as [String: Any]
        self.navB.setTitleTextAttributes(attributes, for: .normal)
        self.navB.title = String.fontAwesomeIcon(name: .bars)

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
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
