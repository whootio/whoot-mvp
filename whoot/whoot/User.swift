//
//  User.swift
//  whoot
//
//  Created by Chris  on 11/4/19.
//  Copyright © 2019 Carlos Estrada. All rights reserved.
//

import Foundation

class User{
    var UID: String = ""
    var upVotes: Int = 0
    var downVotes: Int = 0
    var Posts = [userPost]()
    
    func getUID() -> String{
        return self.UID
    }
    
    func getupVotes() -> Int{
        return self.upVotes
    }
    
    func getdownVotes() -> Int{
        return self.downVotes
    }
    
    func addPost(p:userPost){
        self.Posts.append(p)
    }

}
