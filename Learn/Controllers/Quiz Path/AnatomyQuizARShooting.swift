
//  BotanyQuizARShooting.swift
//
//  Created by Shiza Siddique on 2/13/19.
//

import UIKit
import SceneKit
import ARKit
import Firebase
import FirebaseDatabase

class AnatomyQuizARShooting: UIViewController, ARSCNViewDelegate, SCNPhysicsContactDelegate {
    
    //Firebase DB ref
    var ref: DatabaseReference?
    
    //MARK: - variables
    
    @IBOutlet weak var questionText: UITextView!
    var questionNumber: Int = 0
    var questions = [Question] ()
    var sounds = AVAudioPlayer()
    
    
    @IBOutlet weak var sceneView: ARSCNView!
    
    //used to display timer to player
    @IBOutlet weak var timerLabel: UILabel!
    
    //used to display score to player
    @IBOutlet weak var scoreLabel: UILabel!
    
    //used to store the score
    var score = 0
    
    //anatomy models
    let anatomyModels = ["Heart","Brain","Muscle","Eyes","TeethWithoutLabel"]
    
    let vectorX = [-4,-3,-2,2,3,4]
    let vectorY = [-2,-1,1,2]
    let vectorZ = [-4,-3,-2,2,3,4]
    
    
    //Pokemonball button
    @IBAction func fireBallButton(_ sender: Any) {
        fireMissile(type: "Ball")
    }
    
    
    //MARK: - maths
    
    func getUserVector() -> (SCNVector3, SCNVector3) { // (direction, position)
        if let frame = self.sceneView.session.currentFrame {
            let mat = SCNMatrix4(frame.camera.transform) // 4x4 transform matrix describing camera in world space
            let dir = SCNVector3(-1 * mat.m31, -1 * mat.m32, -1 * mat.m33) // orientation of camera in world space
            let pos = SCNVector3(mat.m41, mat.m42, mat.m43) // location of camera in world space
            
            return (dir, pos)
        }
        return (SCNVector3(0, 0, -1), SCNVector3(0, 0, -0.2))
    }
    
    //MARK: - view functions
    

    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        self.ref = Database.database().reference()
        // Set the view's delegate
        sceneView.delegate = self
        
        // Show statistics such as fps and timing information
        //sceneView.showsStatistics = true
        
        //set the physics delegate
        sceneView.scene.physicsWorld.contactDelegate = self
        
        //        sceneView.autoenablesDefaultLighting = true
        //
        //        sceneView.allowsCameraControl = true
        
        //add objects to shoot at
        backgroundPlayer.stop()
        addTargetNodes()
        QuestionBank()
        questionText.text = questions[questionNumber].question

        //play background music
        //        playBackgroundMusic()

        //start tinmer
        runTimer()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        // Create a session configuration
        let configuration = ARWorldTrackingConfiguration()
        
