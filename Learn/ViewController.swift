//
//  ViewController.swift
//  Learn

import UIKit
import SceneKit
import ARKit

class ViewController: UIViewController, ARSCNViewDelegate {

    @IBOutlet var sceneView: ARSCNView!
    

    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Set the view delegate
        sceneView.delegate = self
        
        // Show statistics such as fps and timing information
        sceneView.showsStatistics = true
        
//        let cube = SCNBox(width: 0.1, height: 0.1, length: 0.1, chamferRadius: 0.01)

//        let sphere = SCNSphere(radius: 0.2)
//
//        let material = SCNMaterial()
//
//        material.diffuse.contents = UIImage(named: "art.scnassets/sun.jpg")
//
//        sphere.materials = [material]
//
//        let node = SCNNode()
//
//        node.position = SCNVector3(x: 0, y: 0.5, z: -0.5)
//
//        node.geometry = sphere
//
//        sceneView.scene.rootNode.addChildNode(node)
//
//        textNode.removeFromParentNode()
//
//        let textGeometry = SCNText(string: "SUN: 149.6 mil km away from Earth", extrusionDepth: 1.0)
//
//        textGeometry.firstMaterial?.diffuse.contents = UIColor.red
//
//        textNode = SCNNode(geometry: textGeometry)
//
//        textNode.position = SCNVector3(0, 0.1, -0.5)
//
//        textNode.scale = SCNVector3(0.01, 0.01, 0.01)
//
//        sceneView.scene.rootNode.addChildNode(textNode)
        
        createSolarSystem()
        
        sceneView.autoenablesDefaultLighting = true
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        // Create a session configuration
        
        let configuration = ARWorldTrackingConfiguration()

        // Run the view's session
        sceneView.session.run(configuration)
    }
    
    func createSolarSystem(){
        
        // Parent Node
        let parentNode = SCNNode()
        parentNode.position.z = -3.5
        
        // Planets
        // order = merc, venus, earth, Mars, Jupiter, Saturn, Uranus, Neptune, Pluto
        let mercury = Planet(name: "Mercury", radius: 0.14, rotation: CGFloat(GLKMathDegreesToRadians(32)), texture: "art.scnassets/mercury.jpg", distanceFromSun: 1.3)
        
        let venus = Planet(name: "Venus", radius: 0.35, rotation: CGFloat(GLKMathDegreesToRadians(10)), texture: "art.scnassets/venus.jpg", distanceFromSun: 2)
        
        let earth = Planet(name: "Earth", radius: 0.5, rotation: CGFloat(GLKMathDegreesToRadians(18)), texture: "art.scnassets/earth.jpg", distanceFromSun: 7)
        
        let saturn = Planet(name: "Saturn", radius: 0.8, rotation: CGFloat(GLKMathDegreesToRadians(12)), texture: "art.scnassets/saturn.jpg", distanceFromSun: 12)
        
        // The Sun and sunFlare animation
        let sun = Planet(name: "sun", radius: 0.3, rotation: CGFloat(0), texture: "art.scnassets/sun_8k.jpg", distanceFromSun: 0)
        
        let sunFlare = SCNParticleSystem(named: "sunFlare.scnp", inDirectory: nil)!
        parentNode.addParticleSystem(sunFlare)
        
        let planets = [sun, mercury, venus, earth, saturn]
        
        for planet in planets{
            parentNode.addChildNode(createNode(from: planet))
        }
        

        // Light
//        let light = SCNLight()
//        light.type = .omni
//        parentNode.light = light
        
        // Star particles
        let stars = SCNParticleSystem(named: "Stars.scnp", inDirectory: nil)!
        parentNode.addParticleSystem(stars)
        
        sceneView.scene.rootNode.addChildNode(parentNode)
    }
    
    func createTextNode(from string: String) -> SCNNode {
        let text = SCNText(string: string, extrusionDepth: 0.1)
        text.font = UIFont.systemFont(ofSize: 1.0)
        text.flatness = 0.01
        text.firstMaterial?.diffuse.contents = UIColor.white
        
        let textNode = SCNNode(geometry: text)
        
        let fontSize = Float(0.04)
        textNode.scale = SCNVector3(fontSize, fontSize, fontSize)
        
        return textNode
    }
    
    func createNode(from planet: Planet) -> SCNNode {
        
        let parentNode = SCNNode()
        var textNode = SCNNode()
        
        let sphereGeometry = SCNSphere(radius: planet.radius)
        sphereGeometry.firstMaterial?.diffuse.contents = planet.texture
        
        let planetNode = SCNNode(geometry: sphereGeometry)
        planetNode.position.z = -planet.distanceFromSun
        planetNode.name = planet.name
        parentNode.addChildNode(planetNode)
     
        if planet.name == "Saturn" {
            let ringGeometry = SCNTube(innerRadius: 1, outerRadius: 1.4, height: 0.05)
            ringGeometry.firstMaterial?.diffuse.contents = UIImage(named:"art.scnassets/saturn-ring.png")
            
            let ringNode = SCNNode(geometry: ringGeometry)
            ringNode.eulerAngles.x = Float(-20.degToRad)
            planetNode.addChildNode(ringNode)

        }
        
        let textGeometry = SCNText(string: "\(planet.name)", extrusionDepth: 1.0)
        
        textGeometry.firstMaterial?.diffuse.contents = UIImage(named: planet.texture)
        
        textNode = SCNNode(geometry: textGeometry)
        
        textNode.position = planetNode.position
        textNode.position.y = planetNode.position.y + 0.5
        
        textNode.scale = SCNVector3(0.05, 0.05, 0.05)
        
        parentNode.addChildNode(textNode)
        
        if planet.name != "sun"{
            let rotateAction = SCNAction.rotateBy(x: 0, y: planet.rotation, z: 0, duration: 1)
            
            parentNode.runAction(.repeatForever(rotateAction))
        }
        
        return parentNode
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        
        // Pause the view's session
        sceneView.session.pause()
    }
    

    // MARK: - ARSCNViewDelegate
    

//     Override to create and configure nodes for anchors added to the view's session.
    func renderer(_ renderer: SCNSceneRenderer, nodeFor anchor: ARAnchor) -> SCNNode? {
        let node = SCNNode()
     
        return node
    }
    
}

extension Int {
    var degToRad: CGFloat {
        return CGFloat(self) * .pi / 180
    }
}
