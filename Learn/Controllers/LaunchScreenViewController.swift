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
        self.continueButton.isEnabled = false
        launchGif.loadGif(name: "launchScreen")
        super.viewDidLoad()

    }
    
    override func viewDidAppear(_ animated: Bool) {
        self.ref = Database.database().reference()
        if let user = Auth.auth().currentUser{
            
            if user.isAnonymous{
                self.continueSegueID = "toLoginRegisterScreen"
                self.continueButton.isEnabled = true
                self.continueButton.isUserInteractionEnabled = true

                print("TO LOGIN")
            } else{
                let userID = user.uid
                self.ref!.child("children").child(userID).observeSingleEvent(of: .value, with: { (snapshot) in
                    
                    if snapshot.childrenCount == 0 {
                        self.continueSegueID = "toAddKidScreen"
                        self.continueButton.isEnabled = true
                        self.continueButton.isUserInteractionEnabled = true

                    }else{
                        self.continueSegueID = "toSelectKidScreen"
                        self.continueButton.isEnabled = true
                        self.continueButton.isUserInteractionEnabled = true

                    }
                    print("DONE")

                    
                    
                }) { (error) in
                    print(error.localizedDescription)
                }
            }
            self.continueButton.isEnabled = true
            self.continueButton.isUserInteractionEnabled = true
            
        } else {
            self.continueSegueID = "toLoginRegisterScreen"
            self.continueButton.isEnabled = true
            self.continueButton.isUserInteractionEnabled = true
            print("TO LOGIN")
        }
    }

    @IBAction func continueButtonTapped(_ sender: Any) {
        
        performSegue(withIdentifier: continueSegueID, sender: nil)
        
    }
}
