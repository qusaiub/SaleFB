//
//  CustomizableTextField.swift
//  ToDoList
//
//  Created by Frezy Stone Mboumba on 6/29/16.
//  Copyright © 2016 Frezy Stone Mboumba. All rights reserved.
//

import UIKit

@IBDesignable class CustomizableTextField: UITextField {

    @IBInspectable var cornerRadius: CGFloat = 0 {
        
        didSet {
            layer.cornerRadius = cornerRadius
        }
        
    }
   }
/*
 buttn2.layer.cornerRadius =  0.5 * buttn2.bounds.size.width / 2 - 38
 buttn2.layer.masksToBounds = true
 buttn2.contentMode = .scaleAspectFill
 // buttn.clipsToBounds = true
 buttn2.setTitle("Check-Block", for: .normal)
 buttn2.titleLabel?.font = UIFont.boldSystemFont(ofSize: 10)
*/
