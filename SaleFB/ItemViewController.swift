//
//  ItemViewController.swift
//  SaleFB
//
//  Created by Qusai Asaad on 18.2.2017.
//  Copyright © 2017 Qusai Asaad. All rights reserved.
//

import UIKit
import Firebase
import FirebaseStorage
import FirebaseAuth
class ItemViewController: UIViewController {
    @IBOutlet weak var img: UIImageView!

    
    //var item:Products!
    @IBOutlet weak var phone: UILabel!
    
    @IBOutlet weak var email: UILabel!
    var item:Products!
    
    @IBOutlet weak var price: UILabel!
    @IBOutlet weak var disc: UILabel!
    @IBOutlet weak var date: UILabel!
    @IBOutlet weak var name: UILabel!
    @IBOutlet weak var type: UILabel!
    
    var storageRef: FIRStorage! {
        return FIRStorage.storage()
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        
       // print("\(item.date)")

        var dates = Date()
        print(dates)
        self.price.text = "\(item.toolprice!)$"
        self.date.text = item.D!
        self.disc.text = item.tooldiscription!
        self.name.text = item.toolname!
        self.type.text = item.tooltype!
        self.phone.text = item.toolphone!
        if FIRAuth.auth()!.currentUser!.email != nil {
            
            var E = FIRAuth.auth()!.currentUser!.email
            
            self.email.text = E
            
        }
        
        
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

        

        
        let tapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(ItemViewController.dismissController(_:)))
        tapGestureRecognizer.numberOfTapsRequired = 1
        self.view.addGestureRecognizer(tapGestureRecognizer)
    }
    
    func dismissController(_ gesture: UITapGestureRecognizer){
        self.view.endEditing(true)
    }
    
    func setview(item:Products){
        
        
    }
    @IBAction func btnimgView(_ sender: Any) {
        
        let blue2 = self.storyboard?.instantiateViewController(withIdentifier: "IMGViewController") as! IMGViewController
        blue2.item = self.item
        //blue2.playercore = playercore
        self.navigationController?.pushViewController(blue2, animated: true)
    }
    
}
