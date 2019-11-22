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

class SignUpView: UIViewController, UITextFieldDelegate {
    
    @IBOutlet weak var emailField: UITextField!
    @IBOutlet weak var passwordField: UITextField!
    @IBOutlet weak var signUpButton: UIButton!
    override func viewDidLoad() {
        super.viewDidLoad()
        signUpButton.layer.cornerRadius = 5
        signUpButton.clipsToBounds = true
        
        let tap: UITapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(UIInputViewController.dismissKeyboard))
        view.addGestureRecognizer(tap)
    }
    
    //Calls this function when the tap is recognized.
    @objc func dismissKeyboard() {
        //Causes the view (or one of its embedded text fields) to resign the first responder status.
        view.endEditing(true)
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        if textField == emailField {
            textField.resignFirstResponder()
            passwordField.becomeFirstResponder()
        } else if textField == passwordField {
            view.endEditing(true)
        }
        return true
    }
    
    @IBAction func signUpAction(_ sender: Any) {
        guard let password = passwordField.text else { return }
        guard let email = emailField.text else  { return }
        
        DBHelper.createUser(email: email, password: password) { result, error in
            if let error = error {
                
                // Something went wrong and we were not able to create the user's account
                // Show the user an error alert

                let alert = UIAlertController(title: "Sign Up Error",
                      message: error.localizedDescription, preferredStyle: .alert)
                alert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
                self.present(alert, animated: true)
                
            }
            else {
                // Successfully created the user and added them to the database
                // Continue to home feed
                
                print("user create success")
                self.performSegue(withIdentifier: "createAccountSegue", sender: nil)
                
            }
        }
    }
}
