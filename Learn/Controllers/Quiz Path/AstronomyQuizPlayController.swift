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
    
    @IBOutlet weak var highScoreLabel: UILabel!
    
    //Firebase DB ref
    var ref: DatabaseReference?
    
        
    override func viewDidLoad() {
        super.viewDidLoad()
        
    }
    
    override func viewDidAppear(_ animated: Bool) {
        let defaults = UserDefaults.standard
        let currentKid = defaults.value(forKey: "CurrentKid") as! String
        
        if let gameScore = defaults.value(forKey: "AstronomyLastScore"+currentKid){
            let score = gameScore as! Int
            scoreLabel.text = "Last Score: \(String(score))"
        } else{
            scoreLabel.text = "Last Score: 0"
        }
        
        if let user = Auth.auth().currentUser{
            
            self.ref = Database.database().reference()
            
            let userID = user.uid
            self.ref!.child("score").child(userID).child(currentKid).observeSingleEvent(of: .value, with: { (snapshot) in
                
                if let s = snapshot.childSnapshot(forPath: "AstronomyScore").value{
                    if s is NSNull{
                        self.highScoreLabel.text = "High Score: 0"
                    } else{
                        self.highScoreLabel.text = "High Score: \(s)"
                    }
                    
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
