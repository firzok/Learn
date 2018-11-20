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

//        let sphere = SCNS phere(radius: 0.2)
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
        
//        createSolarSystem()
//        let parentNode = SCNNode()
//        parentNode.position.z = -5
        
        let mercury = Planet(name: "Mercury", radius: 0.50, rotation: CGFloat(GLKMathDegreesToRadians(0)), texture: UIColor.white, sepTexture: UIImage(named: "art.scnassets/mercury.jpg")!,  distanceFromSun: 0)
        let m = createNode(from :mercury)
        m.position.z = -5
        sceneView.scene.rootNode.addChildNode(m)
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
        parentNode.position.z = -5
    
        // Planets
        // order = merc, venus, earth, Mars, Jupiter, Saturn, Uranus, Neptune, Pluto
        let mercury = Planet(name: "Mercury", radius: 0.10, rotation: CGFloat(GLKMathDegreesToRadians(22)), texture: UIColor.white, sepTexture: UIImage(named: "")!, distanceFromSun: 1.5)
        
        let venus = Planet(name: "Venus", radius: 0.23, rotation: CGFloat(GLKMathDegreesToRadians(18)), texture: UIColor.darkGray, sepTexture: UIImage(named: "")!, distanceFromSun: 2)
        
        let earth = Planet(name: "Earth", radius: 0.25, rotation: CGFloat(GLKMathDegreesToRadians(16)), texture: UIColor.green, sepTexture: UIImage(named: "")!, distanceFromSun: 4)
        
        let mars = Planet(name: "Mars", radius: 0.15, rotation: CGFloat(GLKMathDegreesToRadians(2)), texture: UIColor.red, sepTexture: UIImage(named: "")!, distanceFromSun: 5.5)
        
        let jupiter = Planet(name: "Jupiter", radius: 0.80, rotation: CGFloat(GLKMathDegreesToRadians(5)), texture: UIColor.blue, sepTexture: UIImage(named: "")!, distanceFromSun: 8)
        
        let saturn = Planet(name: "Saturn", radius: 0.75, rotation: CGFloat(GLKMathDegreesToRadians(9)), texture: UIColor.brown, sepTexture: UIImage(named: "")!, distanceFromSun: 11)
        
        let uranus = Planet(name: "Uranus", radius: 0.46, rotation: CGFloat(GLKMathDegreesToRadians(10)), texture: UIColor.purple, sepTexture: UIImage(named: "")!, distanceFromSun: 15)
        
        let neptune = Planet(name: "Neptune", radius: 0.45, rotation: CGFloat(GLKMathDegreesToRadians(13)), texture: UIColor.cyan, sepTexture: UIImage(named: "")!, distanceFromSun: 19)
        
        let pluto = Planet(name: "Pluto", radius: 0.05, rotation: CGFloat(GLKMathDegreesToRadians(15)), texture: UIColor.yellow, sepTexture: UIImage(named: "")!, distanceFromSun: 23)
        
        // The Sun and sunFlare animation
//        let sun = Planet(name: "sun", radius: 0.5, rotation: CGFloat(5), texture: UIColor.orange, sepTexture: UIImage(named: "")!, distanceFromSun: 0)
        
        let sunFlare = SCNParticleSystem(named: "sunFlare.scnp", inDirectory: nil)!
        parentNode.addParticleSystem(sunFlare)
        
        let planets = [mercury, venus, earth, mars, jupiter, saturn, uranus, neptune, pluto]
        
        for planet in planets{
            parentNode.addChildNode(createNode(from: planet))
        }
        

        // Light
//        let lightNode = SCNNode()
        let light = SCNLight()
        light.type = .omni
        parentNode.light = light
//        lightNode.light = light
//        lightNode.position.y = parentNode.position.y + 1
//        parentNode.addChildNode(lightNode)
        
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
        sphereGeometry.firstMaterial?.diffuse.contents = planet.sepTexture
        
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
        
        textGeometry.firstMaterial?.diffuse.contents = planet.texture//UIImage(named: planet.texture)
        
        textNode = SCNNode(geometry: textGeometry)
        
        textNode.position = planetNode.position
        textNode.position.y = planetNode.position.y + 0.5
        
        textNode.scale = SCNVector3(0.05, 0.05, 0.05)
        
        parentNode.addChildNode(textNode)
        
        let axisRotateAction = SCNAction.rotate(by: .pi/2, around: SCNVector3(0,1,0), duration: 1)
        planetNode.runAction(.repeatForever(axisRotateAction))
        
        if planet.name != "sun"{
            let rotateAction = SCNAction.rotateBy(x: 0, y:planet.rotation , z:0 , duration: 1)
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

