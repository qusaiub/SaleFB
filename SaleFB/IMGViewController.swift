//
//  IMGViewController.swift
//  SaleFB
//
//  Created by Qusai Asaad on 18.2.2017.
//  Copyright © 2017 Qusai Asaad. All rights reserved.
//

import UIKit
import Firebase
import FirebaseStorage
import FirebaseAuth
class IMGViewController: UIViewController {

    var storageRef: FIRStorage! {
        return FIRStorage.storage()
    }
    @IBOutlet weak var img: CustomizableImageView!
    
    var item:Products!

    override func viewDidLoad() {
        super.viewDidLoad()

        let imageUrl = item.toolimage
        
        self.storageRef.reference(forURL: imageUrl!).data(withMaxSize: 1 * 1024 * 1024, completion: { (data, error) in
            
            
            if let error = error {
                print(error.localizedDescription)
            }else {
                if let data = data {
                    self.img.image = UIImage(data: data)
                }
            }
        })
        let tapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(IMGViewController.dismissController(_:)))
        tapGestureRecognizer.numberOfTapsRequired = 1
        self.view.addGestureRecognizer(tapGestureRecognizer)
    }
    
    func dismissController(_ gesture: UITapGestureRecognizer){
        self.view.endEditing(true)
    }

    
}
