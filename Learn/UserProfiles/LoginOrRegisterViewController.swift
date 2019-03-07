//
//  MainViewController.swift
//  Learn
//
//  Created by Firzok Nadeem on 10/02/2019.
//  Copyright © 2019 Mani. All rights reserved.
//

import Foundation
import UIKit
import Firebase

class LoginOrRegisterViewController: UIViewController{
    
    var ref: DatabaseReference?
    
    @IBAction func unwindToLoginOrRegister(segue:UIStoryboardSegue) { }
    
//    override func viewDidLoad() {
//        self.ref = Database.database().reference()
//        if let user = Auth.auth().currentUser{
//
//            let userID = user.uid
//            self.ref!.child("children").child(userID).observeSingleEvent(of: .value, with: { (snapshot) in
//
//                if snapshot.childrenCount == 0 {
//                    self.performSegue(withIdentifier: "toAddKidScreen", sender: self)
//                }else{
//                    self.performSegue(withIdentifier: "toSelectKidScreen", sender: self)
//                }
//
//            }) { (error) in
//                print(error.localizedDescription)
//            }
//        }
//        super.viewDidLoad()
//
//    }
//
//    override func viewDidAppear(_ animated: Bool) {
//        self.ref = Database.database().reference()
//        if let user = Auth.auth().currentUser{
//
//            let userID = user.uid
//            self.ref!.child("children").child(userID).observeSingleEvent(of: .value, with: { (snapshot) in
//
//                if snapshot.childrenCount == 0 {
//                    self.performSegue(withIdentifier: "toAddKidScreen", sender: self)
//                }else{
//                    self.performSegue(withIdentifier: "toSelectKidScreen", sender: self)
//                }
//
//            }) { (error) in
//                print(error.localizedDescription)
//            }
//        }
//        super.viewDidAppear(animated)
//    }
//
//    override func viewWillAppear(_ animated: Bool) {
//        self.ref = Database.database().reference()
//        if let user = Auth.auth().currentUser{
//
//            let userID = user.uid
//            self.ref!.child("children").child(userID).observeSingleEvent(of: .value, with: { (snapshot) in
//
//                if snapshot.childrenCount == 0 {
//                    self.performSegue(withIdentifier: "toAddKidScreen", sender: self)
//                }else{
//                    self.performSegue(withIdentifier: "toSelectKidScreen", sender: self)
//                }
//
//            }) { (error) in
//                print(error.localizedDescription)
//            }
//        }
//        super.viewWillAppear(animated)
//    }
    
    
    
    
}
