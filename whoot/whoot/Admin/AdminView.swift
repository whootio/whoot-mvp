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

class AdminView : UIViewController {
    @IBOutlet weak var adminWebView: WKWebView!

    override func viewDidLoad() {
        super.viewDidLoad()
        
        // swipe-able delete/suspend?
        let url = URL(string: "https://coursework.regex.be")
        let Request = URLRequest(url: url!)
        
        adminWebView.load(Request)
        
        //adminWebView.
    }
    
    override func viewDidDisappear(_ animated: Bool) {
        guard let userView = self.storyboard?.instantiateViewController(identifier: "RootTabBar") else { exit(-1) }
        self.navigationController?.pushViewController(userView, animated: animated)
        //super.viewDidDisappear(animated)
    }
}
