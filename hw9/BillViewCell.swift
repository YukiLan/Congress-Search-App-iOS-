//
//  BillViewCell.swift
//  hw9
//
//  Created by ChenQianlan on 11/29/16.
//  Copyright © 2016 ChenQianlan. All rights reserved.
//

import UIKit

class BillViewCell: UITableViewCell {
    
    @IBOutlet weak var newBillID: UILabel!

    @IBOutlet weak var newBillCell: UILabel!
    
    @IBOutlet weak var newBillDate: UILabel!
    
    
    @IBOutlet weak var activeBillID: UILabel!
    
    @IBOutlet weak var billCellText: UILabel!
    
    @IBOutlet weak var activeBillDate: UILabel!
    @IBOutlet weak var favBillText: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
