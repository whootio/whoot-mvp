//
//  AdminView.swift
//  whoot
//
//  Created by Corey on 12/6/19.
//  Copyright © 2019 Carlos Estrada. All rights reserved.
//

import Foundation
import UIKit
import WebKit
import FirebaseAuth

class AdminView : UIViewController {
    @IBOutlet weak var adminWebView: WKWebView!

    override func viewDidLoad() {
        super.viewDidLoad()
        
        guard let user = Auth.auth().currentUser else { return }
        
        user.getIDTokenForcingRefresh(true) { token, error in
            if let error = error {
                // no token
                exit(-1);
            }
            
            self.adminWebView.customUserAgent = String("FirebaseToken:" + token!)
            
            let url = URL(string: "https://coursework.regex.be/")
            let Request = URLRequest(url: url!)
            
            self.adminWebView.load(Request)
        }
    }
    
    override func viewDidDisappear(_ animated: Bool) {
        guard let userView = self.storyboard?.instantiateViewController(identifier: "RootTabBar") else { exit(-1) }
        self.navigationController?.pushViewController(userView, animated: animated)
        //super.viewDidDisappear(animated)
    }
}
