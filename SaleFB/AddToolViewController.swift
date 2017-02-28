//
//  AddToolViewController.swift
//  SaleFB
//
//  Created by Qusai Asaad on 17.2.2017.
//  Copyright © 2017 Qusai Asaad. All rights reserved.
//

import UIKit
import Firebase
import FirebaseAuth
import FirebaseStorage
import FirebaseDatabase


class AddToolViewController: UIViewController ,UIImagePickerControllerDelegate,UINavigationControllerDelegate,UIPickerViewDelegate,UIPickerViewDataSource{
    
    @IBOutlet weak var btnsave: CustomizableButton!

   var netwarokingService = NetworkingService()
      @IBOutlet weak var Toolimage: UIImageView!
        @IBOutlet weak var txtToolType: UITextField!
        @IBOutlet weak var txtToolPrice: UITextField!
    var types:[String] = ["cars","Animals","Apartments","Professionals","Vehicle Price List","Others"]
    @IBOutlet weak var txtToolDisc: UITextField!
    @IBOutlet weak var txtToolName: UITextField!
    var imagePicker:UIImagePickerController!
    var pickerView: UIPickerView!
@IBOutlet weak var txtToolPhone: UITextField!

    let user = FIRAuth.auth()?.currentUser
    
    var databaseRef: FIRDatabaseReference! {
        return FIRDatabase.database().reference()
    }
    
    var storageRef: FIRStorageReference {
        return FIRStorage.storage().reference()
    }

    
    override func viewDidLoad() {
              
        super.viewDidLoad()
        
        pickerView = UIPickerView()
        pickerView.delegate = self
        pickerView.dataSource = self
        pickerView.backgroundColor = UIColor.black
        txtToolType.inputView = pickerView
        
               // The user's ID, unique to the Firebase project.
        // Do NOT use this value to authenticate with your backend server,
        // if you have one. Use getTokenWithCompletion:completion: instead.
        let email = user?.email
        let uid = user?.uid
        let photoURL = user?.photoURL
        
        let tapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(AddToolViewController.dismissController(_:)))
        tapGestureRecognizer.numberOfTapsRequired = 1
        self.view.addGestureRecognizer(tapGestureRecognizer)
        
    
   
    }
    func dismissController(_ gesture: UITapGestureRecognizer){
        self.view.endEditing(true)
    }
    @IBAction func btnChoosePic(_ sender: Any) {
        print("sasd")
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
        self.Toolimage.image = image
    }
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return types[row]
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        txtToolType.text = types[row]
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return types.count
    }
    
    func pickerView(_ pickerView: UIPickerView, attributedTitleForRow row: Int, forComponent component: Int) -> NSAttributedString? {
        
        let title = NSAttributedString(string: types[row], attributes: [NSForegroundColorAttributeName: UIColor.white])
        return title
    }
    
    
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }

        
    @IBAction func btnSave(_ sender: Any) {
        print("qqqqqq")
        let user = FIRAuth.auth()!.currentUser!
        let data = UIImageJPEGRepresentation(self.Toolimage.image!, 0.8)
        
        let name = txtToolName.text!
        let type = txtToolType.text!
        let price = txtToolPrice.text!
        let discription = txtToolDisc.text!
        let phone = txtToolPhone.text!
        
        ss(name: name, type: type, price: price, disc: discription, data: data!, user: user,phone: phone)
        //self.addTool(name: name, price: price, discription: discription, photo: data, type: type, user: user)
    }
    func ss(name:String,type:String,price:String,disc:String,data:Data,user:FIRUser,phone:String){
      
        setToolInfo(name: name, price: price, discription: disc, data: data, type: type, user: user,phone:phone)
    }

    func  addTool(name:String,price:String,discription:String,photo:Data!,type:String,user:FIRUser!,phone:String){
        
        
        setToolInfo(name: name, price: price, discription: discription, data: photo, type: type, user: user,phone:phone)
        
        
    }
    // Tool 2
    fileprivate func setToolInfo(name:String,price:String,discription:String,data:Data!,type:String,user:FIRUser!,phone:String){
        
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
                        self.savetool(name: name, price: price, discription: discription, photo: data, type: type, user: user,phone:phone)
                        
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
    func savetool(name: String, price: String, discription: String, photo: Data!, type: String, user: FIRUser!,phone:String){
        
        self.btnsave.isEnabled = false
        
        var date = Date()
        var calendar = Calendar.current
        var day = calendar.component(.day, from: date)
        var month = calendar.component(.month, from: date)
        var year = calendar.component(.year, from: date)
        var start = "\(year):\(month):\(day)"
        let tool=["name":name,
                  "price":price,
                  "discription":discription,
                  
                  "postDate":FIRServerValue.timestamp(),
                  "type":type,
                  "photoUrl": String(describing: user.photoURL!),
                  "D":start,
            "phone":phone] as [String:Any]
        
        let userRef = databaseRef.child("users").child(user.uid).child("tools").childByAutoId()
        
        // Save the user info in the Database
        userRef.setValue(tool)
        
        gotomytool()
            }
    func gotomytool(){
        
        DispatchQueue.main.async { 
            self.btnsave.isEnabled = true
        }
        navigationController?.popViewController(animated: true)

       }
   

}
