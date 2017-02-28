//
//  myToolsTableViewController.swift
//  SaleFB
//
//  Created by Qusai Asaad on 18.2.2017.
//  Copyright © 2017 Qusai Asaad. All rights reserved.
//

import UIKit
import Firebase
import FirebaseStorage
import FirebaseStorage

class myToolsTableViewController: UITableViewController {

    var myTools = [Products]()
    
    var urlImage : String!
    var databaseRef: FIRDatabaseReference! {
        return FIRDatabase.database().reference()
    }
    
    var storageRef: FIRStorage! {
        return FIRStorage.storage()
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        
        databaseRef.child("users").child("\(FIRAuth.auth()!.currentUser!.uid)").child("tools").queryOrdered(byChild: "postDate").observe(.value, with: { (snapshot) in
            if let snapshot = snapshot.children.allObjects as? [FIRDataSnapshot] {
                self.myTools.removeAll()
                for snap in snapshot {
                   
                    if let postDict = snap.value as? [String: AnyObject] {
                        //  let msgData = postDict as?  [String: AnyObject]
                        
                        self.setTool(msgId: snap.key, msgData: postDict)
                        
                    }
                }
            }
            self.tableView.reloadData()
            
        }) { (error) in
            print(error.localizedDescription)
        }
    }
  
    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return self.myTools.count
    }

    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "MyToolCell", for: indexPath) as!
        MyToolTableViewCell
        
        cell.setCell(item: self.myTools[indexPath.row])
        

        return cell
    }
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let item = self.myTools[indexPath.row]
        let blue2 = self.storyboard?.instantiateViewController(withIdentifier: "ItemViewController") as! ItemViewController
        blue2.item = item
        //blue2.playercore = playercore
        self.navigationController?.pushViewController(blue2, animated: true)
                
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier=="ItemViewController" {
            if let destination=segue.destination as? ItemViewController {
                if let item=sender as?Products {
                   // Detailsview.EditOrDeleteItem=item
                      destination.setview(item: item)
                }
            }/// Add
        }
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
    func setTool(msgId: String, msgData: [String: AnyObject]){
        
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
            D = "-"
        }
        if let phone1 = msgData["phone"] as? String {
            phone = phone1
        }
        else{
            phone = "-"
        }


        
        
        self.myTools.append(Products(toolname: name, tooltype: type, toolprice: price, toolimage: ImagePath, tooldiscription: discription, date: date,D: D, toolphone: phone))
    }
    func deleteTool(indexPath:Int,tool:String){
        
        
    }
    }

