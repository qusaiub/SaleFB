//
//  ResetPasswordViewController.swift
//  ToDoList
//
//  Created by Frezy Stone Mboumba on 6/29/16.
//  Copyright © 2016 Frezy Stone Mboumba. All rights reserved.
//

import UIKit

class ResetPasswordViewController: UIViewController {

    @IBOutlet weak var emailTextField: CustomizableTextField!
    
    let networkingService = NetworkingService()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        let tapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(ResetPasswordViewController.dismissController(_:)))
        tapGestureRecognizer.numberOfTapsRequired = 1
        self.view.addGestureRecognizer(tapGestureRecognizer)
    }
    
    func dismissController(_ gesture: UITapGestureRecognizer){
        self.view.endEditing(true)
    }

  
    @IBAction func resetPasswordAction(_ sender: AnyObject) {
   
    networkingService.resetPassword(emailTextField.text!)
    }
    
    

}
