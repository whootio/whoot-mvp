//
//  NewComment.swift
//  whoot
//
//  Created by idamarire okumagba on 12/9/19.
//  Copyright © 2019 Carlos Estrada. All rights reserved.
//



import UIKit




class NewCommentViewController: UIViewController {

    var post: userPost = userPost(text: "String",llat: 0,llon: 0)
    var tableView = PostDetailViewController()
    
    @IBOutlet weak var texview: UITextView!
    override func viewDidLoad() {
        super.viewDidLoad()

        texview.placeholder = "Add a comment..."
        
        // Do any additional setup after loading the view.
    }
    
    @IBAction func cancel(_ sender: Any) {
    dismiss(animated: true, completion: nil)
    }
    
    
    @IBAction func createPost(_ sender: Any) {
    
    
        let body = texview.text
       
       
        let comment = commentS(text: body!)
        // right now posts consist of only body text
        // we can add location, media, etc. later
        
        DBHelper.createComment(post: post.getUID(), comment: comment)
        { (error, ref) in
            if let error = error {
                let alert = UIAlertController(title: "Post Error",
                      message: String(describing: error.localizedDescription), preferredStyle: .alert)
                alert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
                self.present(alert, animated: true)
            }
            else {
                self.dismiss(animated: true) {
                    self.tableView.getComments()
                }
            }
        }
        
    }
    
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */
    
    //comment section
    
    
    
    
    

}

