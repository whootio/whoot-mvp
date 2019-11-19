//
//  PostTableViewCell.swift
//  whoot
//
//  Created by Carlos Estrada on 11/13/19.
//  Copyright © 2019 Carlos Estrada. All rights reserved.
//

import UIKit

class PostTableViewCell: UITableViewCell {

    @IBOutlet weak var bodyText: UILabel!
    @IBOutlet weak var timestamp: UILabel!
    @IBOutlet weak var upvoteCount: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

    @IBAction func upvotePost(_ sender: Any) {
    }
    
    @IBAction func downvotePost(_ sender: Any) {
    }
}
