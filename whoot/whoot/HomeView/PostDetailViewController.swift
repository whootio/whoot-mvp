//
//  PostDetailTableViewController.swift
//  whoot
//
//  Created by Carlos Estrada on 12/11/19.
//  Copyright © 2019 Carlos Estrada. All rights reserved.
//

import UIKit

class PostDetailViewController: UITableViewController {
    
    var post = userPost(text: "", llat: 0, llon: 0)
    var comments = [commentS]()

    override func viewDidLoad() {
        super.viewDidLoad()
        self.tableView.refreshControl = UIRefreshControl()
        self.tableView.refreshControl?.addTarget(self, action: #selector(getComments), for: .valueChanged)
        getComments()
    }

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 2
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        if (section == 0) {
            return 1
        }
        return comments.count
    }
    
    override func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        if (section == 0) {
            return "Post Details"
        }
        return "All Comments"
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if (indexPath.section == 0) {
            let cell : PostTableViewCell = tableView.dequeueReusableCell(withIdentifier: "PostTableViewCell", for: indexPath) as! PostTableViewCell

            // Configure the cell...
            cell.bodyText.text = post.getPostText()
            cell.timestamp.text = "\(post.getTimeAgo())"
            cell.upvoteCount.text = "\(post.getPoints())"
            cell.upvoteCountInt = post.getPoints()
            cell.postUID = post.getUID()
            
            DBHelper.checkPostVoteState(postUID: post.getUID()) { (state, error) in
                cell.setVoteState(state: state!)
            }

            return cell
        } else {
            let cell : PostTableViewCell = tableView.dequeueReusableCell(withIdentifier: "PostTableViewCell", for: indexPath) as! PostTableViewCell

            let comment = comments[indexPath.row]
            cell.bodyText.text = comment.getPostText()
            cell.timestamp.text = "\(comment.getTimeAgo())"
            cell.upvoteCount.text = "\(comment.getPoints())"
            cell.upvoteCountInt = comment.getPoints()
            cell.postUID = comment.getUID()
            
            DBHelper.checkPostVoteState(postUID: comment.getUID()) { (state, error) in
                cell.setVoteState(state: state!)
            }

            return cell
        }
    }
    
    @objc func getComments() {
        getAllComments()
    }
    
    func getAllComments() {
        DBHelper.getAllComments(UID: post.getUID()) { (comments, error) in
            self.comments = comments
            self.tableView.reloadData()
            self.tableView.refreshControl?.endRefreshing()
        }
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let newCommentController = segue.destination as! NewCommentViewController
        newCommentController.post = post
        newCommentController.tableView = self
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
