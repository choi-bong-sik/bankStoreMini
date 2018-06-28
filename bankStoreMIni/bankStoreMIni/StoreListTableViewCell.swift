//
//  TableViewCell.swift
//  bankStoreMIni
//
//  Created by 최 봉식 on 2018. 6. 27..
//  Copyright © 2018년 jake. All rights reserved.
//

import UIKit

class StoreListTableViewCell: UITableViewCell {
    @IBOutlet weak var lblTitle:UILabel!
    @IBOutlet weak var lblNum:UILabel!
    @IBOutlet weak var lblSubTitle:UILabel!
    @IBOutlet weak var imgLogo:UIImageView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        
        // Configure the view for the selected state
    }
}
