//
//  ViewController.swift
//  Learn

import UIKit
import SceneKit
import ARKit

class ViewController: UIViewController, ARSCNViewDelegate {

    @IBOutlet var sceneView: ARSCNView!
    @IBOutlet var planetDetailText: UITextView!
    @IBOutlet var tapRec: UITapGestureRecognizer!
    
//    var nodesRendered = [SCNNode] ()
//    var center = CGPoint(x:UIScreen.main.bounds.size.width/2,y:UIScreen.main.bounds.size.height/2)
    var center :CGPoint?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Set the view delegate
        sceneView.delegate = self
        
        // Show statistics such as fps and timing information
        sceneView.showsStatistics = true
        
        // Create the whole Solar System AR model {Function}
        createSolarSystem()
        
        // Enable Auto lightning
        sceneView.autoenablesDefaultLighting = true
        
        // Provide a background milkyway image to the scene
        sceneView.scene.background.contents = UIImage(named: "art.scnassets/milky.jpg")!
        
        // Create and add a tap gesture recognizer to the scene
        tapRec = UITapGestureRecognizer(target: self, action: #selector(ViewController.handleTap(_:)))
        sceneView.addGestureRecognizer(tapRec)

        // Create a 2d coordinate in the middle of the screen for node detection location
        center = CGPoint(x:sceneView.bounds.midX,y:sceneView.bounds.midY)
        
        
//        let parentNode = SCNNode()
//        parentNode.position.z = -5
//
//        let mercury = Planet(name: "Mercury", radius: 0.50, rotation: CGFloat(GLKMathDegreesToRadians(22)), texture: UIColor.white, distanceFromSun: 0)
//         let planets = mercury
//        parentNode.addChildNode(createNode(from :mercury))
//        sceneView.scene.rootNode.addChildNode(parentNode)
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        // Create a session configuration
        let configuration = ARWorldTrackingConfiguration()

        // Run the view's session
        sceneView.session.run(configuration)
    }
    
    func createSolarSystem() {

        // Parent Node
        let parentNode = SCNNode()
        parentNode.position.z = -5
    
        // Planets
        // order = merc, venus, earth, Mars, Jupiter, Saturn, Uranus, Neptune, Pluto
        let mercury = Planet(name: "Mercury", radius: 0.10, rotation: CGFloat(GLKMathDegreesToRadians(22)), texture: UIImage(named: "art.scnassets/LowRes/mercury.jpg")!, distanceFromSun: 1.5)
        
        let venus = Planet(name: "Venus", radius: 0.23, rotation: CGFloat(GLKMathDegreesToRadians(18)), texture: UIImage(named: "art.scnassets/LowRes/venus.jpg")!, distanceFromSun: 2)
        
        let earth = Planet(name: "Earth", radius: 0.25, rotation: CGFloat(GLKMathDegreesToRadians(16)), texture: UIImage(named: "art.scnassets/LowRes/earth.jpg")!, distanceFromSun: 4)
        
        let mars = Planet(name: "Mars", radius: 0.15, rotation: CGFloat(GLKMathDegreesToRadians(2)), texture: UIImage(named: "art.scnassets/LowRes/mars.jpg")!, distanceFromSun: 5.5)
        
        let jupiter = Planet(name: "Jupiter", radius: 0.80, rotation: CGFloat(GLKMathDegreesToRadians(5)), texture: UIImage(named: "art.scnassets/LowRes/jupiter.jpg")!, distanceFromSun: 8)

        let saturn = Planet(name: "Saturn", radius: 0.75, rotation: CGFloat(GLKMathDegreesToRadians(9)), texture: UIImage(named: "art.scnassets/LowRes/saturn.jpg")!, distanceFromSun: 11)

        let uranus = Planet(name: "Uranus", radius: 0.46, rotation: CGFloat(GLKMathDegreesToRadians(10)), texture: UIImage(named: "art.scnassets/LowRes/uranus.jpg")!, distanceFromSun: 15)

        let neptune = Planet(name: "Neptune", radius: 0.45, rotation: CGFloat(GLKMathDegreesToRadians(13)), texture: UIImage(named: "art.scnassets/LowRes/neptune.jpg")!, distanceFromSun: 19)

        let pluto = Planet(name: "Pluto", radius: 0.05, rotation: CGFloat(GLKMathDegreesToRadians(15)), texture: UIImage(named: "art.scnassets/LowRes/pluto.jpg")!, distanceFromSun: 23)
        
        // The Sun and sunFlare animation
        let sun = Planet(name: "sun", radius: 0.5, rotation: CGFloat(5), texture: UIImage(named: "art.scnassets/sun_8k.jpg")!, distanceFromSun: 0)
        let sunFlare = SCNParticleSystem(named: "sunFlare.scnp", inDirectory: nil)!
        parentNode.addParticleSystem(sunFlare)
        
        let planets = [sun, mercury, venus, earth, mars, jupiter, saturn, uranus, neptune, pluto]
        
        for planet in planets {
            parentNode.addChildNode(createNode(from: planet))
        }
        
        // Light
//        let light = SCNLight()
//        light.type = .omni
//        let lightNode = SCNNode()
//        lightNode.light = light
//        lightNode.position.y = 3
//        parentNode.addChildNode(lightNode)
//        parentNode.light = light
        
        // Star particles
        let stars = SCNParticleSystem(named: "Stars.scnp", inDirectory: nil)!
        parentNode.addParticleSystem(stars)
        
        sceneView.scene.rootNode.addChildNode(parentNode)
        
    }
    
