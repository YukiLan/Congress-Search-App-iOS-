//
//  filterViewController.swift
//  hw9
//
//  Created by ChenQianlan on 11/29/16.
//  Copyright © 2016 ChenQianlan. All rights reserved.
//

import UIKit

class filterViewController: UIViewController,UIPickerViewDataSource,UIPickerViewDelegate {
    
    let state : [String] = ["All State","Alabama","Alaska","Arizona","Arkansas","California","Colorado","Connecticut","Delaware","Florida","Georgia","Hawaii","Idaho","Illinois","Indiana","Iowa","Kansas","Kentucky","Louisiana","Maine","Maryland","Massachusetts","Michigan","Minnesota","Mississippi","Missouri","Montana","Nebraska","Nevada","New Hampshire","New Jersey","New Mexico","New York","North Carolina","North Dakota","Ohio","Oklahoma","Oregon","Pennsylvania","Rhode Island","South Carolina","South Dakota","Tennessee","Texas","Utah","Vermont","Virginia","Washington","West Virginia","Wisconsin","Wyoming"
    ]
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return state.count
    }
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return state[row]
    }
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        print("here")
        var viewcontroller = storyboard.instantiateViewController(withIdentifier: "LegisStateViewController") as! LegisStateViewController
            
        viewcontroller.state = state[row]
        self.navigationController?.pushViewController(viewcontroller, animated: true)
        /*
         let controller = self.navigationController?.topViewController as! LegisStateViewController
         controller.state = state[row]
         let selectState = controller.state
         if (selectState != "All State"){
         for (section, items) in controller.rowForSet{
         let filter = items.filter() { x in
         return x["state_name"].stringValue == selectState
         }
         if (filter.count != 0) {
         controller.rowForSet[section] = filter
         }
         }
         }
         controller.tableView.reloadData()
         */
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
