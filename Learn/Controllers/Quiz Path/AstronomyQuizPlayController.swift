//
//  AstronomyQuizPlayController.swift
//  Learn
//
//  Created by Shiza Siddique on 3/3/19.
//  Copyright © 2019 Mani. All rights reserved.
//

import UIKit

class AstronomyQuizPlayController: UIViewController {

    @IBOutlet weak var scoreLabel: UILabel!
    
    
        
    override func viewDidLoad() {
        super.viewDidLoad()
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        let defaults = UserDefaults.standard
        if let gameScore = defaults.value(forKey: "AstronomyScore"){
            let score = gameScore as! Int
            scoreLabel.text = "Score: \(String(score))"
        }
    }
    
        
    @IBAction func onPlayButton(_ sender: UIButton) {
        print("clicked")
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
