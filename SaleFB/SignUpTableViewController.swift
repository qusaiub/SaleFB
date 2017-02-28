//
//  SignUpViewController.swift
//  ToDoList
//
//  Created by Frezy Stone Mboumba on 6/29/16.
//  Copyright © 2016 Frezy Stone Mboumba. All rights reserved.
//

import UIKit

class SignUpTableViewController: UITableViewController, UIImagePickerControllerDelegate, UINavigationControllerDelegate, UIPickerViewDelegate, UIPickerViewDataSource {

    @IBOutlet weak var countryTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
    @IBOutlet weak var emailTextField: UITextField!
    @IBOutlet weak var usernameTextField: UITextField!
    @IBOutlet weak var userImageView: UIImageView!
    var pickerView: UIPickerView!
    var countryArrays = [String]()    
    var networkingService = NetworkingService()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        
        for code in Locale.isoRegionCodes as [String]{
            let id = Locale.identifier(fromComponents: [NSLocale.Key.countryCode.rawValue: code])
            let name = (Locale(identifier: "en_EN") as NSLocale).displayName(forKey: NSLocale.Key.identifier, value: id) ?? "Country not found for code: \(code)"
            
            countryArrays.append(name)
            countryArrays.sort(by: { (name1, name2) -> Bool in
                name1 < name2
            })
        }
        
        pickerView = UIPickerView()
        pickerView.delegate = self
        pickerView.dataSource = self
        pickerView.backgroundColor = UIColor.black
        countryTextField.inputView = pickerView
        
        let tapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(SignUpTableViewController.dismissController(_:)))
        tapGestureRecognizer.numberOfTapsRequired = 1
        self.view.addGestureRecognizer(tapGestureRecognizer)
    }

    func dismissController(_ gesture: UITapGestureRecognizer){
        self.view.endEditing(true)
    }
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return countryArrays[row]
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        countryTextField.text = countryArrays[row]
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return countryArrays.count
    }

    func pickerView(_ pickerView: UIPickerView, attributedTitleForRow row: Int, forComponent component: Int) -> NSAttributedString? {
    
        let title = NSAttributedString(string: countryArrays[row], attributes: [NSForegroundColorAttributeName: UIColor.white])
        return title
    }
    
    
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    @IBAction func choosePicture(_ sender: AnyObject) {
   
        let pickerController = UIImagePickerController()
        pickerController.delegate = self
        pickerController.allowsEditing = true
        
        let alertController = UIAlertController(title: "Add a Picture", message: "Choose From", preferredStyle: .actionSheet)
        
        let cameraAction = UIAlertAction(title: "Camera", style: .default) { (action) in
            pickerController.sourceType = .camera
            self.present(pickerController, animated: true, completion: nil)

        }
        let photosLibraryAction = UIAlertAction(title: "Photos Library", style: .default) { (action) in
            pickerController.sourceType = .photoLibrary
            self.present(pickerController, animated: true, completion: nil)
            
        }
        
        let savedPhotosAction = UIAlertAction(title: "Saved Photos Album", style: .default) { (action) in
            pickerController.sourceType = .savedPhotosAlbum
            self.present(pickerController, animated: true, completion: nil)
            
        }
        
        let cancelAction = UIAlertAction(title: "Cancel", style: .destructive, handler: nil)
        
        alertController.addAction(cameraAction)
        alertController.addAction(photosLibraryAction)
        alertController.addAction(savedPhotosAction)
        alertController.addAction(cancelAction)

        
        present(alertController, animated: true, completion: nil)

    }

    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingImage image: UIImage, editingInfo: [String : AnyObject]?) {
        self.dismiss(animated: true, completion: nil)
        self.userImageView.image = image
    }
    
    @IBAction func signUpAction(_ sender: AnyObject) {
        
        let data = UIImageJPEGRepresentation(self.userImageView.image!, 0.8)
        
        networkingService.signUp(emailTextField.text!, username: usernameTextField.text!, password: passwordTextField.text!, country: countryTextField.text!, data: data!,tool:"tool")
        
    
    }
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
}
