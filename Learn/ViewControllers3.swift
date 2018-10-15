//
//  ViewController3ViewController.swift
//  Learn
//
//  Created by Mani on 10/14/18.
//  Copyright © 2018 Mani. All rights reserved.
//

import UIKit

class ViewControllers3: UIViewController {

    
    
    @IBOutlet var learnBtn: UIButton!
    @IBOutlet weak var playBtn: UIButton!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        playBtn.layer.cornerRadius = 115
        playBtn.clipsToBounds = true
        
        learnBtn.layer.cornerRadius = 115
        learnBtn.clipsToBounds = true

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
