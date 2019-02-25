//
//  PlantStructureViewController.swift
//  Learn
//
//  Created by Shiza Siddique on 2/21/19.
//  Copyright © 2019 Mani. All rights reserved.
//

import UIKit

class PlantStructureViewController: UIViewController {
    
    @IBOutlet weak var plants: UILabel!
    @IBOutlet weak var higherPlants: UILabel!
    @IBOutlet weak var simplePlanrs: UILabel!
    
    @IBOutlet weak var flowers: UIButton!
    @IBOutlet weak var conifers: UIButton!
    @IBOutlet weak var lilies: UIButton!
    
    
    @IBOutlet weak var ferns: UIButton!
    @IBOutlet weak var mosses: UIButton!
    @IBOutlet weak var algae: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        plants.layer.masksToBounds = true
        plants.layer.cornerRadius = plants.frame.width/2
        plants.layer.borderWidth = 5
        plants.layer.borderColor = #colorLiteral(red: 0.4666666687, green: 0.7647058964, blue: 0.2666666806, alpha: 1)
        
        higherPlants.layer.masksToBounds = true
        higherPlants.layer.cornerRadius = higherPlants.frame.width/2
        higherPlants.layer.borderWidth = 5
        higherPlants.layer.borderColor = #colorLiteral(red: 0.4666666687, green: 0.7647058964, blue: 0.2666666806, alpha: 1)
        
        simplePlanrs.layer.masksToBounds = true
        simplePlanrs.layer.cornerRadius = simplePlanrs.frame.width/2
        simplePlanrs.layer.borderWidth = 5
        simplePlanrs.layer.borderColor = #colorLiteral(red: 0.4666666687, green: 0.7647058964, blue: 0.2666666806, alpha: 1)
        
        flowers.layer.masksToBounds = true
        flowers.layer.cornerRadius = flowers.frame.width/2
        flowers.layer.borderWidth = 4
        flowers.layer.borderColor = #colorLiteral(red: 0.4666666687, green: 0.7647058964, blue: 0.2666666806, alpha: 1)
        
        conifers.layer.masksToBounds = true
        conifers.layer.cornerRadius = conifers.frame.width/2
        conifers.layer.borderWidth = 4
        conifers.layer.borderColor = #colorLiteral(red: 0.4666666687, green: 0.7647058964, blue: 0.2666666806, alpha: 1)
        
        lilies.layer.masksToBounds = true
        lilies.layer.cornerRadius = algae.frame.width/2
        lilies.layer.borderWidth = 4
        lilies.layer.borderColor = #colorLiteral(red: 0.4666666687, green: 0.7647058964, blue: 0.2666666806, alpha: 1)
        
        algae.layer.masksToBounds = true
        algae.layer.cornerRadius = algae.frame.width/2
        algae.layer.borderWidth = 4
        algae.layer.borderColor = #colorLiteral(red: 0.4666666687, green: 0.7647058964, blue: 0.2666666806, alpha: 1)
        
        ferns.layer.masksToBounds = true
        ferns.layer.cornerRadius = ferns.frame.width/2
        ferns.layer.borderWidth = 4
        ferns.layer.borderColor = #colorLiteral(red: 0.4666666687, green: 0.7647058964, blue: 0.2666666806, alpha: 1)
        
        mosses.layer.masksToBounds = true
        mosses.layer.cornerRadius = ferns.frame.width/2
        mosses.layer.borderWidth = 4
        mosses.layer.borderColor = #colorLiteral(red: 0.4666666687, green: 0.7647058964, blue: 0.2666666806, alpha: 1)
    }
    
    
    
    @IBAction func selectModel(_ sender: UIButton) {
        print("sender \(sender.currentTitle!)")
//        UIView.animate(withDuration: 0.6,
//                       animations: {
//                        sender.transform = CGAffineTransform(scaleX: 0.6, y: 0.6)
//        },
//                       completion: { _ in
//                        UIView.animate(withDuration: 0.6) {
//                            sender.transform = CGAffineTransform.identity
//                        }
//        })
        
        performSegue(withIdentifier: "Choose Model", sender: sender)
        
    }
    
    // MARK: - Navigation
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
        
        if segue.identifier == "Choose Model"{
            if let modelName = (sender as? UIButton)?.currentTitle{
                if let cvc = segue.destination as? BotanyARSceneController{
                    print("model \(modelName)")
                    cvc.modelName = modelName
                }
                
            }
        }
        
    }
    
    
}

