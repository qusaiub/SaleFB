//
//  ViewController.swift
//  SaleFB
//
//  Created by Qusai Asaad on 16.2.2017.
//  Copyright © 2017 Qusai Asaad. All rights reserved.
//

import UIKit
import Firebase

class ViewController: UIViewController {
    
    var ref=FIRDatabaseReference.init()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.ref=FIRDatabase.database().reference()
        userLogin()
    }

    

    func userLogin(){
        
        FIRAuth.auth()?.signInAnonymously(){ (user,error) in
            let isAnonymous=user!.isAnonymous
            if isAnonymous == true{
                let uid=user!.uid
                print("uid:\(uid)")
            }
        }
       
    }
    
    func send(){
        let msg=["username":"qusai",
                 "date":FIRServerValue.timestamp(),
        "text":"hellow its me"] as [String:Any]
        
        let firebasemessege = self.ref.child("message").childByAutoId() // add more child
        firebasemessege.setValue(msg)
    }
}

