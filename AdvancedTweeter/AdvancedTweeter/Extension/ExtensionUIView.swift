//
//  ExtensionUIView.swift
//  AdvancedTweeter
//
//  Created by Samuel Tse on 15/4/19.
//  Copyright © 2019 Samuel Tse. All rights reserved.
//

import UIKit

extension UIView {
    
    func applyGradient(colours: [UIColor]) -> Void {
        let gradient: CAGradientLayer = CAGradientLayer()
        gradient.frame = self.bounds
        gradient.colors = colours.map { $0.cgColor }
        gradient.startPoint = CGPoint(x : 0.5, y : 0.0)
        gradient.endPoint = CGPoint(x : 0.5, y: 1.0)
        self.layer.insertSublayer(gradient, at: 0)
    }
}
