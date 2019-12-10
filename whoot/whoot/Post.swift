//
//  post.swift
//  whoot
//
//  Created by Chris  on 11/4/19.
//  Copyright © 2019 Carlos Estrada. All rights reserved.
//

import Foundation
import CoreLocation

class userPost{
    private var text: String = ""
    private var UID: String = ""
    private var userUID: String = ""
    private var comment = [commentS]()
    private var upVotes: Int = 0
    private var downVotes: Int = 0
    private var createdAt: String = ""
    
  
    //var loc = locationHelper()
    var lat: Double = 0
    var lon: Double = 0
    
    init(text: String, llat: Double, llon: Double) {
        self.text = text
        self.downVotes = 0
        self.upVotes = 0
        //var loc = locationHelper()
        self.lat = llat
        self.lon = llon
    }
    
    func addComment(p:commentS){
        self.comment.append(p)
    }
    
    init(postUID: String, dictionary: [AnyHashable : Any]) {
        fromDictionary(postUID: postUID, dictionary: dictionary)
    }
    
    func setUID(uid: String) {
        self.UID = uid
    }
    
    
    func getUID() -> String {
        return self.UID
    }
    
    func setUserUID(userUID: String) {
        self.userUID = userUID
    }
    
    
    func getUserUID() -> String {
        return self.userUID
    }
    
    
    func setPostText(text: String) {
        self.text = text
    }
    
    func getPostText() -> String {
        return self.text
    }
    
    func upvote() {
        upVotes += 1
    }
    
    func downvote() {
        downVotes += 1
    }
    
    func getUpvotes() -> Int {
        return self.upVotes
    }
    
    func getDownvotes() -> Int {
        return self.downVotes
    }
    
    func getPoints() -> Int {
        return self.upVotes - self.downVotes
    }
    
    func setTimestamp() {
        let now = Date()
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ssZ"
        self.createdAt = formatter.string(from: now)
    }
    
    func getTimestamp() -> String {
        return createdAt
    }
    
    func getTimeAgo() -> String {
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ssZ"
        let date = formatter.date(from: self.createdAt)!
        return date.timeAgo()
    }
    
    func toDictionary() -> [AnyHashable : Any] {
        /*
        var comments = [AnyHashable : Any]()
        for post in comment{
        comments[post.getUID()] = post.toDictionary()
        }
        */
        
        var dict = [AnyHashable : Any]()
        dict = [
            "user_uid": UID,
            "body": text,
            "upvotes": upVotes,
            "downvotes": downVotes,
            "created_at": createdAt,
            "lat":lat,
            "lon":lon
        ]
        return dict
    }
    
    func fromDictionary(postUID: String, dictionary: [AnyHashable :Any]) {
        
        UID = postUID
        userUID = dictionary["user_uid"] as! String
        text = dictionary["body"] as! String
        upVotes = dictionary["upvotes"] as! Int
        downVotes = dictionary["downvotes"] as! Int
        createdAt = dictionary["created_at"] as! String
        lat = dictionary["lat"] as! Double
        lon = dictionary["lon"] as! Double
        
    }
    
}
