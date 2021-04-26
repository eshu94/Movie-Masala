//
//  UIViewExtensions.swift
//  Itnerary App
//
//  Created by ESHITA on 08/03/20.
//  Copyright © 2020 ESHITA. All rights reserved.
//

import UIKit

extension UIView {
    
    func addShadowAndRoundedCorner(){
        layer.shadowOpacity = 1
        layer.shadowOffset = CGSize.zero
        layer.shadowColor = UIColor.black.cgColor
        layer.cornerRadius = 12
    }
    
    func addShadowAndRoundedCornerForInnerCells(){
        layer.shadowOpacity = 5
        layer.shadowOffset = CGSize.zero
        layer.shadowColor = UIColor.black.cgColor
        layer.cornerRadius = 20
    }
    
}
