//
//  TableViewCell.swift
//  FlightMe
//
//  Created by MIHAIL BUTNARU on 26/09/2017.
//  Copyright © 2017 MIHAIL BUTNARU. All rights reserved.
//

import UIKit

class TableViewCell: UITableViewCell {

    
    @IBOutlet weak var destination: UILabel!
    @IBOutlet weak var company: UILabel!
    @IBOutlet weak var location: UILabel!
    @IBOutlet weak var time: UILabel!
    @IBOutlet weak var terminal: UILabel!
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
   
}