        // Run the view's session
        sceneView.session.run(configuration)

    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        
        // Pause the view's session
        sceneView.session.pause()
        
    }
    
    // Mark: Question Bank
    
    
    func QuestionBank(){
        questions.append(Question(question: "Shoot Heart", solution: "Heart", score: 10))
        questions.append(Question(question: "Shoot Brain", solution: "Brain", score: 10))
        questions.append(Question(question: "Shoot Eyes", solution: "Eyes", score: 10))
        questions.append(Question(question: "Shoot Muscle", solution: "Muscle", score: 10))
        questions.append(Question(question: "Shoot Teeth", solution: "TeethWithoutLabel", score: 10))
    }
    
    // MARK: - timer
    
    //to store how many sceonds the game is played for
    var seconds = 50
    
    //timer
    var timer = Timer()
    
    //    //to keep track of whether the timer is on
    //    var isTimerRunning = false
    
    //to run the timer
    func runTimer() {
        timer = Timer.scheduledTimer(timeInterval: 1, target: self,   selector: (#selector(self.updateTimer)), userInfo: nil, repeats: true)
    }
    
    //decrements seconds by 1, updates the timerLabel and calls gameOver if seconds is 0
    @objc func updateTimer() {
        if seconds == 0 {
            timer.invalidate()
            
            gameOver()
        }else{
            seconds -= 1
            timerLabel.text = "\(seconds)"
        }
    }
    
    //resets the timer
    func resetTimer(){
        timer.invalidate()
        seconds = 0
        timerLabel.text = "\(seconds)"
    }
    
    // MARK: - game over
    func gameOver(){
        //store the score in UserDefaults
        let defaults = UserDefaults.standard
        let kidName = defaults.value(forKey: "CurrentKid") as! String?
        defaults.set(score, forKey: "AnatomyLastScore"+(kidName ?? ""))
        
        if let userID = Auth.auth().currentUser?.uid, let kidName = defaults.value(forKey: "CurrentKid") as! String?{
            self.ref!.child("score").child(userID).child(kidName).observeSingleEvent(of: .value, with: { (snapshot) in
                if let s = snapshot.childSnapshot(forPath: "AnatomyScore").value{
                    
                    if let firebaseScore = s as? Int {
                        if firebaseScore < self.score{
                            self.ref!.child("score").child(userID).child(kidName).updateChildValues(["AnatomyScore": self.score])
                        }
                    } else {
                        self.ref!.child("score").child(userID).child(kidName).updateChildValues(["AnatomyScore": self.score])
                    }
                    
                } else {
                    print("ERROR! getting AnatomyScore from Firebase while trying to save new score")
                }
                
            }) { (error) in
                print(error.localizedDescription)
            }
            
            
        
        } else {
            print("ERROR! Unable to save AnatomyScore to Firebase")
        }
        
        //go back to the Home View Controller
        self.dismiss(animated: true, completion: nil)
    }
    
    // MARK: - fireball & targets
    
    //creates pokemonBall node and fires it
    func fireMissile(type : String){
        var node = SCNNode()
        //create node
        node = createMissile(type: type)
        
        //get the users position and direction
        let (direction, position) = self.getUserVector()
        node.position = position
        var nodeDirection = SCNVector3()
        nodeDirection  = SCNVector3(direction.x*4,direction.y*4,direction.z*4)
        //        node.scale = SCNVector3(0.02,0.02,0.02)
        node.physicsBody?.applyForce(nodeDirection, at: SCNVector3(0.1,0,0), asImpulse: true)
        playBackgroundMusic(musicFileName:"art.scnassets/Sounds/bullet.wav")
        //        playSound(sound: "bullet", format: "wav")
        
        //move node
        node.physicsBody?.applyForce(nodeDirection , asImpulse: true)
        
        //add node to scene
        sceneView.scene.rootNode.addChildNode(node)
    }
    
    //creates nodes
    func createMissile(type : String)->SCNNode{
        var node = SCNNode()
        let scene = SCNScene(named: "art.scnassets/PokemonBall.scn")
        node = (scene?.rootNode.childNode(withName: "Sphere001", recursively: true)!)!
        //        node.scale = SCNVector3(0.02,0.02,0.02)
        node.name = "fireball"
        
        //the physics body governs how the object interacts with other objects and its environment
        node.physicsBody = SCNPhysicsBody(type: .dynamic, shape: nil)
        node.physicsBody?.isAffectedByGravity = false
        
        //these bitmasks used to define "collisions" with other objects
        node.physicsBody?.categoryBitMask = CollisionCategory.missileCategory.rawValue
        node.physicsBody?.collisionBitMask = CollisionCategory.targetCategory.rawValue
        return node
    }
    
    //Adds 100 objects to the scene, spins them, and places them at random positions around the player.
    //    func addTargetNodes(){
    //        for index in 1...50 {
    //
    //            var node = SCNNode()
    //
    //            if (index > 9) && (index % 10 == 0) {
    //                let scene = SCNScene(named: "art.scnassets/AnatomyModels/Brain.scn")
    //                node = (scene?.rootNode.childNode(withName: "Brain", recursively: true)!)!
    //                node.scale = SCNVector3(1.5,1.5,1.5)
    //                node.name = "Brain"
    //            }else{
    //                let scene = SCNScene(named: "art.scnassets/AnatomyModels/Heart.scn")
    //                node = (scene?.rootNode.childNode(withName: "Heart", recursively: true)!)!
    //
    //                node.scale = SCNVector3(1.5,1.5,1.5)
    //                node.name = "Heart"
    //            }
    //
    //            node.physicsBody = SCNPhysicsBody(type: .dynamic, shape: nil)
    //            node.physicsBody?.isAffectedByGravity = false
    //
    //            //place randomly, within thresholds
    ////            node.position = SCNVector3((Float.random(in: 0.4 ..< 1) * Float(Int.random(in: -10 ..< 10))),
    ////                                                (Float.random(in: 0.4 ..< 1) * Float(Int.random(in: -3 ..< 3))),
    ////                                                (Float.random(in: 0.4 ..< 1) * Float(Int.random(in: -10 ..< 10))))
    //            node.position = SCNVector3(randomFloat(min: -10, max: 10),randomFloat(min: -4, max: 5),randomFloat(min: -5, max: 5))
    //
    //            //rotate
    //            let action : SCNAction = SCNAction.rotate(by: .pi, around: SCNVector3(0, 1, 0), duration: 1.0)
    //            let forever = SCNAction.repeatForever(action)
    //            node.runAction(forever)
    //
    //            //for the collision detection
    //            node.physicsBody?.categoryBitMask = CollisionCategory.targetCategory.rawValue
    //            node.physicsBody?.contactTestBitMask = CollisionCategory.missileCategory.rawValue
    //
    //            //add to scene
    //            sceneView.scene.rootNode.addChildNode(node)
    //        }
    //
    //
    //    }
    //["Heart","Body","Brain","Muscle","Eyes","Teeth"]
    //Adds 100 objects to the scene, spins them, and places them at random positions around the player.
    func addTargetNodes(){
        
        
        for _ in 1...2 {
            
            for modelName in anatomyModels{
                print("Add target nodes \(modelName)")
                //place randomly, within thresholds
                //                let position = SCNVector3(randomFloat(min: -5, max: 10),randomFloat(min: -2, max: 3),randomFloat(min: -10, max: 0))
                //                let position = SCNVector3((Float.random(in: 0.4 ..< 1) * Float(Int.random(in: -10 ..< 10))),
                //                                          (Float.random(in: 0.4 ..< 1) * Float(Int.random(in: -3 ..< 3))),
                //                                          (Float.random(in: 0.4 ..< 1) * Float(Int.random(in: -10 ..< 10))))
                //add to scene
                let node = createNode(from: "\(modelName)")
                sceneView.scene.rootNode.addChildNode(node)
                
            }
            
        }
    }
    
    func createNode(from model: String) -> SCNNode {
        
        print("create Node")
        var node = SCNNode()
        
        let scene = SCNScene(named: "art.scnassets/HumanAnatomy/AnatomyModels/\(model).scn")
        print("\(model)")
        node = (scene?.rootNode.childNode(withName: "\(model)", recursively: true)!)!
        //        node = (scene?.rootNode.childNode(withName: "Brain", recursively: true)!)!
        //        node.scale = SCNVector3(1,1,1)
        node.name = "\(model)"
        
//        print(vectorX.randomElement())
        node.position = SCNVector3(vectorX.randomElement()!,vectorY.randomElement()!,vectorZ.randomElement()!)
        
        if node.name == "Eyes"{
            node.scale.x = 0.1
            node.scale.y = 0.1
            node.scale.z = 0.1
            node.eulerAngles.y = 90
        }
        else if node.name == "Muscle"{
            node.scale.x = 0.1
            node.scale.y = 0.1
            node.scale.z = 0.1
        }
        else if node.name == "TeethWithoutLabel"{
            node.scale.x = 0.08
            node.scale.y = 0.08
            node.scale.z = 0.08
            
            node.position.z = -10
        }
        else if node.name == "Heart"{
            node.scale.x = 2.5
            node.scale.y = 2.5
            node.scale.z = 2.5
        }
        else if node.name == "Brain"{
            node.scale.x = 1.5
            node.scale.y = 1.5
            node.scale.z = 1.5
        }
        
        node.physicsBody = SCNPhysicsBody(type: .dynamic, shape: nil)
        node.physicsBody?.isAffectedByGravity = false
       
        //        node.position = position
        
        //rotate
        //        let action : SCNAction = SCNAction.rotate(by: .pi, around: SCNVector3(0, 1, 0), duration: 1.0)
        //        let forever = SCNAction.repeatForever(action)
        //        node.runAction(forever)
        
        //for the collision detection
        node.physicsBody?.categoryBitMask = CollisionCategory.targetCategory.rawValue
        node.physicsBody?.contactTestBitMask = CollisionCategory.missileCategory.rawValue
        
        return node
    }
    
    //create random float between specified ranges
    func randomFloat(min: Float, max: Float) -> Float {
        return (Float(arc4random()) / 1.0) * (max - min) + min
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Release any cached data, images, etc that aren't in use.
    }
    
    
    func session(_ session: ARSession, didFailWithError error: Error) {
        // Present an error message to the user
        
    }
    
    func sessionWasInterrupted(_ session: ARSession) {
        // Inform the user that the session has been interrupted, for example, by presenting an overlay
        
    }
    
    func sessionInterruptionEnded(_ session: ARSession) {
        // Reset tracking and/or remove existing anchors if consistent tracking is required
        
    }
    
    
    
    // MARK: - Contact Delegate
    
    func physicsWorld(_ world: SCNPhysicsWorld, didBegin contact: SCNPhysicsContact) {
        
//        print("questions.count \(questions.count)")
        print("** Collision!! " + contact.nodeA.name! + " hit " + contact.nodeB.name!)
        
        if contact.nodeA.physicsBody?.categoryBitMask == CollisionCategory.targetCategory.rawValue
            || contact.nodeB.physicsBody?.categoryBitMask == CollisionCategory.targetCategory.rawValue {
//            print("blahhhh")
//            print("nodeA \(contact.nodeA.name)")
//            print("nodeB \(contact.nodeB.name)")
            if (contact.nodeA.name! == "\(questions[questionNumber].solution)" || contact.nodeB.name! == "\(questions[questionNumber].solution)"){
                score += questions[questionNumber].score
                questionNumber += 1
                
                print(questionNumber)
                
                if(score >= 30)
                {
                    playBackgroundMusic(musicFileName:"art.scnassets/Sounds/cheers.wav")
                }
                if (self.questionNumber == questions.count){
                    
                    questionNumber = 0
                    gameOver()
                }
                
                self.questionText.text = questions[questionNumber].question
            }
            else{
                score -= questions[questionNumber].score
            }
            DispatchQueue.main.async {
                contact.nodeA.removeFromParentNode()
                contact.nodeB.removeFromParentNode()
                self.scoreLabel.text = String(self.score)
            }
            playBackgroundMusic(musicFileName:"art.scnassets/Sounds/explosion.wav")
            //            playSound(sound: "explosion", format: "wav")
            let  explosion = SCNParticleSystem(named: "Explode", inDirectory: nil)
            contact.nodeB.addParticleSystem(explosion!)
        }
        //        else
        //        {DispatchQueue.main.async {
        //            contact.nodeA.removeFromParentNode()
        //            contact.nodeB.removeFromParentNode()
        //            self.scoreLabel.text = String(self.score)
        //        }}
        
        
    }
    
    
    func playBackgroundMusic(musicFileName: String) {
        let url = Bundle.main.url(forResource: musicFileName, withExtension: nil)
        
        do {
            sounds = try AVAudioPlayer(contentsOf: url!)
            backgroundPlayer.numberOfLoops = 1
            sounds.prepareToPlay()
            sounds.play()
        }
        catch let error as NSError{
            print(error.description)
        }
    }
    
}

//specifying contact and collision behaviors for models and fireball
//setting the categoryBitMask and collisionBitMask properties for each body
struct CollisionCategory: OptionSet {
    let rawValue: Int
    
    static let missileCategory  = CollisionCategory(rawValue: 1 << 0) //for fireball
    static let targetCategory = CollisionCategory(rawValue: 1 << 1) // for models
    static let otherCategory = CollisionCategory(rawValue: 1 << 2)
}
