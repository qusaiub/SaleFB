//
//  Products.swift
//  SaleFB
//
//  Created by Qusai Asaad on 17.2.2017.
//  Copyright © 2017 Qusai Asaad. All rights reserved.
//

import Foundation

class Products {
    var toolname:String!
    var tooltype:String!
    var toolprice:String!
    var toolimage:String!
    var tooldiscription:String!
    var date:String!
    var D:String!
    var toolphone:String!

    
    init(toolname:String,tooltype:String,toolprice:String,toolimage:String,tooldiscription:String,date:String,D:String,toolphone:String){
        
        self.toolname = toolname
        self.tooltype = tooltype
        self.toolprice = toolprice
        self.toolimage = toolimage
        self.tooldiscription = tooldiscription
        self.date = date 
        self.D = D
        self.toolphone = toolphone
    }
}
