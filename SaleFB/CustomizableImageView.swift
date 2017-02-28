//
//  CustomizableImageView.swift
//  
//
//  Created by Frezy Stone Mboumba on 6/29/16.
//
//

import UIKit

@IBDesignable class CustomizableImageView: UIImageView {

    @IBInspectable var cornerRadius: CGFloat = 0 {
        
        didSet{
            
            layer.cornerRadius = cornerRadius
        }
        
    }
    
    @IBInspectable var borderWidth: CGFloat = 0 {
        
        didSet {
            
            layer.borderWidth = borderWidth
        }
        
    }
    
   }
