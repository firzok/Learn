//
//  BotanyQuizPlayController.swift
//  Learn
//
//  Created by Shiza Siddique on 2/27/19.

import UIKit

class AnatomyQuizPlayController: UIViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
    }
    
    override func viewWillAppear(_ animated: Bool) {
        let defaults = UserDefaults.standard
        if let gameScore = defaults.value(forKey: "score"){
            let score = gameScore as! Int
            scoreLabel.text = "Score: \(String(score))"
        }
        
        print("view will appear")
    }
    
    @IBAction func onPlayButton(_ sender: Any) {
        print("clicked")
        performSegue(withIdentifier: "homeToGameSegue", sender: self)
    }
    
    @IBOutlet weak var scoreLabel: UILabel!
    
    
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    @IBAction func backButtonTapped(_ sender: UIButton) {
        
        dismiss(animated: true, completion: nil)
    }
    
}

