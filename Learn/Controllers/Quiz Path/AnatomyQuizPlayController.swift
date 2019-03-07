//
//  BotanyQuizPlayController.swift
//  Learn
//
//  Created by Shiza Siddique on 2/27/19.

import UIKit
import Firebase
import FirebaseDatabase

class AnatomyQuizPlayController: UIViewController {
    
    
    @IBAction func onPlayButton(_ sender: Any) {
//        print("clicked")
        performSegue(withIdentifier: "homeToGameSegue", sender: self)
    }
    
    
    @IBOutlet weak var highScoreLabel: UILabel!
    //    @IBOutlet weak var highScoreLabel: UILabel?
    
    @IBOutlet weak var scoreLabel: UILabel!
    
    
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    @IBAction func backButtonTapped(_ sender: UIButton) {
        
        dismiss(animated: true, completion: nil)
    }
    
    //Firebase DB ref
    var ref: DatabaseReference?
    
    override func viewDidLoad() {
        
        self.ref = Database.database().reference()
        super.viewDidLoad()
        
        
        // Do any additional setup after loading the view.
    }
    
    
    override func viewDidAppear(_ animated: Bool) {
        let defaults = UserDefaults.standard
        let currentKid = defaults.value(forKey: "CurrentKid") as! String
        
        
        if let gameScore = defaults.value(forKey: "AnatomyLastScore"+currentKid){
            let score = gameScore as! Int
            scoreLabel.text = "Last Score: \(String(score))"
        } else {
            scoreLabel.text = "Last Score: 0"
        }
        
        if let user = Auth.auth().currentUser{
            
            let userID = user.uid
            self.ref!.child("score").child(userID).child(currentKid).observeSingleEvent(of: .value, with: { (snapshot) in
                
                if let s = snapshot.childSnapshot(forPath: "AnatomyScore").value{
                    if s is NSNull{
                        self.highScoreLabel.text = "High Score: 0"
                    } else{
                        self.highScoreLabel.text = "High Score: \(s)"
                    }
                } else {
                    print("ERROR! getting AnatomyScore from Firebase")
                }
                
            }) { (error) in
                print(error.localizedDescription)
            }
        }
    }
    
}

