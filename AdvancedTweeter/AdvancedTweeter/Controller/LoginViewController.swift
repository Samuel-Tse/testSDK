//
//  LoginViewController.swift
//  AdvancedTweeter
//
//  Created by Samuel Tse on 16/4/19.
//  Copyright © 2019 Samuel Tse. All rights reserved.
//

import UIKit

class LoginViewController: UIViewController {

    @IBOutlet weak var imageTopConstraint: NSLayoutConstraint!//50
    @IBOutlet weak var stackTopConstraint: NSLayoutConstraint!//50
    
    @IBOutlet weak var TextField_UserName: CustomTextField!
    @IBOutlet weak var TextField_Password: CustomTextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        setBackgroundColor()
        hideKeyboardWhenTappedAround()
    }
    
    @IBAction func loginAction(_ sender: UIButton) {
        loginValidation()
    }
    
    
    func loginValidation() {
        
        guard !(TextField_UserName.text == "") || !TextField_UserName.text!.isEmpty else { return }
        let storyBoard: UIStoryboard = UIStoryboard(name: "Main", bundle: nil)
        let vc = storyBoard.instantiateViewController(withIdentifier: "MainScreenViewControllerID") as! MainScreenViewController
        vc.modalPresentationStyle = .fullScreen
        vc.userName = TextField_UserName.text!
        self.present(vc, animated: true, completion: nil)
    }
    
    enum moveDirection {
        case up
        case down
    }
    
    func animationMove(direction: moveDirection) {
        UIView.animate(withDuration: 0.8, animations: {
            [unowned self] in
            self.imageTopConstraint.constant = direction == .up ? 35 : 50
            self.stackTopConstraint.constant = direction == .up ? 35 : 50
            self.view.layoutIfNeeded()
        })
    }
}
// MARK: -UITextFieldDelegate
extension LoginViewController: UITextFieldDelegate {
    
    func textFieldDidBeginEditing(_ textField: UITextField) {
        animationMove(direction: .up)
    }
    
    func textFieldDidEndEditing(_ textField: UITextField) {
        animationMove(direction: .down)
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        
        if (textField == self.TextField_UserName) {
            self.TextField_Password.becomeFirstResponder()
        }else {
            loginValidation()
        }
        return false
    }
}
