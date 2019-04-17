//
//  RegisterViewController.swift
//  FirebaseAuth
//
//  Created by Firzok Nadeem on 10/02/2019.
//

import UIKit
import Firebase

class RegisterUserViewController: UIViewController{
    @IBOutlet weak var usernameTextfield: UITextField!
    @IBOutlet weak var emailTextfield: UITextField!
    @IBOutlet weak var passwordTextfield: UITextField!
    @IBOutlet weak var registerButton: UIButton!
    
    override func viewDidLoad() {
        
        super.viewDidLoad()
        
        setRegisterButton(enabled: false)
        emailTextfield.addTarget(self, action: #selector(textFieldChanged), for: .editingChanged)
        passwordTextfield.addTarget(self, action: #selector(textFieldChanged), for: .editingChanged)
    }
    
    @IBAction func registerButtonTapped(_ sender: Any) {
        
        guard let username = usernameTextfield.text else { return }
        guard let email = emailTextfield.text else { return }
        guard let password = passwordTextfield.text else { return }
        guard let passwordLength = passwordTextfield.text?.count else { return }
        
        
        if !email.contains("@") {
            Toast.show(message: "Invalid Email", controller: self)
            return
        }
        if passwordLength < 6 {
            Toast.show(message: "Password must be atleast 6 characters long", controller: self)
            return
        }
        
        
        setRegisterButton(enabled: false)
        registerButton.setTitle("", for: .normal)
        
        Auth.auth().createUser(withEmail: email, password: password) { user, error in
            if error == nil && user != nil {
//                print("User created!")
                
                let changeReguest = Auth.auth().currentUser?.createProfileChangeRequest()
                changeReguest?.displayName = username
                changeReguest?.commitChanges {error in
                    if error == nil{
//                        print("User display name changed.")
                        self.performSegue(withIdentifier: "registerToAddKid", sender: self)
                        
                    }else{
                        print("Error changing display name for user: \(error!.localizedDescription)")
                    }
                }
                
            }else{
                print("Error creating user: \(error!.localizedDescription)")
            }
            
        }
        
    }
    
    @IBAction func backButton(_ sender: Any) {
        self.dismiss(animated: true, completion: nil)
    }
    
    
    func setRegisterButton(enabled:Bool) {
        if enabled {
            registerButton.alpha = 1.0
            registerButton.isEnabled = true
        } else {
            registerButton.alpha = 0.5
            registerButton.isEnabled = false
        }
    }
    
    @objc func textFieldChanged(_ target:UITextField) {
        let username = usernameTextfield.text
        let email = emailTextfield.text
        let password = passwordTextfield.text
        
        
        let formFilled = email != nil && email != "" && password != nil && password != "" && username != nil && username != ""
        setRegisterButton(enabled: formFilled)
    }
}
