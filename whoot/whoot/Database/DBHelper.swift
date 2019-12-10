//
//  DBHelper.swift
//  whoot
//
//  Created by Carlos Estrada on 11/5/19.
//  Copyright © 2019 Carlos Estrada. All rights reserved.
//

import Firebase
import CoreLocation
import UIKit
import Foundation
import MapKit

struct DBHelper {
    
    static var db = Database.database().reference()
    static var users = db.child("users")
    static var posts = db.child("posts")
    
    // MARK: Helper functions
    
    private static func getTimestampAsString() -> String {
        let now = Date()
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ssZ"
        return formatter.string(from: now)
    }
    
    // MARK: User Operations
    
    static func createUser(email: String, password: String, completion: @escaping (AuthDataResult?, Error?) -> ()) {
        
        Auth.auth().createUser(withEmail: email, password: password) { result, error in
            if error != nil {
                
                // There was an error creating the user
                completion(result, error)
                
            } else {
                
                // The user was created, add them to the database
                
                guard let uid = result?.user.uid else { return }
                
                
                let userValues : [AnyHashable : Any] = [
                    "email": email,
                    "created_at": getTimestampAsString(),
                    "upvotes": 0,
                    "downvotes": 0
                ]

                users.child(uid).updateChildValues(userValues, withCompletionBlock: { (error, ref) in
                    if let error = error {
                        
                        // The user couldn't be added to the database for some reason
                        print("failed to update database values \(error.localizedDescription)")
                        return
                        
                    }
                })
                
                completion(result, nil)
                
            }

        }
    }
    
    func getUserByUID(uid: String) {
        // return a user object given a valid UID
    }
    
    // MARK: Post Operations
    
    static func createPost(post: userPost, completion: @escaping (Error?, DatabaseReference?) -> ()) {
        // We can assume that a user is already signed in
        
        
        // initialize the post information
        post.setTimestamp()
//        post.setLocation()
        // Grab the current user's information for associating it with the post
        if let user = Auth.auth().currentUser {
            post.setUID(uid: user.uid)
        }
        
        // Create mutable (modifiable) dictionary
        let postDict = post.toDictionary()
        
        // Generate a UID for the post and insert it into the database
        let post = posts.childByAutoId()
        post.setValue(postDict) { (error, ref) in
            if error != nil {
                print("Create Post Error: \(String(describing: error?.localizedDescription))")
                completion(error, ref)
            }
            else {
                print("Create Post Success.")
                completion(nil, ref)
            }
        }
    }
    
    static func createComment(post: userPost, commentText: String, completion: @escaping (Error?, DatabaseReference?) -> ()) {
        // We can assume that a user is already signed in
        var p = posts.child(post.getUID())
        var comment = p.child("comments").childByAutoId()
        var commentClass = commentS(text: commentText)
        // initialize the post information
        commentClass.setTimestamp()
        
        // Grab the current user's information for associating it with the post
        if let user = Auth.auth().currentUser {
            commentClass.setUID(uid: user.uid)
        }
        
        // Create mutable (modifiable) dictionary
        let commentDict = commentClass.toDictionary()
        
        // Generate a UID for the post and insert it into the database
        comment.setValue(commentDict) { (error, ref) in
            if error != nil {
                print("Create Post Error: \(String(describing: error?.localizedDescription))")
                completion(error, ref)
            }
            else {
                print("Create Post Success.")
                completion(nil, ref)
            }
        }
    }
    
    /*
     Get post count for a given UID.
     It seems this can only be done async, so requires use of a callback.
     Returns Void.
     */
    static func getPostCountByUID(uid: String, completion: @escaping (Int, Error?) -> ()) {
        self.posts.queryOrdered(byChild: "uid").queryEqual(toValue: uid).observeSingleEvent(of: .value, with: { (snapshot) in
            completion(Int(snapshot.childrenCount), nil)
        }, withCancel: { (error) in {
            completion(-1, error);
        }()})
    }
    
    func getPostsByUID(uid: String) {
        // Query for posts using the user's UID
        // We assume that the Post object will have a fromDictionary() method that deserializes its data
        // Return an array of Post objects associated with the provided UID
    }
   // -121.60995186244769
   // 36.67298620913742
    static func getAllPosts(lat: Double, lon: Double,completion: @escaping ([userPost], Error?) -> ()) {
        let te = CLLocation(latitude: lat, longitude: lon)
        
        //CLLocationDistance meters = [te distanceFromLocation:te]
        //var distanceMeters = te.distanceFromLocation(destination)
        
        var postArray = [userPost]()
        
        posts.observeSingleEvent(of: .value, with: { (snapshot) in
            for child in snapshot.children {
                if let childSnapshot = child as? DataSnapshot,
                let data = childSnapshot.value as? [AnyHashable : Any] {
                    let post = userPost(dictionary: data)
                    
                    var de = CLLocation(latitude: post.lat, longitude: post.lon)
                    //var distanceMeters = 5
                    var distanceMeters = te.distance(from: de)
                    
                    if(distanceMeters < 500){
                        postArray.insert(post, at: 0)
                    }
                }
            }
            completion(postArray, nil)
        }) { (error) in
            completion(postArray, error)
        }
    }
    
    func getPostsByLocation(lat: Double, lon: Double/*location: CLLocationCoordinate2D, radiusInMiles: Int*/) {
        // Check if the location is not null (ie: the user has location services on)
        // If it's null, grab all posts (maybe)
        // If it's available use it to query for posts within a specified mile radius
        // Return a list of all posts within the provided location

        
    }
}
