//
//  ExtensionUIViewController.swift
//  AdvancedTweeter
//
//  Created by Samuel Tse on 16/4/19.
//  Copyright © 2019 Samuel Tse. All rights reserved.
//

import UIKit

extension UIViewController {
    
    func hideKeyboardWhenTappedAround() {
        let tap: UITapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(UIViewController.dismissKeyboard))
        tap.cancelsTouchesInView = false
        view?.addGestureRecognizer(tap)
    }
    
    @objc func dismissKeyboard() {
        view?.endEditing(true)
    }
    
    func setBackgroundColor() {
        let topColor = UIColor(rgb: 0x67B1BD)
        let bottomColor = UIColor(rgb: 0x1A1F27)
        self.view.applyGradient(colours:  [topColor, bottomColor])
    }
    
    func getCurrentDateTime() -> String {
        let date = Date()
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "HH:mm MMM dd,yyyy"
        let dateString = dateFormatter.string(from: date)
        return dateString
    }
}
