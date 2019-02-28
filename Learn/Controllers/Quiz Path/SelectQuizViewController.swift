//
//  SelectQuizViewController.swift
//  Learn
//
//  Created by Shiza Siddique on 2/27/19.


import UIKit

class SelectQuizViewController: UIViewController {

    @IBOutlet weak var AstronomyQuizBtn: UIButton!
    
    @IBOutlet weak var BotanyQuizBtn: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        
        AstronomyQuizBtn.layer.masksToBounds = true
        AstronomyQuizBtn.layer.cornerRadius = AstronomyQuizBtn.frame.width/2
        AstronomyQuizBtn.layer.borderWidth = 5
        AstronomyQuizBtn.layer.borderColor = #colorLiteral(red: 0.1143538281, green: 0.4587836266, blue: 0.5056027174, alpha: 1)
        
        BotanyQuizBtn.layer.masksToBounds = true
        BotanyQuizBtn.layer.cornerRadius = BotanyQuizBtn.frame.width/2
        BotanyQuizBtn.layer.borderWidth = 5
        BotanyQuizBtn.layer.borderColor = #colorLiteral(red: 0.1143538281, green: 0.4587836266, blue: 0.5056027174, alpha: 1)
    }
    
    @IBAction func backBtnPressed(_ sender: UIButton) {
        
        dismiss(animated: true, completion: nil)
    }
    
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
