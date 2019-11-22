//
//  User.swift
//  whoot
//
//  Created by Chris  on 11/4/19.
//  Copyright © 2019 Carlos Estrada. All rights reserved.
//

import Foundation
import Firebase
import FirebaseDatabase

class User{
    var UID: String = ""
    var upVotes: Int = 0
    var downVotes: Int = 0
    var Posts = [userPost]()
    var PostCount = 0
    
    init(userID: String) {
        self.UID = userID
    }
    
    func getUID() -> String{
        return self.UID
    }
    
    func getUpVotes() -> Int{
        return self.upVotes
    }
    
    func getDownVotes() -> Int{
        return self.downVotes
    }
    
    // What is the purpose of this function?
    func addPost(p:userPost){
        self.Posts.append(p)
    }

    func getJoinDate() -> Date {
        return Auth.auth().currentUser!.metadata.creationDate ?? Date(timeIntervalSince1970: 0)
    }
    
    func getAccessDate() -> Date {
        return Auth.auth().currentUser!.metadata.lastSignInDate ?? Date(timeIntervalSince1970: 0)
    }
    
    func getEmail() -> String {
        return Auth.auth().currentUser!.email ?? "none@example.org"
    }
    
    func getPostCount() -> Int {
        return DBHelper.getPostCountByUID(uid: self.UID)
    }
}
