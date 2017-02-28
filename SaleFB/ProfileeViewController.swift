//
//  ProfileeViewController.swift
//  SaleFB
//
//  Created by Qusai Asaad on 18.2.2017.
//  Copyright © 2017 Qusai Asaad. All rights reserved.
//

import UIKit
import FirebaseStorage
import Firebase
import FirebaseAuth

class ProfileeViewController: UIViewController {
    @IBOutlet weak var btnEdit: UIBarButtonItem!
    
    @IBOutlet weak var country: UITextField!
    @IBOutlet weak var username: UITextField!
    @IBOutlet weak var email: UITextField!
    @IBOutlet weak var profileImage: CustomizableImageView!
    
    var urlImage : String!
    var databaseRef: FIRDatabaseReference! {
        return FIRDatabase.database().reference()
    }
    
    var storageRef: FIRStorage! {
        return FIRStorage.storage()
    }

   
    
    
        override func viewDidLoad() {
        super.viewDidLoad()

            // Do any additional setup after loading the view.
            if FIRAuth.auth()?.currentUser == nil {
                
                let vc = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "Login")
                present(vc, animated: true, completion: nil)
            }
            else {
               // databaseRef.child("users/\(FIRAuth.auth()!.currentUser!.uid)").observe(.value, with: {
                    databaseRef.child("users").child("\(FIRAuth.auth()!.currentUser!.uid)").observe(.value, with: {
                    (snapshot) in
                    DispatchQueue.main.async(execute: {
                        
                        let user = User(snapshot: snapshot)
                        self.username.text = user.username
                        self.country.text = user.country
                        self.email.text = FIRAuth.auth()?.currentUser?.email
                        
                        let imageUrl = String(user.photoUrl)
                        
                        self.storageRef.reference(forURL: imageUrl!).data(withMaxSize: 1 * 1024 * 1024, completion: { (data, error) in
                            
                            if let error = error {
                                print(error.localizedDescription)
                            }else {
                                if let data = data {
                                    self.profileImage.image = UIImage(data: data)
                                }
                            }
                        })
                        
                        
                        
                        
                        
                    })
                    
                    
                }) { (error) in
                    print(error.localizedDescription)
                }
            }

            let tapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(ProfileeViewController.dismissController(_:)))
            tapGestureRecognizer.numberOfTapsRequired = 1
            self.view.addGestureRecognizer(tapGestureRecognizer)
    }
    
    func dismissController(_ gesture: UITapGestureRecognizer){
        self.view.endEditing(true)
    }
    @IBAction func Logout(_ sender: Any) {
        if FIRAuth.auth()?.currentUser != nil {
            
            do {
                
                try  FIRAuth.auth()?.signOut()
                let vc = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "Login")
                present(vc, animated: true, completion: nil)
                
            } catch let error as NSError {
                print(error.localizedDescription)
            }
    }
}
    @IBAction func btnEdit(_ sender: Any)
    {
        if let user = FIRAuth.auth()?.currentUser {
        let userRef = databaseRef.child("users").child(user.uid)
            
            let editUser = ["username": username, "country": country, "photoUrl": String(describing: user.photoURL!),"postDate":FIRServerValue.timestamp()] as [String : Any]
        
        userRef.setValue(editUser)
        }else {
            print("error")
        }
    }
}
