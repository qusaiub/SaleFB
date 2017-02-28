//
//  CustomizableButton.swift
//  ToDoList
//
//  Created by Frezy Stone Mboumba on 6/29/16.
//  Copyright © 2016 Frezy Stone Mboumba. All rights reserved.
//

import UIKit

@IBDesignable class CustomizableButton: UIButton {

    @IBInspectable var cornerRadius: CGFloat = 0 {
        
        didSet {
            layer.cornerRadius = cornerRadius
        }
        
    }
  
}
