//
//  HomeViewController.swift
//  whoot
//
//  Created by Carlos Estrada on 11/3/19.
//  Copyright © 2019 Carlos Estrada. All rights reserved.
//

import UIKit
import Firebase
import CoreLocation
class HomeViewController: UITableViewController {
    
    var posts = [userPost]()
    var loc = locationHelper()
   
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.tableView.refreshControl = UIRefreshControl()
        self.tableView.refreshControl?.addTarget(self, action: #selector(getPosts), for: .valueChanged)
        self.tableView.rowHeight = UITableView.automaticDimension
        self.tableView.estimatedRowHeight = 200
        
        let check = checkIfUserSignedIn()
        if check { getPosts() }
       
        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if (segue.identifier == "PostDetailView") {
            let cell = sender as! UITableViewCell
            let indexPath = tableView.indexPath(for: cell)!
            let post = posts[indexPath.row]
            let detailViewController = segue.destination as! PostDetailViewController
            detailViewController.post = post
            tableView.deselectRow(at: indexPath, animated: true)
        }
        else if (segue.identifier == "NewPostView") {
            let newPostController = segue.destination as! NewPostViewController
            newPostController.tableView = self
        }
    }
    
    // MARK: - Sign Out
    @IBAction func signOut() {
        do {
            try Auth.auth().signOut()
            let mainStoryboard:UIStoryboard = UIStoryboard(name: "Main", bundle: nil)
            let signIn = mainStoryboard.instantiateViewController(withIdentifier: "SignInView") as! SignInView
            self.present(signIn, animated: true, completion: nil)
            print("Sign out success")
        } catch let error as NSError {
            let alert = UIAlertController(title: "Error signing out",
                  message: error.localizedDescription, preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
            self.present(alert, animated: true)
        }
    }
    
    func checkIfUserSignedIn() -> Bool {
        if Auth.auth().currentUser != nil {
                    
            // User is signed in.
            print("\nUser already signed in \(String(describing: Auth.auth().currentUser?.uid))\n")
            return true
                    
        } else {
            
            // No user is signed in.
            print("No user signed in")
            let mainStoryboard:UIStoryboard = UIStoryboard(name: "Main", bundle: nil)
            let signIn = mainStoryboard.instantiateViewController(withIdentifier: "SignInView") as! SignInView
            self.present(signIn, animated: true, completion: nil)
            return false
        }
    }
    
    @objc func getPosts() {
        getAllPosts()
        
    }
    
    func getAllPosts() {
        //print(loc.lon)
        //print(loc.lat)
        DBHelper.getAllPosts(lat: loc.lat, lon: loc.lon) { (userPosts, error) in
            if error != nil {
                return
            }
            self.posts = userPosts
            self.tableView.reloadData()
            self.tableView.refreshControl?.endRefreshing()
        }
    }

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return posts.count
    }
    
    override func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return "Within 9 miles of Seaside, CA"
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell : PostTableViewCell = tableView.dequeueReusableCell(withIdentifier: "PostTableViewCell", for: indexPath) as! PostTableViewCell
        
        let post = posts[indexPath.row]

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
    }

}
