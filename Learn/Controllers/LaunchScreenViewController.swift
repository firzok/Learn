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
    
    var continueSegueID = "toLoginRegisterScreen"
    
    
    @IBOutlet weak var launchGif: UIImageView!
    override func viewDidLoad() {
        launchGif.loadGif(name: "launchScreen")
        
        self.ref = Database.database().reference()
        if let user = Auth.auth().currentUser{
            
            let userID = user.uid
            self.ref!.child("children").child(userID).observeSingleEvent(of: .value, with: { (snapshot) in
                
                if snapshot.childrenCount == 0 {
                    self.continueSegueID = "toAddKidScreen"
                }else{
                    self.continueSegueID = "toSelectKidScreen"
                }
                
            }) { (error) in
                print(error.localizedDescription)
            }
        } else {
            self.continueSegueID = "toLoginRegisterScreen"
        }
        
        super.viewDidLoad()

    }
    
    override func viewDidAppear(_ animated: Bool) {
        self.ref = Database.database().reference()
        if let user = Auth.auth().currentUser{
            
            let userID = user.uid
            self.ref!.child("children").child(userID).observeSingleEvent(of: .value, with: { (snapshot) in
                
                if snapshot.childrenCount == 0 {
                    self.continueSegueID = "toAddKidScreen"
                }else{
                    self.continueSegueID = "toSelectKidScreen"
                }
                
            }) { (error) in
                print(error.localizedDescription)
            }
        } else {
            self.continueSegueID = "toLoginRegisterScreen"
        }
    }

    @IBAction func continueButtonTapped(_ sender: Any) {
        
        performSegue(withIdentifier: continueSegueID, sender: nil)
        
    }
}
