//
//  GifViewController.swift
//  BotanyModel
//
//  Created by Shiza Siddique on 2/14/19.
//  Copyright © 2019 Shiza Siddique. All rights reserved.
//


import UIKit

class ModelSelectViewController : UIViewController {
    

   
    @IBOutlet weak var gifImage: UIImageView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        DispatchQueue.main.async {
            self.gifImage.loadGif(name: "space")
        }
   
    }
    
    @IBAction func backBtnTapped(_ sender: UIButton) {
        
        dismiss(animated: true, completion: nil)
    }
    
}
