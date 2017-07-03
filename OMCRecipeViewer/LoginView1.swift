//
//  LoginView.swift
//  RecipeViewer
//
//  Created by Yves Yang on 09/06/2017.
//  Copyright © 2017 Alexis YANG. All rights reserved.
//

import Foundation
import UIKit

class LoginView1: UIView, NibLoadableView {
    
    @IBOutlet weak var RecipeViewer: UILabel!
    @IBOutlet weak var OneMillionCooking: UILabel!
    @IBOutlet weak var loginTextField: UITextField?
    @IBOutlet weak var passwordTextField: UITextField?
    @IBOutlet weak var loginButton: UIButton?
    @IBOutlet weak var signUpButton: UIButton!
    
    weak var delegate: LoginViewControllerDelegate?
    
    @IBAction func didPushLoginButton(_ sender: UIButton) {
        
        guard let login = loginTextField?.text else {
            return
        }
        guard let password = passwordTextField?.text else {
            return
        }
        let request = LoginRequest(login: login, password: password)
        request.perform {
            result in
            UserSession.sharedInstance.userSession = result
            self.delegate?.goToViewController(user: result)
        }
    }
    
    @IBAction func didPushSignUpButton(_ sender: UIButton) {
        self.delegate?.goToSignUp()
    }
    
    static func instantiate() -> LoginView1 {
        let nib = UINib(nibName: self.NibName, bundle: nil)
        return nib.instantiate(withOwner: self, options: nil).first as! LoginView1
    }
}
