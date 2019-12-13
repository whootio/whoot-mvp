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
    
    var isUpvoted: Bool = false
    var isDownvoted: Bool = false
    var upvoteCountInt: Int = 0
    var postUID: String = ""
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    func setVoteState(state: Int) {
        if state == 1 {
            setUpvoteState(state: true)
            setDownvoteState(state: false)
        }
        else if state == -1 {
            setUpvoteState(state: false)
            setDownvoteState(state: true)
        }
        else {
            setUpvoteState(state: false)
            setDownvoteState(state: false)
        }
    }
    
    func setUpvoteState(state: Bool) {
        self.isUpvoted = state
        if state == true {
            self.upvoteButton.setBackgroundImage(UIImage(systemName: "hand.thumbsup.fill"), for: .normal)
        }
        else {
            self.upvoteButton.setBackgroundImage(UIImage(systemName: "hand.thumbsup"), for: .normal)
        }
    }
    
    func setDownvoteState(state: Bool) {
        self.isDownvoted = state
        if state == true {
            self.downvoteButton.setBackgroundImage(UIImage(systemName: "hand.thumbsdown.fill"), for: .normal)
        }
        else {
            self.downvoteButton.setBackgroundImage(UIImage(systemName: "hand.thumbsdown"), for: .normal)
        }
    }
    
    @IBAction func upvotePost(_ sender: Any) {
        let prevVal = (isUpvoted ? 1 : 0)
        DBHelper.setUpvotes(postUID: postUID, prevVal: prevVal) { (result, error) in
            
            if (self.isDownvoted) {
                self.upvoteCountInt += 1
            }
            
            self.setVoteState(state: result)
            
            if (result == 1) {
                self.upvoteCountInt += 1
            } else {
                self.upvoteCountInt -= 1
            }
            
            self.upvoteCount.text = "\(self.upvoteCountInt)"
        }
    }
    
    @IBAction func downvotePost(_ sender: Any) {
        let prevVal = (isDownvoted ? -1 : 0)
        DBHelper.setDownvotes(postUID: postUID, prevVal: prevVal) { (result, error) in
            
            if (self.isUpvoted) {
                self.upvoteCountInt -= 1
            }
            
            self.setVoteState(state: result)
            
            if (result == -1) {
                self.upvoteCountInt -= 1
            } else {
                self.upvoteCountInt += 1
            }
            
            self.upvoteCount.text = "\(self.upvoteCountInt)"
        }
    }
}
