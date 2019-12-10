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
    
    @IBOutlet weak var upvoteButton: UIButton!
    @IBOutlet weak var downvoteButton: UIButton!
    
    var postUID: String = ""
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    func setUpvoteState(state: Bool) {
        if state == true {
            self.upvoteButton.setBackgroundImage(UIImage(systemName: "hand.thumbsup.fill"), for: .normal)
        }
        else {
            self.upvoteButton.setBackgroundImage(UIImage(systemName: "hand.thumbsup"), for: .normal)
        }
    }
    
    func setDownvoteState(state: Bool) {
        if state == true {
            self.downvoteButton.setBackgroundImage(UIImage(systemName: "hand.thumbsdown.fill"), for: .normal)
        }
        else {
            self.downvoteButton.setBackgroundImage(UIImage(systemName: "hand.thumbsdown"), for: .normal)
        }
    }
    
    @IBAction func upvotePost(_ sender: Any) {
        DBHelper.setUpvotes(postUID: postUID, upvoted: false) { (result, error) in
            self.setUpvoteState(state: result)
//            let count = self.upvoteCount.text as! Int
//            self.upvoteCount.text = "\(count + 1)"
        }
    }
    
    @IBAction func downvotePost(_ sender: Any) {
        DBHelper.setDownvotes(postUID: postUID, downvoted: false) { (result, error) in
            self.setDownvoteState(state: result)
//            let count = self.upvoteCount.text as! Int
//            self.upvoteCount.text = "\(count + 1)"
        }
    }
}
