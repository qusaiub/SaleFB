//
//  HomeTableViewController.swift
//  SaleFB
//
//  Created by Qusai Asaad on 17.2.2017.
//  Copyright © 2017 Qusai Asaad. All rights reserved.
//

import Firebase
import UIKit
import FirebaseAuth
import FirebaseStorage
import FirebaseDatabase

class HomeTableViewController: UITableViewController {
    
    var homeTools=[Products]()
    var ref=FIRDatabaseReference.init()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        ref = FIRDatabase.database().reference()
        loadAllTools()
        
        
    }


    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return homeTools.count
    }

    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "HomeCell", for: indexPath) as! HomeTableViewCell

        cell.setCell(item: homeTools[indexPath.row])
        
        return cell
    }
   
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        self.view.endEditing(true)
    
        let item = self.homeTools[indexPath.row]
        let blue2 = self.storyboard?.instantiateViewController(withIdentifier: "ItemViewController") as! ItemViewController
        blue2.item = item
        //blue2.playercore = playercore
        self.navigationController?.pushViewController(blue2, animated: true)
        
    }

    /*
    // Override to support conditional editing of the table view.
    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the specified item to be editable.
        return true
    }
    */

    /*
    // Override to support editing the table view.
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            // Delete the row from the data source
            tableView.deleteRows(at: [indexPath], with: .fade)
        } else if editingStyle == .insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
        }    
    }
    */

    /*
    // Override to support rearranging the table view.
    override func tableView(_ tableView: UITableView, moveRowAt fromIndexPath: IndexPath, to: IndexPath) {

    }
    */

    /*
    // Override to support conditional rearranging of the table view.
    override func tableView(_ tableView: UITableView, canMoveRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the item to be re-orderable.
        return true
    }
    */

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */
    func loadAllTools(){
     //   let user = FIRUser.self
        //databaseRef.child("users").child("\(FIRAuth.auth()!.currentUser!.uid)").child("tools").
        //databaseRef.child("FollowGroups").child(selectedFollowGroupId as String).observeSingleEvent(of: .value, with: { (snapshot) in
       // if snapshot.hasChildren(){
        self.ref.child("users").observe(.value, with: {
            (snapshot) in
            self.homeTools.removeAll()
            
            if let snapshot = snapshot.children.allObjects as? [FIRDataSnapshot] {
                for snap in snapshot {
                    
                    if  var snapT = snap.childSnapshot(forPath: "tools").children.allObjects as? [FIRDataSnapshot]{
                   
                    for s in snapT {
                        
                        if let postDict = s.value as? [String :AnyObject] {
                            self.setTools(msgId:s.key,msgData: postDict)

                    }
                    
                    }
                    }
                    
                }
                
            }
            self.tableView.reloadData()
            
            
        })
    }
    func setTools(msgId: String, msgData: [String: AnyObject]){
        
        var name:String!
        var type:String!
        var price:String!
        var ImagePath:String!
        var discription:String!
        var date:String!
        var D:String!
        var phone:String!
        
        if let name1 = msgData["name"] as? String {
            name = name1
        }
        
        
        if let type1 = msgData["type"] as? String {
            type = type1
            
        }
        else{
            type="no_date"
        }
        
        if let price1  = msgData["price"] as? String {
            price  = price1
        }
        else{
            price=" "
        }
        if let ImagePath1 = msgData["photoUrl"] as? String {
            ImagePath = ImagePath1
        }
        else{
            ImagePath = "no_image"
        }
        if let discription1 = msgData["discription"] as? String {
            discription = discription1
        }
        else{
            discription = "no_data"
        }
        if let date1 = msgData["postDate"] as? String {
            date = date1
        }
        else{
            date = "-"
        }
        if let D1 = msgData["D"] as? String {
            D = D1
        }
        else{
            date = "-"
        }
        if let phone1 = msgData["phone"] as? String {
            phone = phone1
        }
        else{
            phone = ""
        }
        
        
        
        
        self.homeTools.append(Products(toolname: name, tooltype: type, toolprice: price, toolimage: ImagePath, tooldiscription: discription, date: date,D: D,toolphone: phone))
    }
   
func dismissController(){
    self.view.endEditing(true)
}

}

