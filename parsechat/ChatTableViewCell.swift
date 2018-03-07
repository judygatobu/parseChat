//
//  ChatTableViewCell.swift
//  parsechat
//
//  Created by Judy Gatobu on 3/7/18.
//  Copyright © 2018 Judy Gatobu. All rights reserved.
//

import UIKit

class ChatTableViewCell: UITableViewCell {
    
    
    @IBOutlet weak var ChatUsernameLabel: UILabel!
    @IBOutlet weak var ChatLabel: UILabel!
    

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
