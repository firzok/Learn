//
//  LoginViewController.swift
//  Learn
//
//  Created by Firzok Nadeem on 10/02/2019.
//  Copyright © 2019 Mani. All rights reserved.
//

import Foundation

import Firebase

class LoginViewController: UIViewController{
    
    @IBOutlet weak var emailTextfield: UITextField!
    
    @IBOutlet weak var passwordTextfield: UITextField!
    
    @IBOutlet weak var loginButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setLoginButton(enabled: false)
        emailTextfield.addTarget(self, action: #selector(textFieldChanged), for: .editingChanged)
        passwordTextfield.addTarget(self, action: #selector(textFieldChanged), for: .editingChanged)
    }
    
    
    @IBAction func backButtonTapped(_ sender: Any) {
        self.dismiss(animated: true, completion: nil)
    }
    
    
    @IBAction func loginButtontapped(_ sender: Any) {
        
        guard let email = emailTextfield.text else { return }
        guard let password = passwordTextfield.text else { return }
        
        setLoginButton(enabled: false)
        
        Auth.auth().signIn(withEmail: email, password: password){user, error in
            if error == nil && user != nil{
                self.dismiss(animated: true, completion: nil)
            }else{
                print("Error logging in \(error!.localizedDescription)")
            }
        }
    }
    func setLoginButton(enabled:Bool) {
        if enabled {
            loginButton.alpha = 1.0
            loginButton.isEnabled = true
        } else {
            loginButton.alpha = 0.5
            loginButton.isEnabled = false
        }
    }
    
    @objc func textFieldChanged(_ target:UITextField) {
        let email = emailTextfield.text
        let password = passwordTextfield.text
        let formFilled = email != nil && email != "" && password != nil && password != ""
        setLoginButton(enabled: formFilled)
    }
}
