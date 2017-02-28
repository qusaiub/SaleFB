//
//  LogInViewController.swift
//  ToDoList
//
//  Created by Frezy Stone Mboumba on 6/29/16.
//  Copyright © 2016 Frezy Stone Mboumba. All rights reserved.
//

import UIKit

class LogInViewController: UIViewController {

    @IBOutlet weak var passwordTextField: CustomizableTextField!
    @IBOutlet weak var emailTextField: CustomizableTextField!
    let networkingService = NetworkingService()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        let tapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(LogInViewController.dismissController(_:)))
        tapGestureRecognizer.numberOfTapsRequired = 1
        self.view.addGestureRecognizer(tapGestureRecognizer)
    }
    
    func dismissController(_ gesture: UITapGestureRecognizer){
        self.view.endEditing(true)
    }

   
    @IBAction func unwindToLogIn(_ storyboard:UIStoryboardSegue){
    }
    
    
    
    @IBAction func logInAction(_ sender: AnyObject) {
        networkingService.signIn(emailTextField.text!, password: passwordTextField.text!)
        
    }
    
   
}
