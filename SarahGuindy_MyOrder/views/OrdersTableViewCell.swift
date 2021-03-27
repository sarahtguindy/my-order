//
//  OrdersTableViewCell.swift
//  SarahGuindy_MyOrder
//
//  Created by Sarah Guindy on 2021-02-20.
//  Student number: 147465173
//

import UIKit

class OrdersTableViewCell: UITableViewCell {
    
    @IBOutlet var lblSize : UILabel!
    @IBOutlet var lblType : UILabel!
    @IBOutlet var lblQuantity : UILabel!

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        // Configure the view for the selected state
    }

}
