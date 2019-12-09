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
    //location
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
    
    init(dictionary: [AnyHashable : Any]) {
        fromDictionary(dictionary: dictionary)
    }
    
    func setUID(uid: String) {
        self.UID = uid
    }
    
    func getUID() -> String {
        return self.UID
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
    
    //func getLocation() -> Location
    func setLocation(){
        //et loc = locationHelper()
        //loc.getLoc()
//        self.lat = loc.lat
//        self.lon = loc.lon
    }
    
    func toDictionary() -> [AnyHashable : Any] {
        var dict = [AnyHashable : Any]()
        dict = [
            "uid": UID,
            "body": text,
            "upvotes": upVotes,
            "downvotes": downVotes,
            "created_at": createdAt,
            "lat":lat,
            "lon":lon
        ]
        return dict
    }
    
    func fromDictionary(dictionary: [AnyHashable :Any]) {
        UID = dictionary["uid"] as! String
        text = dictionary["body"] as! String
        upVotes = dictionary["upvotes"] as! Int
        downVotes = dictionary["downvotes"] as! Int
        createdAt = dictionary["created_at"] as! String
        lat = dictionary["lat"] as! Double
        lon = dictionary["lon"] as! Double
        
    }
    
}
