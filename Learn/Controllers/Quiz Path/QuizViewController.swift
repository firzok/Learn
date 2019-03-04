//
//  QuizViewController.swift
//  Learn
//
//  Created by Firzok Nadeem on 05/12/2018.
//  Copyright © 2018 Mani. All rights reserved.
//

import UIKit
import SceneKit
import ARKit

class QuizViewController: UIViewController, ARSCNViewDelegate {
    
    @IBOutlet weak var sceneView: ARSCNView!
    @IBOutlet weak var QuestionText: UITextView!
    @IBOutlet var tapRec: UITapGestureRecognizer!
    
    //used to display score to player
    @IBOutlet weak var scoreView: UILabel!
    
    //used to display timer to player
    @IBOutlet weak var timerView: UILabel!
    
    //to store how many sceonds the game is played for
    var seconds = 30
    
    //timer
    var timer = Timer()
    
    //used to store the score
    var score: Int = 0
    var questionNumber: Int = 0
    var array = ["Mercury", "Venus", "Earth", "Mars", "Jupiter",
                 "Saturn", "Uranus", "Neptune", "Pluto"]
    
    var solarSystemAssetsPath = "art.scnassets/SolarSystem/PlanetTextures/" //Textures and Assets Path
    var questions = [Question] ()
    var sounds = AVAudioPlayer()
    
    override func viewDidLoad() {
        
        super.viewDidLoad()

        scoreView.text = "\(score)"
        
        questions.append(Question(question: "Find and Tap on Mars.", solution: "Mars", score: 10))
        questions.append(Question(question: "Find and Tap on Jupiter.", solution: "Jupiter", score: 10))
        questions.append(Question(question: "Find and Tap on Saturn.", solution: "Saturn", score: 10))
        questions.append(Question(question: "Find and Tap on Earth.", solution: "Earth", score: 10))
        questions.append(Question(question: "Find and Tap on Neptune.", solution: "Neptune", score: 10))
        questions.append(Question(question: "Find and Tap on Pluto.", solution: "Pluto", score: 10))
        questions.append(Question(question: "Find and Tap on Mercury.", solution: "Mercury", score: 10))
        questions.append(Question(question: "Find and Tap on Venus.", solution: "Venus", score: 10))
        questions.append(Question(question: "Find and Tap on Sun.", solution: "Sun", score: 10))
        questions.append(Question(question: "Find and Tap on Uranus.", solution: "Uranus", score: 10))
        
        QuestionText.text = questions[questionNumber].question
        
        
        // Set the view delegate
        sceneView.delegate = self
        
        // Show statistics such as fps and timing information
        sceneView.showsStatistics = true
        
        // Enable Auto lightning
        sceneView.autoenablesDefaultLighting = true
        
        // Create and add a tap gesture recognizer to the scene
        tapRec = UITapGestureRecognizer(target: self, action: #selector(QuizViewController.handleTap(_:)))
        sceneView.addGestureRecognizer(tapRec)

        let parentNode = SCNNode()
        parentNode.position.z = -5
        
        // Planets
        // order = merc, venus, earth, Mars, Jupiter, Saturn, Uranus, Neptune, Pluto
        placePlanetsForQuiz()
        
//        backgroundPlayer.stop()
        
        //start tinmer
        runTimer()
        
    }
    
    // Mark: - Game Over and Timer
    func gameOver(){
        //store the score in UserDefaults
        let defaults = UserDefaults.standard
        defaults.set(score, forKey: "AstronomyScore")
        
        //go back to the Home View Controller
        self.dismiss(animated: true, completion: nil)
    }
    
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
            timerView.text = "\(seconds)"
        }
    }
    
