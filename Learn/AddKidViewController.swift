//
//  AddKidViewController.swift
//  Learn
//
//  Created by Firzok Nadeem on 26/02/2019.
//  Copyright © 2019 Mani. All rights reserved.
//

import Foundation


import UIKit
import Firebase
import FirebaseDatabase

class AddKidViewController: UIViewController, UITextFieldDelegate {
    
    
    var ref: DatabaseReference?
    
    @IBOutlet weak var nameTextfield: UITextField!
    @IBOutlet weak var ageTextfield: UITextField!
    @IBOutlet weak var addButton: UIButton!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.ageTextfield.delegate = self
        
        setAddButton(enabled: false)
        
        nameTextfield.addTarget(self, action: #selector(textFieldChanged), for: .editingChanged)
        ageTextfield.addTarget(self, action: #selector(textFieldChanged), for: .editingChanged)
    }
    
    
    @IBAction func addKidButtonTapped(_ sender: UIButton) {
        
        guard let name = nameTextfield.text else {return}
        guard let age = ageTextfield.text else {return}
        guard Int(ageTextfield.text!) != nil else {return}
        
        setAddButton(enabled: false)
        
        ref = Database.database().reference()
        let userID = Auth.auth().currentUser?.uid
        
        self.ref!.child("children").child(userID!).childByAutoId().setValue(["displayName": name, "age":age])
        
        nameTextfield.text = ""
        ageTextfield.text = ""
        
        let alertController = UIAlertController(title: "Kid Added", message:
            "Name: \(name)\nAge: \(age)", preferredStyle: .alert)
        
        alertController.addAction(UIAlertAction(title: "Add More", style: .default))
        
        alertController.addAction(UIAlertAction(title: "Dismiss", style: .default){UIAlertAction in
            self.dismiss(animated: true, completion: nil)
        })
        
        self.present(alertController, animated: true, completion: nil)
        
        
    }
    
    
    
    func setAddButton(enabled:Bool) {
        if enabled {
            addButton.alpha = 1.0
            addButton.isEnabled = true
        } else {
            addButton.alpha = 0.5
            addButton.isEnabled = false
        }
    }
    
    @objc func textFieldChanged(_ target:UITextField) {
        let name = nameTextfield.text
        let age = ageTextfield.text
        let formFilled = (age != nil && age != "" && name != nil && name != "")
        setAddButton(enabled: formFilled)
    }
    
    
    @IBAction func logoutButtonTapped(_ sender: Any) {
        try! Auth.auth().signOut()
        self.dismiss(animated: true, completion: nil)
        
    }
    
    
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        let invalidCharacters = CharacterSet(charactersIn: "0123456789").inverted
        return string.rangeOfCharacter(from: invalidCharacters) == nil
    }
    
}

