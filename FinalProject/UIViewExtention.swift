//
//  UIViewExtention.swift
//  FinalProject
//
//  Created by Mac17 on 25/06/21.
//

import UIKit

extension UIView {
    @IBInspectable var cornerRadius: CGFloat{
        get { return cornerRadius }
        set {
            self.layer.cornerRadius = newValue
        }
    }
}
