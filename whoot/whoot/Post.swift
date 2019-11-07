//
//  post.swift
//  whoot
//
//  Created by Chris  on 11/4/19.
//  Copyright © 2019 Carlos Estrada. All rights reserved.
//

import Foundation

class userPost{
    var text: String = ""
    var UID: String = ""
    //location
    var upVotes: Int = 0
    var downVotes: Int = 0
    
    
    func getUID() -> String{
        return self.UID
    }
    
    func getPostText() -> String{
        return self.text
    }
    
    func getUpvotes() -> Int{
        return self.upVotes
    }
    
    func getDownvotes() -> Int{
        return self.downVotes
    }
    
    func getPoints() -> Int{
        return self.upVotes - self.downVotes
    }
    
    //func getLocation() -> Location
    
    
}
