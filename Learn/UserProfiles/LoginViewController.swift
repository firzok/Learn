//
//  LoginViewController.swift
//  Learn
//
//  Created by Firzok Nadeem on 10/02/2019.
//  Copyright © 2019 Mani. All rights reserved.
//

import Foundation

import Firebase
import FirebaseDatabase

class LoginViewController: UIViewController{
    
    @IBOutlet weak var emailTextfield: UITextField!
    
    @IBOutlet weak var passwordTextfield: UITextField!
    
    @IBOutlet weak var loginButton: UIButton!
    
    var ref: DatabaseReference?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.ref = Database.database().reference()
        
        setLoginButton(enabled: false)
        emailTextfield.addTarget(self, action: #selector(textFieldChanged), for: .editingChanged)
        passwordTextfield.addTarget(self, action: #selector(textFieldChanged), for: .editingChanged)
    }
    
    
    @IBAction func backButtonTapped(_ sender: Any) {
        self.dismiss(animated: true, completion: nil)
    }
    
    func handleSuccesfullLogin(){
        
        
        if let user = Auth.auth().currentUser{
            
            let userID = user.uid
            self.ref!.child("children").child(userID).observeSingleEvent(of: .value, with: { (snapshot) in
                
                if snapshot.childrenCount == 0 {
                    self.performSegue(withIdentifier: "toAddKidScreen", sender: self)
                    
                }else{
                    self.performSegue(withIdentifier: "toSelectKidScreen", sender: self)
                }
                
            }) { (error) in
                print(error.localizedDescription)
            }
        }
        
        
    }
    
    
    @IBAction func loginButtontapped(_ sender: Any) {
        
        guard let email = emailTextfield.text else { return }
        guard let password = passwordTextfield.text else { return }
        
        setLoginButton(enabled: false)
        
        Auth.auth().signIn(withEmail: email, password: password){user, error in
            if error == nil && user != nil{
                self.handleSuccesfullLogin()
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
