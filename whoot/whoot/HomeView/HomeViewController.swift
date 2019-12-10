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
        
        checkIfUserSignedIn()

        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false
        //loc.getLoc()
        //var a = loc.returnArr()
        //var a = loc.lon
        print(loc.lon)
        print(loc.lat)

        getPosts()
       
        
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
    
    func checkIfUserSignedIn() {
        if Auth.auth().currentUser != nil {
                    
            // User is signed in.
            print("\nUser already signed in \(String(describing: Auth.auth().currentUser?.uid))\n")
            
                    
        } else {
            
            // No user is signed in.
            print("No user signed in")
            let mainStoryboard:UIStoryboard = UIStoryboard(name: "Main", bundle: nil)
            let signIn = mainStoryboard.instantiateViewController(withIdentifier: "SignInView") as! SignInView
            self.present(signIn, animated: true, completion: nil)

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
        return "Within X miles of City, ST"
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell : PostTableViewCell = tableView.dequeueReusableCell(withIdentifier: "PostTableViewCell", for: indexPath) as! PostTableViewCell
        
        let post = posts[indexPath.row]

        // Configure the cell...
        cell.bodyText.text = post.getPostText()
        cell.timestamp.text = "\(post.getTimeAgo())"
        cell.upvoteCount.text = "\(post.getPoints())"

        return cell
    }

    /*
    // Override to support conditional editing of the table view.
    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the specified item to be editable.
        return true
    }
    */

    /*
    // Override to support editing the table view.
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            // Delete the row from the data source
            tableView.deleteRows(at: [indexPath], with: .fade)
        } else if editingStyle == .insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
        }    
    }
    */

    /*
    // Override to support rearranging the table view.
    override func tableView(_ tableView: UITableView, moveRowAt fromIndexPath: IndexPath, to: IndexPath) {

    }
    */

    /*
    // Override to support conditional rearranging of the table view.
    override func tableView(_ tableView: UITableView, canMoveRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the item to be re-orderable.
        return true
    }
    */

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
