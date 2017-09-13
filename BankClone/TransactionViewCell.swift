//
//  TransactionViewCell.swift
//  BankClone
//
//  Created by Israel Carvajal on 8/12/17.
//  Copyright © 2017 Parse. All rights reserved.
//

import UIKit

class TransactionViewCell: UITableViewCell {

    @IBOutlet weak var amountTL: UILabel!
    @IBOutlet weak var dateTL: UILabel!
    @IBOutlet weak var descriptionTL: UILabel!
        
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
