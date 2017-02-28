//
//  User.swift
//  ToDoList
//
//  Created by Frezy Stone Mboumba on 7/1/16.
//  Copyright © 2016 Frezy Stone Mboumba. All rights reserved.
//

import Foundation
import Firebase
import FirebaseDatabase


struct User {
    
    
    var username: String!
    var email: String!
    var photoUrl: String!
    var country: String!
    var ref: FIRDatabaseReference?
    var key: String
    
    init(snapshot: FIRDataSnapshot){
        
         let postDict = snapshot.value as? [String :AnyObject]
        
        key = snapshot.key
        username = postDict?["username"] as! String
        email = postDict?["email"] as! String
        photoUrl = postDict?["photoUrl"] as! String
        country = postDict?["country"] as! String
        ref = snapshot.ref
        
    }
    
    }
    
    
    
