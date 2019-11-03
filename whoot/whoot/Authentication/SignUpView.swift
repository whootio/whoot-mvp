//
//  SignUp.swift
//  whoot
//
//  Created by Carlos Estrada on 11/1/19.
//  Copyright © 2019 Carlos Estrada. All rights reserved.
//

import UIKit
import Firebase

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
        
        Auth.auth().createUser(withEmail: email, password: password) { user, error in
            if error != nil {
                
                // Something went wrong and we were not able to create the user's account
                
                let alert = UIAlertController(title: "Sign Up Error",
                      message: error?.localizedDescription, preferredStyle: .alert)
                alert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
                self.present(alert, animated: true)
                
            } else {
                
                // Successfully created and signed the user in
                print("user create success")
                self.performSegue(withIdentifier: "createAccountSegue", sender: nil)
                
            }
            
        }
    }
}
