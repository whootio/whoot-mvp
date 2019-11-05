//
//  SignUp.swift
//  whoot
//
//  Created by Carlos Estrada on 11/1/19.
//  Copyright © 2019 Carlos Estrada. All rights reserved.
//

import UIKit
import Firebase
import FirebaseDatabase

class SignUpView: UIViewController {
    
    @IBOutlet weak var emailField: UITextField!
    @IBOutlet weak var passwordField: UITextField!
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
    }
    
    @IBAction func signUpAction(_ sender: Any) {
        guard let password = passwordField.text else { return }
        guard let email = emailField.text else  { return }
        
        Auth.auth().createUser(withEmail: email, password: password) { result, error in
            if let error = error {
                
                // Something went wrong and we were not able to create the user's account
                
                let alert = UIAlertController(title: "Sign Up Error",
                      message: error.localizedDescription, preferredStyle: .alert)
                alert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
                self.present(alert, animated: true)
                
            } else {
                
                // Add user to database
                
                guard let uid = result?.user.uid else { return }
                
                let values = ["email": email]
                
                Database.database().reference().child("users").child(uid).updateChildValues(values, withCompletionBlock: { (error, ref) in
                    if let error = error {
                        print("failed to update database values \(error.localizedDescription)")
                        return
                    }
                })
                
                // Successfully created the user
                print("user create success")
                
                self.performSegue(withIdentifier: "createAccountSegue", sender: nil)
                
            }
            
        }
    }
}
