//
//  ViewController3ViewController.swift
//  Learn
//

import UIKit
import AVFoundation


var backgroundPlayer = AVAudioPlayer()
class PlayLearnViewController: UIViewController {

    
    
  
    
    @IBOutlet weak var iconImage: UIImageView!
    @IBOutlet weak var logoutPane: UIButton!
    @IBOutlet var learnBtn: UIButton!
    @IBOutlet weak var playBtn: UIButton!
    
//    var backgroundPlayer = AVAudioPlayer()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        logoutPane.isHidden = true
        iconImage.isHidden = true
        
        playBtn.layer.cornerRadius = 115
        playBtn.clipsToBounds = true
        
        learnBtn.layer.cornerRadius = 115
        learnBtn.clipsToBounds = true

        playBackgroundMusic(musicFileName: "art.scnassets/Sounds/leARnBackgroundMusic.WAV")
       
    }

    @IBAction func UserIconBtn(_ sender: UIButton) {
        logoutPane.isHidden = false
        iconImage.isHidden  = false
    }
    
    @IBAction func logoutBtn(_ sender: Any) {
        print("logout btn working GREAT")
        
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
