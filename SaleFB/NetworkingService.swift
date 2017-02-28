//
//  ConnectFirebase.swift
//  SaleFB
//
//  Created by Qusai Asaad on 17.2.2017.
//  Copyright © 2017 Qusai Asaad. All rights reserved.
//

import Foundation
import Firebase
import FirebaseAuth
import FirebaseStorage
import FirebaseDatabase
import UIKit


struct NetworkingService {
    
    var databaseRef: FIRDatabaseReference! {
        return FIRDatabase.database().reference()
    }
    
    var storageRef: FIRStorageReference {
        return FIRStorage.storage().reference()
    }
    
    
    
    // 3 --- Saving the user Info in the database
    fileprivate func saveInfo(_ user: FIRUser!, username: String, password: String, country: String,tool:String){
        
        // Create our user dictionary info\
        
        let userInfo = ["email": user.email!, "username": username, "country": country, "uid": user.uid, "photoUrl": String(describing: user.photoURL!),"tool":tool,"postDate":FIRServerValue.timestamp()] as [String : Any]
        
        // create user reference
        
        let userRef = databaseRef.child("users").child(user.uid)
        
        // Save the user info in the Database
        
        userRef.setValue(userInfo)
        
        
        // Signing in the user
        signIn(user.email!, password: password)
        
    }
    
    
    // 4 ---- Signing in the User
    func signIn(_ email: String, password: String){
        
        FIRAuth.auth()?.signIn(withEmail: email, password: password, completion: { (user, error) in
            if error == nil {
                
                if let user = user {
                    
                    print("\(user.displayName!) has signed in succesfully!")
                    
                    let appDel: AppDelegate = UIApplication.shared.delegate as! AppDelegate
                    appDel.logUser()
                    
                }
                
            }else {
                
                print(error!.localizedDescription)
                
            }
        })
        
    }
    
    // 2 ------ Set User Info
    
    fileprivate func setUserInfo(_ user: FIRUser!, username: String, password: String, country: String, data: Data!,tool:String){
        
        //Create Path for the User Image
        let imagePath = "profileImage\(user.uid)/userPic.jpg"
        
        
        // Create image Reference
        
        let imageRef = storageRef.child(imagePath)
        
        // Create Metadata for the image
        
        let metaData = FIRStorageMetadata()
        metaData.contentType = "image/jpeg"
        
        // Save the user Image in the Firebase Storage File
        
        imageRef.put(data, metadata: metaData) { (metaData, error) in
            if error == nil {
                
                let changeRequest = user.profileChangeRequest()
                changeRequest.displayName = username
                changeRequest.photoURL = metaData!.downloadURL()
                changeRequest.commitChanges(completion: { (error) in
                    
                    if error == nil {
                        
                        self.saveInfo(user, username: username, password: password, country: country,tool:tool)
                        
                    }else{
                        print(error!.localizedDescription)
                        
                    }
                })
                
                
            }else {
                print(error!.localizedDescription)
                
            }
        }
        
        
        
        
        
    }
    // Reset Password
    func resetPassword(_ email: String){
        FIRAuth.auth()?.sendPasswordReset(withEmail: email, completion: { (error) in
            if error == nil {
                print("An email with information on how to reset your password has been sent to you. thank You")
            }else {
                print(error!.localizedDescription)
                
            }
        })
        
    }
    
    // 1 ---- We create the User
    
    func signUp(_ email: String, username: String, password: String, country: String, data: Data!,tool: String){
        
        FIRAuth.auth()?.createUser(withEmail: email, password: password, completion: { (user, error) in
            
            if error == nil {
                
                self.setUserInfo(user, username: username, password: password, country: country, data: data,tool:tool)
              
            }else {
                print(error!.localizedDescription)
                
            }
        })
        
        
    }
    
    
    
    // Tool 1
    func  addTool(name:String,price:String,discription:String,photo:Data!,type:String,user:FIRUser){
       
        
        setToolInfo(name: name, price: price, discription: discription, data: photo, type: type, user: user)
        
       
    }
    // Tool 2
    fileprivate func setToolInfo(name:String,price:String,discription:String,data:Data!,type:String,user:FIRUser){
        
        let dateformat=DateFormatter()
        dateformat.dateFormat="MM_DD_yy_h_mm_a"
        let imageName=dateformat.string(from: NSDate() as Date )
        
        let imagePath = "ToolImage\(imageName)/userPic.jpg"
        
        
        // Create image Reference
        
        let imageRef = storageRef.child(imagePath)
        
        // Create Metadata for the image
        
        let metaData = FIRStorageMetadata()
        metaData.contentType = "image/jpeg"
        
        // Save the user Image in the Firebase Storage File
        
        imageRef.put(data, metadata: metaData) { (metaData, error) in
            if error == nil {
                
                let changeRequest = user.profileChangeRequest()
                //changeRequest.displayName = username
                changeRequest.photoURL = metaData!.downloadURL()
                changeRequest.commitChanges(completion: { (error) in
                    
                    if error == nil {
                        
                        //self.saveInfo(user, username: username, password: password, country: country,tool:tool)
                        self.savetool(name: name, price: price, discription: discription, photo: data, type: type, user: user)
                        
                    }else{
                        print(error!.localizedDescription)
                        
                    }
                })
                
                
            }else {
                print(error!.localizedDescription)
                
            }
        }
        
        

        
        
    }
    //Tool 3
    func savetool(name: String, price: String, discription: String, photo: Data!, type: String, user: FIRUser){
        
        let tool=["name":name,
                  "price":price,
                  "discription":discription,
                  "photo":photo,
                  "postDate":FIRServerValue.timestamp(),
                  "type":type] as [String:Any]
        
        let userRef = databaseRef.child("users").child(user.uid).child("tool").childByAutoId()

        // Save the user info in the Database
        
        userRef.setValue(tool)
    }
    
}
