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
    @IBOutlet weak var scoreView: UILabel!
    
    var center :CGPoint?    // Point declared for nodal detection
    
    var score: Int = 0
    
    var questionNumber: Int = 0

    
    var array = [String](arrayLiteral: "Mercury", "Venus", "Earth", "Mars", "Jupiter", "Saturn", "Uranus", "Neptune", "Pluto" )
    
    var questions = [Question]()
    
    
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
        
        // Create a 2d coordinate in the middle of the screen for node detection location
        center = CGPoint(x:sceneView.bounds.midX,y:sceneView.bounds.midY)
        
        
        
        let parentNode = SCNNode()
        parentNode.position.z = -5
        
        // Planets
        // order = merc, venus, earth, Mars, Jupiter, Saturn, Uranus, Neptune, Pluto
        placePlanetsForQuiz()
        
        
        
//        let mercury = Planet(name: "Mercury", radius: 0.50, rotation: CGFloat(GLKMathDegreesToRadians(22)), texture: UIImage(named: "art.scnassets/LowRes/mercury.jpg")!, distanceFromSun: 1.5)
        
//        parentNode.addChildNode(createNode(from: mercury))
        
//        sceneView.scene.rootNode.addChildNode(parentNode)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        // Create a session configuration
        let configuration = ARWorldTrackingConfiguration()
        
        // Run the view's session
        sceneView.session.run(configuration)
    }
//
//
//    override func viewWillDisappear(_ animated: Bool) {
//
//    }
    
    
    
    
    
    
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
        planetNode.position.x = -position.x
        planetNode.position.y = -position.y
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
        
        
        
        // Add Text Node (name of planet) with the same texture as of the planet to parent node
