//
//  SignIn.swift
//  whoot
//
//  Created by Carlos Estrada on 11/1/19.
//  Copyright © 2019 Carlos Estrada. All rights reserved.
//

import UIKit
import Firebase


class SignInView: UIViewController {

    
    @IBOutlet weak var emailField: UITextField!
    @IBOutlet weak var passwordField: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    @IBAction func SignIn(_ sender: Any) {
        guard let email = emailField.text else { return }
        guard let password = passwordField.text else { return }
        
        Auth.auth().signIn(withEmail: email, password: password) { result, error in
            if let error = error {
                
                // There was an error signing the user in, show them an alert
                
                let alert = UIAlertController(title: "Sign In Error",
                      message: error.localizedDescription, preferredStyle: .alert)
                alert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
                self.present(alert, animated: true)
                
            } else {
                
                // User signed in successfully, continue to home feed
                
                print("User sign in success")
                self.performSegue(withIdentifier: "signInSegue", sender: nil)
            }
        }

    }
}
