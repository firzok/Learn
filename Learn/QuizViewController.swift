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
    @IBOutlet weak var planetDetailText: UITextView!
    @IBOutlet var tapRec: UITapGestureRecognizer!
    
    var center :CGPoint?    // Point declared for nodal detection
    
    var score: Int = 0

    
    var array = [String](arrayLiteral: "Mercury", "Venus", "Earth", "Mars", "Jupiter", "Saturn", "Uranus", "Neptune", "Pluto" )
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
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
        let mercury = Planet(name: "Mercury", radius: 0.50, rotation: CGFloat(GLKMathDegreesToRadians(22)), texture: UIImage(named: "art.scnassets/LowRes/mercury.jpg")!, distanceFromSun: 1.5)
        
        parentNode.addChildNode(createNode(from: mercury))
        
        sceneView.scene.rootNode.addChildNode(parentNode)
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
    func createNode(from planet: Planet) -> SCNNode {
        
        // Create a parent node which will hold bith text and planet together
        let parentNode = SCNNode()
        
        // Create a spherical geometry node and apply texture
        let sphereGeometry = SCNSphere(radius: planet.radius)
        sphereGeometry.firstMaterial?.diffuse.contents = planet.texture
        
        // Create a node to contain a planet inside the spherical geometry
        let planetNode = SCNNode(geometry: sphereGeometry)
        planetNode.position.z = -planet.distanceFromSun
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
        if planet.name != "sun"{
            // Particle Trace
            let planetOrbitLine = SCNParticleSystem(named: "planetOrbit.scnp", inDirectory: nil)!
            planetNode.addParticleSystem(planetOrbitLine)
            
            // Orbital rotation
            let rotateAction = SCNAction.rotateBy(x: 0, y:planet.rotation , z:0 , duration: 1)
            parentNode.runAction(.repeatForever(rotateAction))
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
        
        print("In handleTap")
        
        let results = self.sceneView.hitTest(gesture.location(in: gesture.view), types: ARHitTestResult.ResultType.featurePoint)
        guard let _: ARHitTestResult = results.first else {return}
        
        let tappedNode = self.sceneView.hitTest(gesture.location(in: gesture.view), options: [:])
        
        if !tappedNode.isEmpty {
            let node = tappedNode[0].node
            
            // DispatchQueue for threading and multi-threaded pooling
//            DispatchQueue.main.async {
//                if (node.name != "No name found!" && node.name != "No name to return"){
//                    self.setPlanetDetailText(node.name!)
//
//
//                    self.score+=1
//                }
//            }
            
            if (node.name != "No name found!" && node.name != "No name to return"){
                self.setPlanetDetailText(node.name!)


                self.score+=1
            }
            
            // Debug
            print("Score: ", score)
        }
    }
    
    
    // Function that sets the Info pane text
    func setPlanetDetailText(_ info: String){
        planetDetailText.text = info
    }

    
    
    

}


