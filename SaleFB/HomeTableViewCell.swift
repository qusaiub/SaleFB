//
//  HomeTableViewCell.swift
//  SaleFB
//
//  Created by Qusai Asaad on 17.2.2017.
//  Copyright © 2017 Qusai Asaad. All rights reserved.
//

import UIKit
import Firebase
import FirebaseAuth
import FirebaseStorage

class HomeTableViewCell: UITableViewCell {
    @IBOutlet weak var img: UIImageView!

    @IBOutlet weak var date: UILabel!
    @IBOutlet weak var price: UILabel!
   
    @IBOutlet weak var name: UILabel!

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
                    self.img.image = UIImage(data: data)
                }
            }
        })
    }
}