//    //resets the timer
//    func resetTimer(){
//        timer.invalidate()
//        seconds = 0
//        timerView.text = "\(seconds)"
//    }
    
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        // Create a session configuration
        let configuration = ARWorldTrackingConfiguration()
        
        // Run the view's session
        sceneView.session.run(configuration)
    }
    
    // Function that creates the planets for Quiz
    func placePlanetsForQuiz() {
        
        // Parent Node
        let parentNode = SCNNode()
        parentNode.position.z = -5
        
        // Planets
        // order = merc, venus, earth, Mars, Jupiter, Saturn, Uranus, Neptune, Pluto
        let mercury = Planet(name: "Mercury", radius: 0.10, rotation: CGFloat(GLKMathDegreesToRadians(22)), texture: UIImage(named: "\(solarSystemAssetsPath)mercury.jpg")!, distanceFromSun: 1.5, desc:"s")
        
        let venus = Planet(name: "Venus", radius: 0.2, rotation: CGFloat(GLKMathDegreesToRadians(18)), texture: UIImage(named: "\(solarSystemAssetsPath)venus.jpg")!, distanceFromSun: 2, desc: "s")
        
        let earth = Planet(name: "Earth", radius: 0.25, rotation: CGFloat(GLKMathDegreesToRadians(16)), texture: UIImage(named: "\(solarSystemAssetsPath)earth.jpg")!, distanceFromSun: 2.5, desc: "s")
        
        let mars = Planet(name: "Mars", radius: 0.15, rotation: CGFloat(GLKMathDegreesToRadians(2)), texture: UIImage(named: "\(solarSystemAssetsPath)mars.jpg")!, distanceFromSun: 3, desc: "s")
        
        let jupiter = Planet(name: "Jupiter", radius: 0.40, rotation: CGFloat(GLKMathDegreesToRadians(5)), texture: UIImage(named: "\(solarSystemAssetsPath)jupiter.jpg")!, distanceFromSun: 4, desc: "s")
        
        let saturn = Planet(name: "Saturn", radius: 0.45, rotation: CGFloat(GLKMathDegreesToRadians(9)), texture: UIImage(named: "\(solarSystemAssetsPath)saturn.jpg")!, distanceFromSun: 6, desc: "s")
        
        let uranus = Planet(name: "Uranus", radius: 0.35, rotation: CGFloat(GLKMathDegreesToRadians(10)), texture: UIImage(named: "\(solarSystemAssetsPath)uranus.jpg")!, distanceFromSun: 7, desc: "s")
        
        let neptune = Planet(name: "Neptune", radius: 0.3, rotation: CGFloat(GLKMathDegreesToRadians(13)), texture: UIImage(named: "\(solarSystemAssetsPath)neptune.jpg")!, distanceFromSun: 8, desc: "s")
        
        let pluto = Planet(name: "Pluto", radius: 0.17, rotation: CGFloat(GLKMathDegreesToRadians(10)), texture: UIImage(named: "\(solarSystemAssetsPath)pluto.jpg")!, distanceFromSun: 8.5, desc: "s")
        
        // The Sun and sunFlare animation
        let sun = Planet(name: "sun", radius: 0.5, rotation: CGFloat(5), texture: UIImage(named: "\(solarSystemAssetsPath)sun.jpg")!, distanceFromSun: 0, desc: "s")
        
        
        // Add planets to Array for ease of use
        let planets = [sun, mercury, venus, earth, mars, jupiter, saturn, uranus, neptune, pluto]
        
        // Create Planet nodes and add to Parent Node
        for planet in planets {
            
            let position = SCNVector3Make((Float.random(in: 0.4 ..< 1) * Float(Int.random(in: -10 ..< 10))),
                                          (Float.random(in: 0.4 ..< 1) * Float(Int.random(in: -3 ..< 3))),
                                          (Float.random(in: 0.4 ..< 1) * Float(Int.random(in: -10 ..< 10))))
            
            parentNode.addChildNode(createNode(from: planet, position: position))
        }
        
        sceneView.scene.rootNode.addChildNode(parentNode)
        
    }
    
    // Function that creates a Text node for planet from name and applies given texture
    func createAnswerCheckNode(checker: String, planet: SCNNode) -> SCNNode {
        
        let textGeometry = SCNText(string: "\(checker)", extrusionDepth: 1.0)
        
        if (checker == "correct") {
            textGeometry.firstMaterial?.diffuse.contents = UIColor.green
        }
        else {
            
            textGeometry.firstMaterial?.diffuse.contents = UIColor.red
        }
        
        let textNode = SCNNode(geometry: textGeometry)
//        textNode.position = planet.position
        textNode.position.y = planet.position.y + 1
        textNode.scale = SCNVector3(0.05, 0.05, 0.05)
        
        return textNode
    }
    
    // Function that creates a node from planet
    func createNode(from planet: Planet, position: SCNVector3) -> SCNNode {
        
        // Create a parent node which will hold bith text and planet together
        let parentNode = SCNNode()
        
        // Create a spherical geometry node and apply texture
        let sphereGeometry = SCNSphere(radius: planet.radius)
        sphereGeometry.firstMaterial?.diffuse.contents = planet.texture
        
        // Create a node to contain a planet inside the spherical geometry
        let planetNode = SCNNode(geometry: sphereGeometry)
        planetNode.position.z = -position.z
        planetNode.position.x = position.x
        planetNode.position.y = position.y
        planetNode.name = planet.name
        
        // Add planet to parent node
        parentNode.addChildNode(planetNode)
        
        // Add rings of Saturn to Saturn Planet node
        if planet.name == "Saturn" {
            let ringGeometry = SCNTube(innerRadius: 1, outerRadius: 1.4, height: 0.05)
            ringGeometry.firstMaterial?.diffuse.contents = UIImage(named:"art.scnassets/LowRes/saturn-ring.png")
            
            let ringNode = SCNNode(geometry: ringGeometry)
            ringNode.eulerAngles.x = Float(-20.degToRad)
            planetNode.addChildNode(ringNode)
            
        }
        
        // Add Sun Particle Effects
        if planet.name == "sun"{
            let sunFlare = SCNParticleSystem(named: "sunFlare.scnp", inDirectory: nil)!
            planetNode.addParticleSystem(sunFlare)
        }
        
        return parentNode
    }
    
    //  Funciton for the Tap Gesture Recognizer Handler
    @objc func handleTap(_ gesture: UITapGestureRecognizer) {
        
        
        let results = self.sceneView.hitTest(gesture.location(in: gesture.view), types: ARHitTestResult.ResultType.featurePoint)
        guard let _: ARHitTestResult = results.first else {return}
        
        let tappedNode = self.sceneView.hitTest(gesture.location(in: gesture.view), options: [:])
        
        if !tappedNode.isEmpty {
            let node = tappedNode[0].node
            
            // DispatchQueue for threading and multi-threaded pooling
            DispatchQueue.main.async {
            
                if (node.name! == "\(self.questions[self.questionNumber].solution)"){
                    self.score += self.questions[self.questionNumber].score
                    self.playBackgroundMusic(musicFileName: "art.scnassets/Sounds/sound108.wav")
                    self.scoreView.text = "\(self.score)"
                    self.questionNumber += 1
                    
                    if (self.questionNumber == 9){
                        self.gameOver()
//                        self.resetScene()
                        self.questionNumber = 0
                    }
                    else{
                        node.removeFromParentNode()
                    }
                    
                    self.QuestionText.text = self.questions[self.questionNumber].question
                }
                
                else {

                    self.score -= self.questions[self.questionNumber].score
                    self.scoreView.text = "\(self.score)"
                    self.playBackgroundMusic(musicFileName: "art.scnassets/Sounds/sound108.wav")
                    node.addChildNode(self.createAnswerCheckNode(checker: "Wrong", planet: node))
                    
                }

            }
        }
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
    
   
    // Reset The scene by removing all planets
    func resetScene() {
        self.sceneView.scene.rootNode.enumerateChildNodes { (nodes, stop) in
            nodes.removeFromParentNode()
        }
    }
    
    
    @IBAction func backBtnPressed(_ sender: UIButton) {
        
        dismiss(animated: true, completion: nil)
    }
    
}




