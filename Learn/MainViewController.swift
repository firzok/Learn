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

class MainViewController: UIViewController{
    
    
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        if let user = Auth.auth().currentUser{
            self.performSegue(withIdentifier: "toHomescreen", sender: self)
        }
    }

    
    
}