    func createTextNode(from planet: SCNNode, texture: UIImage) -> SCNNode {
        
        let textGeometry = SCNText(string: "\(planet.name ?? "no name")", extrusionDepth: 1.0)
        
        textGeometry.firstMaterial?.diffuse.contents = texture//UIImage(named: planet.texture)
        
        let textNode = SCNNode(geometry: textGeometry)
        
        textNode.position = planet.position
        textNode.position.y = planet.position.y + 0.5
        textNode.scale = SCNVector3(0.04, 0.04, 0.04)
        
        return textNode
    }
    
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
        parentNode.addChildNode(createTextNode(from: planetNode,texture: planet.texture))
        
        // Add axial rotation
//        let axisRotateAction = SCNAction.rotate(by: .pi/2, around: SCNVector3(0,1,0), duration: 1)
//        planetNode.runAction(.repeatForever(axisRotateAction))
        
        // Add orbital rotation to all planets except the sun and add action to parent node
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
    

    // Override to create and configure nodes for anchors added to the view's session.
/*    func renderer(_ renderer: SCNSceneRenderer, nodeFor anchor: ARAnchor) -> SCNNode? {
        let node = SCNNode()
     
        return node
    }
*/
    
//    func checkIfNodeDetectedInFrustumOfCameraView() {
//
//        guard let cameraPointOfView = sceneView.pointOfView  else {return}
//
//        for node in nodesRendered{
//
//            if sceneView.isNode(node, insideFrustumOf: cameraPointOfView) {
//                print("\(node.childNodes.first?.name ?? "Yes Name") Is in view of the Camera")
////                planetDetailText.text = node.childNodes.first?.name
//            }
////            else {
////                print("None of the planets are in view of the Camera")
////            }
//        }
//
//
//    }
//
//    // Check if scene rendered in any possibel way (for nodal detection)
//    func renderer(_ renderer: SCNSceneRenderer, updateAtTime time: TimeInterval) {
//
//        checkIfNodeDetectedInFrustumOfCameraView()
//
//    }
    
    func detectNode() -> String {
        
        let sceneHitTest = sceneView.hitTest(center!, options: nil)
        guard let hitNode = sceneHitTest.last?.node else {return "No name found!"}
        return hitNode.name ?? "No name to return"
        
    }
    
    
    func renderer(_ renderer: SCNSceneRenderer, updateAtTime time: TimeInterval) {
        
        let planetName = detectNode()
        if (planetName != "No Name Found" || planetName != "No name to return"){
            setPlanetDetailText(planetName)
        }
//        print(planetName + "\(center!.x,center!.y)")
        
    }
    
    @objc func handleTap(_ gesture: UITapGestureRecognizer) {
        let results = self.sceneView.hitTest(gesture.location(in: gesture.view), types: ARHitTestResult.ResultType.featurePoint)
        guard let _: ARHitTestResult = results.first else {return}
        
        let tappedNode = self.sceneView.hitTest(gesture.location(in: gesture.view), options: [:])
        
        if !tappedNode.isEmpty {
            let node = tappedNode[0].node
            setPlanetDetailText(node.name!)
            print(node.name ?? "Not a node")
        }
    }

    func setPlanetDetailText(_ info: String){
        planetDetailText.text = info
    }
}

extension Int {
    var degToRad: CGFloat {
        return CGFloat(self) * .pi / 180
    }
}