//        parentNode.addChildNode(createTextNode(from: planetNode,texture: planet.texture))
        
        // Add axial rotation
        //        let axisRotateAction = SCNAction.rotate(by: .pi/2, around: SCNVector3(0,1,0), duration: 1)
        //        planetNode.runAction(.repeatForever(axisRotateAction))
        
        // Add orbital rotation and particle trace of orbit to all planets except the sun and add action to parent node
        if planet.name == "sun"{
            let sunFlare = SCNParticleSystem(named: "sunFlare.scnp", inDirectory: nil)!
            planetNode.addParticleSystem(sunFlare)
        }
        
        return parentNode
    }
    
    // Function detects a node via the hitTest in the center of the screen with a CGPoint
    func detectNode() -> String {
        
        let sceneHitTest = sceneView.hitTest(center!, options: nil)
        guard let hitNode = sceneHitTest.last?.node else {return "No name found!"}
        return hitNode.name ?? "No name to return"
        
    }
    
    
    
    
    //  Funciton as Tap Gesture Recognizer Handler
    @objc func handleTap(_ gesture: UITapGestureRecognizer) {
        
        
        let results = self.sceneView.hitTest(gesture.location(in: gesture.view), types: ARHitTestResult.ResultType.featurePoint)
        guard let _: ARHitTestResult = results.first else {return}
        
        let tappedNode = self.sceneView.hitTest(gesture.location(in: gesture.view), options: [:])
        
        if !tappedNode.isEmpty {
            let node = tappedNode[0].node
            
            // DispatchQueue for threading and multi-threaded pooling
//            DispatchQueue.main.async {
//                if (node.name != "No name found!" && node.name != "No name to return"){
//                    self.setQuestionText(node.name!)
//
//
//                    self.score+=1
//                }
//            }
            
            print("\(node.name)")
            print("\(questions[questionNumber].solution)")

            if (node.name != "No name found!" && node.name != "No name to return"){
//                self.setQuestionText(node.name!)

                if (node.name! == "\(questions[questionNumber].solution)"){
                    
                    score += questions[questionNumber].score
                    scoreView.text = "\(score)"
                    questionNumber+=1
                    
                    node.removeFromParentNode()
                    
                    QuestionText.text = questions[questionNumber].question
                    
                    
                }

            }
            
            // Debug
            print("Score: ", score)
        }
    }
    


    
    
    
    
    // Function that creates the planets for Quiz
    func placePlanetsForQuiz() {
        
        // Parent Node
        let parentNode = SCNNode()
        parentNode.position.z = -5
        
        // Planets
        // order = merc, venus, earth, Mars, Jupiter, Saturn, Uranus, Neptune, Pluto
        let mercury = Planet(name: "Mercury", radius: 0.10, rotation: CGFloat(GLKMathDegreesToRadians(22)), texture: UIImage(named: "art.scnassets/LowRes/mercury.jpg")!, distanceFromSun: 0)
        
        let venus = Planet(name: "Venus", radius: 0.23, rotation: CGFloat(GLKMathDegreesToRadians(18)), texture: UIImage(named: "art.scnassets/LowRes/venus.jpg")!, distanceFromSun: 0)
        
        let earth = Planet(name: "Earth", radius: 0.25, rotation: CGFloat(GLKMathDegreesToRadians(16)), texture: UIImage(named: "art.scnassets/LowRes/earth.jpg")!, distanceFromSun: 0)
        
        let mars = Planet(name: "Mars", radius: 0.15, rotation: CGFloat(GLKMathDegreesToRadians(2)), texture: UIImage(named: "art.scnassets/LowRes/mars.jpg")!, distanceFromSun: 0)
        
        let jupiter = Planet(name: "Jupiter", radius: 0.80, rotation: CGFloat(GLKMathDegreesToRadians(5)), texture: UIImage(named: "art.scnassets/LowRes/jupiter.jpg")!, distanceFromSun: 0)
        
        let saturn = Planet(name: "Saturn", radius: 0.75, rotation: CGFloat(GLKMathDegreesToRadians(9)), texture: UIImage(named: "art.scnassets/LowRes/saturn.jpg")!, distanceFromSun: 0)
        
        let uranus = Planet(name: "Uranus", radius: 0.46, rotation: CGFloat(GLKMathDegreesToRadians(10)), texture: UIImage(named: "art.scnassets/LowRes/uranus.jpg")!, distanceFromSun: 0)
        
        let neptune = Planet(name: "Neptune", radius: 0.45, rotation: CGFloat(GLKMathDegreesToRadians(13)), texture: UIImage(named: "art.scnassets/LowRes/neptune.jpg")!, distanceFromSun: 0)
        
        let pluto = Planet(name: "Pluto", radius: 0.05, rotation: CGFloat(GLKMathDegreesToRadians(15)), texture: UIImage(named: "art.scnassets/LowRes/pluto.jpg")!, distanceFromSun: 0)
        
        // The Sun and sunFlare animation
        let sun = Planet(name: "Sun", radius: 0.5, rotation: CGFloat(5), texture: UIImage(named: "art.scnassets/sun_8k.jpg")!, distanceFromSun: 0)
        
        
        // Add planets to Array for ease of use
        let planets = [sun, mercury, venus, earth, mars, jupiter, saturn, uranus, neptune, pluto]
        
        // Create Planet nodes and add to Parent Node
        for planet in planets {
            
            var position = SCNVector3Make((Float.random(in: 0.4 ..< 1) * Float(Int.random(in: -10 ..< 10))),
                                          (Float.random(in: 0.4 ..< 1) * Float(Int.random(in: -3 ..< 3))),
                                          (Float.random(in: 0.4 ..< 1) * Float(Int.random(in: -10 ..< 10))))
            
            
            
            
            parentNode.addChildNode(createNode(from: planet, position: position))
        }
        
        // Light
        //        let light = SCNLight()
        //        light.type = .omni
        //        let lightNode = SCNNode()
        //        lightNode.light = light
        //        lightNode.position.y = 3
        //        parentNode.addChildNode(lightNode)
        //        parentNode.light = light
        
//        // Star particles
//        let stars = SCNParticleSystem(named: "Stars.scnp", inDirectory: nil)!
//        parentNode.addParticleSystem(stars)
        
        sceneView.scene.rootNode.addChildNode(parentNode)
        
    }
    

}


