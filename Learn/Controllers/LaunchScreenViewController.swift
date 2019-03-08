//
//  LaunchScreenViewController.swift
//  Learn
//
//  Created by Shiza Siddique on 3/7/19.
//  Copyright © 2019 Mani. All rights reserved.
//

import UIKit
import Firebase
import FirebaseDatabase

class LaunchScreenViewController: UIViewController {

    var ref: DatabaseReference?
    
    @IBOutlet weak var continueButton: UIButton!
    var continueSegueID = "toLoginRegisterScreen"
    
    
    @IBOutlet weak var launchGif: UIImageView!
    override func viewDidLoad() {
        launchGif.loadGif(name: "launchScreen")
        
        self.ref = Database.database().reference()
        if let user = Auth.auth().currentUser{
            
            if user.isAnonymous{
                self.continueSegueID = "toLoginRegisterScreen"
                print("TO LOGIN")
            } else{
                let userID = user.uid
                self.ref!.child("children").child(userID).observeSingleEvent(of: .value, with: { (snapshot) in
                    
                    if snapshot.childrenCount == 0 {
                        self.continueSegueID = "toAddKidScreen"
                        print("DONE")
                    }else{
                        self.continueSegueID = "toSelectKidScreen"
                        print("DONE")
                    }
                    
                }) { (error) in
                    print(error.localizedDescription)
                }
            }
            
        } else {
            self.continueSegueID = "toLoginRegisterScreen"
            print("TO LOGIN")
        }
        
            
        
        super.viewDidLoad()

    }
    
    override func viewDidAppear(_ animated: Bool) {
        self.ref = Database.database().reference()
        if let user = Auth.auth().currentUser{
            
            if user.isAnonymous{
                self.continueSegueID = "toLoginRegisterScreen"
                print("TO LOGIN")
            } else{
                let userID = user.uid
                self.ref!.child("children").child(userID).observeSingleEvent(of: .value, with: { (snapshot) in
                    
                    if snapshot.childrenCount == 0 {
                        self.continueSegueID = "toAddKidScreen"
                        print("DONE")
                    }else{
                        self.continueSegueID = "toSelectKidScreen"
                        print("DONE")
                    }
                    
                }) { (error) in
                    print(error.localizedDescription)
                }
            }
            
        } else {
            self.continueSegueID = "toLoginRegisterScreen"
            print("TO LOGIN")
        }
    }

    @IBAction func continueButtonTapped(_ sender: Any) {
        
        performSegue(withIdentifier: continueSegueID, sender: nil)
        
    }
}
