//
//  NewPostViewController.swift
//  whoot
//
//  Created by Carlos Estrada on 11/13/19.
//  Copyright © 2019 Carlos Estrada. All rights reserved.
//

import UIKit

class NewPostViewController: UIViewController {

    @IBOutlet weak var postBodyText: UITextView!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    @IBAction func cancelNewPost(_ sender: Any) {
        dismiss(animated: true, completion: nil)
    }
    
    @IBAction func createNewPost(_ sender: Any) {
        let body = postBodyText.text
        let post = userPost(text: body!)
        
        // right now posts consist of only body text
        // we can add location, media, etc. later
        
        DBHelper.createPost(post: post) { (error, ref) in
            if let error = error {
                let alert = UIAlertController(title: "Post Error",
                      message: String(describing: error.localizedDescription), preferredStyle: .alert)
                alert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
                self.present(alert, animated: true)
            }
            else {
                self.dismiss(animated: true, completion: nil)
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

}
