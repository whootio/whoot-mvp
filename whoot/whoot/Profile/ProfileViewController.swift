//
//  ProfileViewController.swift
//  whoot
//
//  Created by Corey on 11/18/19.
//  Copyright © 2019 Carlos Estrada. All rights reserved.
//

import UIKit
import Firebase
import FirebaseDatabase

class ProfileViewController: UIViewController {

    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var joinedLabel: UILabel!
    @IBOutlet weak var lastSeenLabel: UILabel!
    @IBOutlet weak var totalPosts: UILabel!
    @IBOutlet weak var totalPostsLabel: UILabel!
    @IBOutlet weak var upvotesLabel: UILabel!
    @IBOutlet weak var downvotesLabel: UILabel!
    @IBOutlet weak var totalPointsLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        if Auth.auth().currentUser == nil {
            exit(0);
        }
        
        let currentUser = User(userID: Auth.auth().currentUser!.uid)
        
        let dateFormatter = DateFormatter()
        
        dateFormatter.dateStyle = .medium
        dateFormatter.timeStyle = .short
        dateFormatter.locale = Locale(identifier: "en_US")
        
        nameLabel.text = currentUser.getEmail()
        
        joinedLabel.text = dateFormatter.string(from: currentUser.getJoinDate())
        
        lastSeenLabel.text = dateFormatter.string(from: currentUser.getAccessDate())
        
        currentUser.getPostCount() {postCount,error in
            if error != nil {
                /*
                self.totalPosts.isHidden = true;
                self.totalPostsLabel.isHidden = true;
                 */
                self.totalPostsLabel.text = "25"
            } else {
                if ( postCount == 0 ) {
                    self.totalPostsLabel.text = "25"
                } else {
                    self.totalPostsLabel.text = String(postCount)
                }
            }
        }
        
        upvotesLabel.text = String(currentUser.getUpVotes())
        
        downvotesLabel.text = String(currentUser.getDownVotes())
        
        totalPointsLabel.text = String(currentUser.getTotalPoints())
        
        
        // Do any additional setup after loading the view.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
