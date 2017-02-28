//
//  MyToolTableViewCell.swift
//  SaleFB
//
//  Created by Qusai Asaad on 18.2.2017.
//  Copyright © 2017 Qusai Asaad. All rights reserved.
//

import UIKit
import Firebase
import FirebaseAuth
import FirebaseStorage

class MyToolTableViewCell: UITableViewCell {
    @IBOutlet weak var imgT: UIImageView!
    

    @IBOutlet weak var name: UILabel!
    
    @IBOutlet weak var price: UILabel!
    @IBOutlet weak var date: UILabel!
    
    var storageRef: FIRStorage! {
        return FIRStorage.storage()
    }
   
    
    func setCell(item:Products){
        
        name.text = item.toolname
        price.text = "\(item.toolprice!)$"
        date.text = item.D
        
        let imageUrl = item.toolimage
        
        self.storageRef.reference(forURL: imageUrl!).data(withMaxSize: 1 * 1024 * 1024, completion: { (data, error) in
            
            
            if let error = error {
                print(error.localizedDescription)
            }else {
                if let data = data {
                    self.imgT.image = UIImage(data: data)
                }
            }
        })
    }
  }
