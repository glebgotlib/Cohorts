//
//  NotificationTableViewCell.swift
//  Cohorts
//
//  Created by Gotlib on 12.11.16.
//  Copyright © 2016 Yog.group. All rights reserved.
//

import UIKit

class NotificationTableViewCell: UITableViewCell {
    @IBOutlet weak var main_img: UIImageView!
    @IBOutlet weak var history_title: UILabel!
    @IBOutlet weak var history_date: UILabel!
    @IBOutlet weak var promote: UIImageView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
