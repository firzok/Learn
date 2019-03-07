//
//  ViewController3ViewController.swift
//  Learn
//

import UIKit
import AVFoundation
import Firebase


var backgroundPlayer = AVAudioPlayer()
class PlayLearnViewController: UIViewController {

    
    
    //Firebase DB ref
    var ref: DatabaseReference?
    
    //leaderboard vars
    var u1:[String] = []
    var numberOfChildren:Int = 0
    
    
    
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
        loadLeaderBoard()
       
    }

    @IBAction func UserIconBtn(_ sender: UIButton) {
        logoutPane.isHidden = false
        iconImage.isHidden  = false
    }
    
    @IBAction func logoutBtn(_ sender: Any) {
        print("logout btn working GREAT")
        
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
    
    
    func loadLeaderBoard(){
        self.numberOfChildren = 0
        self.ref = Database.database().reference()
        
        self.ref!.child("score").observeSingleEvent(of: .value, with: { (snapshot) in
            
            
            for users in snapshot.children{
                
                let user = users as! DataSnapshot
                
                for child in user.children {
                    self.numberOfChildren += 1
                    
                    let snap = child as! DataSnapshot
                    
                    let name = snap.key
                    
                    self.u1.append(name)
                    
                    if let bs = snap.childSnapshot(forPath: "BotanyScore").value! as? NSNumber, let ass = snap.childSnapshot(forPath: "AstronomyScore").value! as? NSNumber, let ans = snap.childSnapshot(forPath: "AnatomyScore").value! as? NSNumber, let tim = snap.childSnapshot(forPath: "UsingAppTimer").value! as? NSNumber{
                        
                        
                        self.u1.append("\(bs)")
                        self.u1.append("\(ass)")
                        self.u1.append("\(ans)")
                        self.u1.append("\(tim)")
                        
                        
                    }
                    
                    
                    
                }
            }
            
            
            
        }) { (error) in
            print(error.localizedDescription)
        }
    }
    
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?)
    {
        if segue.destination is LeaderBoardViewController
        {
            let vc = segue.destination as? LeaderBoardViewController
            
            vc?.numberOfChildren = self.numberOfChildren
            vc?.u1 = self.u1
            
            
            
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
