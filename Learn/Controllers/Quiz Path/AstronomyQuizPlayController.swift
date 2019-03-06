//
//  AstronomyQuizPlayController.swift
//  Learn
//
//  Created by Shiza Siddique on 3/3/19.
//  Copyright © 2019 Mani. All rights reserved.
//

import UIKit
import Firebase
import FirebaseDatabase

class AstronomyQuizPlayController: UIViewController {

    @IBOutlet weak var scoreLabel: UILabel!
    
    //Firebase DB ref
    var ref: DatabaseReference?
    
        
    override func viewDidLoad() {
        super.viewDidLoad()
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        let defaults = UserDefaults.standard
        let currentKid = defaults.value(forKey: "CurrentKid") as! String
        
        if let user = Auth.auth().currentUser{
            
            let userID = user.uid
            self.ref!.child("score").child(userID).child(currentKid).observeSingleEvent(of: .value, with: { (snapshot) in
                
                if let s = snapshot.childSnapshot(forPath: "AstronomyScore").value{
                    self.scoreLabel.text = "Score: \(s)"
                } else {
                    print("ERROR! getting AstronomyScore from Firebase")
                }
                
            }) { (error) in
                print(error.localizedDescription)
            }
        }
    }
    
        
    @IBAction func onPlayButton(_ sender: UIButton) {
//        print("clicked")
        performSegue(withIdentifier: "homeToAstronomyAR", sender: self)
        
    }
 
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    @IBAction func backBtnTapped(_ sender: Any) {
        dismiss(animated: true, completion: nil)
    }

}
