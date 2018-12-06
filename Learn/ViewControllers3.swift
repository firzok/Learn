//
//  ViewController3ViewController.swift
//  Learn
//
//  Created by Mani on 10/14/18.
//  Copyright © 2018 Mani. All rights reserved.
//

import UIKit
import AVFoundation

class ViewControllers3: UIViewController {

    
    
    @IBOutlet var learnBtn: UIButton!
    @IBOutlet weak var playBtn: UIButton!
    
    var backgroundPlayer = AVAudioPlayer()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        playBtn.layer.cornerRadius = 115
        playBtn.clipsToBounds = true
        
        learnBtn.layer.cornerRadius = 115
        learnBtn.clipsToBounds = true

        playBackgroundMusic(musicFileName: "art.scnassets/leARnBackgroundMusic.WAV")
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func playBackgroundMusic(musicFileName: String) {
        let url = Bundle.main.url(forResource: musicFileName, withExtension: nil)
        
        do {
            backgroundPlayer = try AVAudioPlayer(contentsOf: url!)
            backgroundPlayer.numberOfLoops = -1
            backgroundPlayer.prepareToPlay()
            backgroundPlayer.play()
        }
        catch let error as NSError{
            print(error.description)
        }
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
